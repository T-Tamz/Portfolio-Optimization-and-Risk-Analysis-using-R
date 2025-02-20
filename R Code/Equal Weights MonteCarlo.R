
# Bring in dependencies
library("httr")
library("jsonlite")
library("keyring")
library("dplyr")
library("ggplot2")
library("plotly")
library("quantmod")


# Get & Format Price History Data
tickers = c("NVDA","GS","LLY", "CVX", "COST")

for(i in 1:length(tickers)){
  url <- paste0("https://api.stockdata.org/v1/data/eod?symbols=",
                tickers[i],
                "&sort=asc&api_token=",
                keyring::key_get("STOCK_DATA_KEY")
  )

  price_history <- GET(url)
  
  ticker_price_data <- data.frame(fromJSON(rawToChar(price_history$content))$data) #converting into data frame
  
  if(i == 1){
    allData <- ticker_price_data[, c("date","close")] #Specify Columns
  }else{
    allData <-cbind(allData, ticker_price_data$close) #Bind into all data
  }
  
}

colnames(allData) <- c("Date",tickers)


# Get Daily Returns and Summary Data
expected_returns = NULL
standard_deviations = NULL

for(t in tickers){
  
  new_column_name = paste0(t, "_return")
  
  allData <- allData |>
    mutate(!!new_column_name :=(get(t) - lag(get(t))) / lag(get(t))) #Calculation for returns

  expected_returns <- cbind(expected_returns, mean(allData[-1, new_column_name]))
  standard_deviations <-  cbind(standard_deviations, sd(allData[-1, new_column_name]))
} 

colnames(expected_returns) <- tickers
colnames(standard_deviations) <- tickers

variances <- standard_deviations**2
modified_Sharpe_ratio <- expected_returns / standard_deviations


# Calculate X an Variance-Covariance Matrices

xDf <- allData[-1,-(1:(length(tickers)+1))]

colnames(xDf) <- tickers

for(t in tickers){
  xDf <- xDf |>
    mutate(!!t := get(t) - expected_returns[1,t])
}

xMatrix <- data.matrix(xDf)
xMatrixTranspose <- t(xMatrix)


varCovar <- (xMatrixTranspose %*% xMatrix) / (nrow(xDf) -1)


# Simulate Multiple Portfolio Weights

num_Of_Portfolios <- 5000

multiple_Weight <- xDf[(1:num_Of_Portfolios),]


for(t in tickers){
  multiple_Weight <- multiple_Weight |>
    mutate(!!t := runif(num_Of_Portfolios))
}

multiple_Weight$total_Of_Randoms <- rowSums(multiple_Weight)

weight_Col_Names <- c()

for(t in tickers){
  new_column_name <- paste0(t, "weight")
  weight_Col_Names <- c(weight_Col_Names, new_column_name)
  
  multiple_Weight <- multiple_Weight |>
    mutate(!!new_column_name := get(t) / total_Of_Randoms)
}



# Expected Return and Volatility For Different Weighted portfolio

for(i in 1:nrow(multiple_Weight)){
  weights <- data.matrix(multiple_Weight[i,weight_Col_Names])
  
  multiple_Weight[i,("expected_return")]<- sum(weights *expected_returns)
  
  multiple_Weight[i,("volatility")] <- sqrt((weights %*% varCovar) %*% t(weights))
  
}

multiple_Weight$sharpe_ratio <- multiple_Weight$expected_return / multiple_Weight$volatility

multiple_Weight[, c(weight_Col_Names, "expected_return","volatility")] <- round(multiple_Weight[ ,c(weight_Col_Names, "expected_return","volatility")] *100, 4)



# Generate Interactive Efficient Frontier Chart
generalPlot <- function(data,knownaes) {
  match_aes <- intersect(names(data), knownaes)
  my_aes_list <- purrr::set_names(purrr::map(match_aes, rlang::sym), match_aes)
  my_aes <- rlang::eval_tidy(quo(aes(!!!my_aes_list)))
  return(my_aes)
}

graph <- multiple_Weight |>
  ggplot(aes(x=volatility, y=expected_return)) +
  geom_point(aes(color=sharpe_ratio))+
  generalPlot(multiple_Weight, weight_Col_Names)+
  scale_colour_gradient(low = "red", high = "blue") +
  theme_classic()+
  theme(axis.title = element_text(size = 14),
        plot.title = element_text(size = 16),
        axis.line=element_line(color="white"),
        text = element_text(color = "white"),
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black"),
        legend.background = element_rect(fill = "black"),
  )+
  xlab("Volatility (%)")+
  ylab("Expected Daily Return (%)")+
  ggtitle("Efficient Frontier (Modern Portfolio Theory)")


ggplotly(graph)




#Montecarlo Simulation
num_simulations <- 1000    # Number of simulated paths
num_days <- 252 * 10       # Simulating 10 years (252 trading days per year)
initial_investment <- 100000  # $100,000 starting value

# Create matrix to store simulated portfolio values
portfolio_simulations <- matrix(0, nrow = num_days, ncol = num_simulations)

# Get portfolio expected return and volatility
portfolio_return <- mean(expected_returns)          #average returns
portfolio_volatility <- sqrt(mean(diag(varCovar)))  #average volatility

# Set seed for reproducibility
set.seed(42)

# Simulate random portfolio growth paths
for (i in 1:num_simulations) {
  daily_returns <- rnorm(num_days, mean = portfolio_return / 252, sd = portfolio_volatility / sqrt(252))
  portfolio_values <- cumprod(1 + daily_returns) * initial_investment  # Apply returns to initial investment
  portfolio_simulations[, i] <- portfolio_values  # Store in matrix
}

# Convert to data frame for visualization
simulated_df <- as.data.frame(portfolio_simulations)
simulated_df$day <- 1:num_days

# Convert to long format for ggplot
library(tidyr)

simulated_df_long <- pivot_longer(simulated_df, cols = -day, 
                                  names_to = "simulation",
                                  values_to = "portfolio_value")

# Plot Monte Carlo Portfolio Growth Paths
mc_growth_plot <- ggplot(simulated_df_long, aes(x = day, 
                                                y = portfolio_value, 
                                                group = simulation, 
                                                color = simulation)) +
  geom_line(alpha = 0.5) +
  theme_minimal() +
  labs(
    title = "Monte Carlo,Equal weights Portfolio Value Simulations",
    x = "Days",
    y = "Portfolio Value ($)"
  ) +
  theme(legend.position = "none")


ggplotly(mc_growth_plot)




#Calculate Value at risk & Conditional Value at risk 
final_portfolio_values <- portfolio_simulations[nrow(portfolio_simulations), ]

# Define confidence level (5% worst-case scenario)
confidence_level <- 0.05  

# Compute 5% Value at Risk (VaR)
VaR_5 <- quantile(final_portfolio_values, confidence_level)

# Compute 5% Conditional Value at Risk (CVaR)
CVaR_5 <- mean(final_portfolio_values[final_portfolio_values <= VaR_5])

# Print results
cat("5% Value at Risk (VaR):", round(VaR_5, 2), "\n")
cat("5% Conditional Value at Risk (CVaR):", round(CVaR_5, 2), "\n")



final_values_df <- data.frame(final_portfolio_values)

# Plot distribution of final portfolio values with VaR & CVaR
VaR_plot <- ggplot(final_values_df, aes(x = final_portfolio_values)) +
  geom_histogram(aes(y = ..density..), bins = 50, fill = "blue", alpha = 0.5) +
  geom_vline(xintercept = VaR_5, color = "red", linetype = "dashed", size = 1) +  # VaR line
  theme_minimal() +
  labs(
    title = "Value at Risk (VaR) & Conditional Value at Risk (CVaR)",
    x = "Final Portfolio Value ($)",
    y = "Density"
  ) +
  annotate("text", x = VaR_5, y = 0.00005, label = paste("VaR (5%) = $", round(VaR_5, 2)), color = "red", angle = 90, vjust = -1) +
  annotate("text", x = CVaR_5, y = 0.0001, label = paste("CVaR (5%) = $", round(CVaR_5, 2)), color = "blue", angle = 90, vjust = -1)

# Convert to interactive plot
ggplotly(VaR_plot)

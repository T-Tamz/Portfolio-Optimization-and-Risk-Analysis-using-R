# Portfolio Optimization and Risk Analysis using R

**Project Description:**
This project applies Modern Portfolio Theory (MPT) and Monte Carlo simulations to analyze an example investment portfolio using R. The goal is to determine the efficient frontier, optimize the portfolio for the highest Sharpe ratio, compare it to an equal-weighted portfolio as a baseline, and assess risk exposure using Value at Risk (VaR) and Conditional Value at Risk (CVaR). The analysis leverages real-world financial data obtained from the Stockdata.org API to make informed decisions about portfolio performance and risk.

## **Data Set**
Source: Stockdata.org API

Historical Data: End-of-day stock prices used to calculate returns and volatility.

Assets Analyzed:
- NVIDIA (NVDA)
- Goldman Sachs (GS)
- Eli Lilly (LLY)
- Chevron (CVX)
- Costco (COST)



## **Key Metrics Used**

- Expected Return & Volatility: Estimated from historical stock returns to determine portfolio performance.

- Sharpe Ratio: Measures risk-adjusted returns to find the most efficient portfolio.

- Efficient Frontier: A graphical representation of the optimal risk-return tradeoff for different portfolio allocations.

- Monte Carlo Simulations: Used to project portfolio performance over time under different conditions.

- Value at Risk (VaR) and Conditional Value at Risk (CVaR): Key risk measures assessing potential losses at a 5% confidence level.

## **Key Findings**

### Efficient Frontier Analysis

- 5,000 portfolios with randomly assigned weight allocations were simulated to analyze the efficient frontier.

- The efficient frontier visually maps out the optimal portfolios, helping to balance return against risk.

- The portfolio with the highest Sharpe ratio was identified as the most efficient based on risk-adjusted return.

![Efficient Frontier](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Effecient%20frontier/Effecient%20Frontier%20.png)

### Monte Carlo Simulations

**1. Optimized Portfolio (Highest Sharpe Ratio)**

- A 10-year Monte Carlo simulation (252 trading days per year) was performed on the portfolio with the highest Sharpe ratio.

- Initial investment: $100,000

#### Simulation methodology:

- Daily returns were simulated based on the expected return and volatility of the optimized portfolio.

- The simulation projected possible portfolio values over time.

- Findings: The optimized portfolio generally showed a more stable upward trend with a lower probability of extreme losses compared to the equal-weight portfolio.

 ![Montecarlo Sharp Ratio](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Montecarlo%20Optimized%20Sharpe/Montecarlo%20Optimized.png)

**2. Equal Weight Portfolio (Baseline)**

- A Monte Carlo simulation was performed on a baseline equal-weight portfolio.

- Key difference: Unlike the optimized portfolio, all assets had equal allocation, providing a comparative reference.

#### Results:

- The distribution of final portfolio values was wider, indicating higher dispersion and risk.

- Compared to the optimized portfolio, the equal-weight strategy had a slightly higher probability of large losses.

  ![Montecarlo Equal Weight](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Montecarlo%20equal%20weights/Equal%20weights%20motecarlo.png)

#### Risk Analysis: Value at Risk (VaR) & Conditional Value at Risk (CVaR)

- 5% VaR: Represents the potential loss in the worst 5% of cases.

- 5% CVaR: Measures the average loss in the worst 5% of cases, providing a deeper look into extreme downside risks.

#### Risk Metrics Comparison

| Portfolio Type              | VaR (5%)    | CVaR (5%)    |
|-----------------------------|------------|-------------|
| Equal Weights               | $90,760.88 | $88,270.07  |
| Optimized (Sharpe Ratio)    | $96,380.40 | $94,998.79  |
 

#### Key Insights:

- The optimized portfolio had a higher VaR and CVaR, meaning that even in adverse conditions, it maintained better performance.

- Less extreme downside risk was observed for the optimized portfolio compared to the equal-weight allocation.

 (Insert VaR & CVaR Analysis for Equal Weight Portfolio here)
 (Insert VaR & CVaR Analysis for Optimized Portfolio here)


## Summary of Findings

- The efficient frontier helped identify the most efficient portfolios in terms of risk-return tradeoff.

- The portfolio with the highest Sharpe ratio outperformed the equal-weight portfolio in Monte Carlo simulations, demonstrating the value of optimization.

- Risk metrics (VaR & CVaR) confirmed that the optimized portfolio is more resilient to extreme market downturns, making it a better investment choice for risk-averse investors.

This project highlights the importance of portfolio optimization and risk management in constructing efficient investment strategies. Future enhancements could include:

- Dynamic rebalancing strategies to account for changing market conditions.

- Alternative risk models such as fat-tailed distributions or stress testing.

This analysis provides valuable insights into modern investment strategies and their impact on portfolio performance and risk.

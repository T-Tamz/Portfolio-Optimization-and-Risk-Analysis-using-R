# Portfolio Optimization and Risk Analysis using R

**Project Description:**
This project applies Modern Portfolio Theory (MPT) and Monte Carlo simulations to analyze an example investment portfolio using R. The goal is to determine the efficient frontier, optimize the portfolio for the highest Sharpe ratio, compare it to an equal-weighted portfolio as a baseline, and assess risk exposure using Value at Risk (VaR) and Conditional Value at Risk (CVaR). The analysis leverages real-world financial data obtained from the Stockdata.org API to make informed decisions about portfolio performance and risk.

## **Data Set**
**Source:** Stockdata.org API

**Historical Data:** End-of-day stock prices used to calculate returns and volatility.

**Note:** Example diversified portfolio

### Portfolio Asset Selection

| Stock         | Ticker | Sector                 | Reason for Inclusion                                        |
|--------------|--------|------------------------|-------------------------------------------------------------|
| NVIDIA       | NVDA   | Technology             | Dominant in GPU market, key player in AI and data centers  |
| Goldman Sachs| GS     | Financials             | Investment banking leader, benefits from interest rate cycles |
| Eli Lilly    | LLY    | Healthcare             | Strong pharma pipeline, leading in obesity & diabetes drugs |
| Chevron      | CVX    | Energy                 | Oil & gas giant with dividends, inflation hedge            |
| Costco       | COST   | Consumer Discretionary | Resilient business model, strong membership-based revenue  |

**Reasoning:** This portfolio is well-diversified across multiple sectors, reducing risk while maintaining growth potential. NVIDIA (Technology) provides exposure to AI and cloud computing, Goldman Sachs (Financials) benefits from market cycles, Eli Lilly (Healthcare) offers defensive stability with a strong pharma pipeline, Chevron (Energy) serves as an inflation hedge with dividends, and Costco (Consumer Discretionary) ensures resilience through its membership-driven model. By combining cyclical (NVDA, GS, CVX) and defensive (LLY, COST) stocks, the portfolio balances growth and stability, minimizing risk while positioning for long-term gains.


## **Key Metrics Used**

- **Expected Return & Volatility:** Estimated from historical stock returns to determine portfolio performance.

- **Sharpe Ratio:** Measures risk-adjusted returns to find the most efficient portfolio.

- **Efficient Frontier:** A graphical representation of the optimal risk-return tradeoff for different portfolio allocations.

- **Monte Carlo Simulations:** Used to project portfolio performance over time under different conditions.

- **Value at Risk (VaR) and Conditional Value at Risk (CVaR):** Key risk measures assessing potential losses at a 5% confidence level.

## **Key Findings: Efficient Frontier**
![Efficient Frontier](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Effecient%20frontier/Effecient%20Frontier%20.png)

To understand the optimal balance between risk and return, 5,000 portfolios with randomly assigned weight allocations were simulated to analyze the efficient frontier. By optimizing for the Sharpe ratio, investors achieve better compensation per unit of risk compared to naive allocation strategies.

- The efficient frontier visually maps out the optimal portfolios, helping to balance return against risk.

- The portfolio with the highest Sharpe Ratio was identified as the most efficient based on risk-adjusted return.

| Ticker | Allocation (%) |
|--------|--------------|
| NVDA   | 1.7280       |
| GS     | 25.0392      |
| LLY    | 0.4197       |
| CVX    | 3.8898       |
| COST   | 68.9233      |

## **Why perform a Monte Carlo Simulation?**
After optimizing the portfolio for the highest Sharpe Ratio, a Monte Carlo simulation was conducted to assess long-term performance and risk under uncertainty.

### Key Reasons:
- **Models Market Uncertainty:** Simulates thousands of potential future price paths to account for unpredictable market conditions.
- **Projects Portfolio Growth:** Estimates possible portfolio values over a 10-year period (252 trading days per year).
- **Compares Risk Profiles:** Evaluates the equal-weight vs. optimized portfolio, showing how optimization improves stability.
- **Supports Risk Management:** Quantifies potential worst-case losses, aiding in informed decision-making.

Monte Carlo analysis confirms that the optimized portfolio offers higher returns with better risk control, making it a superior investment strategy.

## **Key Findings: Monte Carlo Simulations** 
### Simulation methodology:
A 10-year Monte Carlo simulation (252 trading days per year) was performed on both the equal-weight portfolio and the optimized portfolio (highest Sharpe ratio).

Initial investment: $100,000

- Daily returns were simulated based on the expected return and volatility of each portfolio.

- The simulation projected possible portfolio values over time.



### 1. Equal Weight Portfolio (Baseline)
- All assets were given equal allocation as a comparative reference.

Findings:
The distribution of final portfolio values was wider, indicating higher dispersion and risk. Higher probability of large losses compared to the optimized portfolio.

  ![Montecarlo Equal Weight](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Montecarlo%20equal%20weights/Equal%20weights%20motecarlo.png)

### 2. Optimized Portfolio (Highest Sharpe Ratio)
- The portfolio was optimized for maximum Sharpe Ratio, aiming for higher risk-adjusted returns.

Findings:
More stable upward trend over time. Lower probability of extreme losses, showing better risk control.

 ![Montecarlo Sharp Ratio](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Montecarlo%20Optimized%20Sharpe/Montecarlo%20Optimized.png)


### 3. Risk Analysis: Value at Risk (VaR) & Conditional Value at Risk (CVaR)

- 5% VaR: Represents the potential loss in the worst 5% of cases.

- 5% CVaR: Measures the average loss in the worst 5% of cases, providing a deeper look into extreme downside risks.

### Risk Metrics Comparison

| Portfolio Type              | VaR (5%)    | CVaR (5%)    |
|-----------------------------|------------|-------------|
| Equal Weights               | $90,760.88 | $88,270.07  |
| Optimized (Sharpe Ratio)    | $96,380.40 | $94,998.79  |
 

**5% VaR (Value at Risk)**

Key Insight: The optimized portfolio limits worst-case losses, reducing volatility risk.

- **Equal Weights Portfolio:** Drops to **$90,760.88**, meaning a potential loss of **$9,239.12**.
- **Optimized Portfolio:** Drops to **$96,380.40**, meaning a potential loss of **$3,619.60**.



**5% CVaR (Conditional Value at Risk)**

Key Insight: The optimized portfolio significantly reduces extreme downside risk, making it more resilient.

- **Equal Weights Portfolio:** Expected to fall to **$88,270.07**, an average loss of **$11,729.93**.
- **Optimized Portfolio:** Expected to fall to **$94,998.79**, an average loss of **$5,001.21**.

**Takeaways:**
- The optimized portfolio has lower expected losses in extreme downturns.
- Equal-weight portfolios are more vulnerable to large losses in bad market conditions.
- Investors seeking better risk-adjusted returns should consider optimization over equal-weight strategies.

### VaR/CVaR For Optimized Portfolio (Highest Sharpe Ratio)
 ![VaR/Cvar sharpe](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/6eade80fb92a889b1d1daa704ce943e5e2501e7d/Images/Montecarlo%20Optimized%20Sharpe/Optimized%20Var%20CVAR.png)

 ### VaR/CVaR For Equal Weighted Portfolio
 ![VaR/Cvar equal](https://github.com/T-Tamz/Portfolio-Optimization-and-Risk-Analysis-using-R/blob/bb076343f76c5ec8d20836a359d487ca9b7b9076/Images/Montecarlo%20equal%20weights/VAR%2CCVAR%20equal%20weights%20graph.png)



## Summary of Findings

- The efficient frontier helped identify the most efficient portfolios in terms of risk-return tradeoff.

- The portfolio with the highest Sharpe Ratio outperformed the equal-weight portfolio in Monte Carlo simulations, demonstrating the value of optimization.

- Risk metrics (VaR & CVaR) confirmed that the optimized portfolio is more resilient to extreme market downturns, making it a better investment choice for risk-averse investors.

This project highlights the importance of portfolio optimization and risk management in constructing efficient investment strategies. Future enhancements could include:

- Dynamic rebalancing strategies to account for changing market conditions.

- Alternative risk models such as fat-tailed distributions or stress testing.

This analysis provides valuable insights into modern investment strategies and their impact on portfolio performance and risk.

# m=Markowitz Model and Game Theory for Investment Strategies

## Abstract
Our project focuses on the comparison of four different portfolios comprised of ten financial instruments each as well as a combined portfolio in order to determine which, under the Markowitz portfolio strategy, are most effective at maximizing returns under assumed acceptable levels of risk. We use our individual training datasets to compute a Markowitz strategy `y` over a range of risk parameters, plot our strategies against one another, and subsequently use validation data to evaluate the best risk parameter and testing data to assess strategy. Moreover, we analyze these results against the game theory framework wherein there is no notion of risk.

Our results find that financial currencies, as stable assets, yield less competitive returns for the same level of risk. Therefore, portfolios that were comprised heavily or solely of these instruments did not give higher payoffs as investment strategies. Using stocks alone as investment instruments notably increases risk, but compensates for this lessened stability with greater returns at every level. This model has the added value of being an investment strategy guide to both the novice or experienced investor. One can look at our model and note that we created vastly different portfolios comprised of varying financial instruments, as well as a combined portfolio, and observe how and why certain portfolios yield significantly higher reward for the same level of risk.

## Introduction
The stock market has been around for well over 100 years. With an opportunity to increase one’s wealth over a period of time by investing in companies’ stocks the desire to maximize and minimize reward and risk, respectively, for each individual stock became a priority. The Markowitz model came about in 1952 to assist with stock portfolio optimization [2]. The Markowitz model can diversify and measure reward given assumed risk and thus inform the investor if an investment is a stable investment or too volatile to dive into. This can help prevent a dramatic loss in investment that could occur without the aid of an optimization model. This model will delve into the range of risk parameters, 1 and evaluate the most valuable stock portfolio for the investor based on the most optimal reward point for various levels of risk.

We have tested the recommended strategy that the Markowitz framework provided by comparing the behavior of four different portfolios with different investment strategies ranging from conservative to aggressive. Jimmy’s portfolio is comprised only of foreign currencies, Emma’s uses half foreign currencies and half stocks, Avery’s contains ten randomly chosen stocks from the S&P 500, and Ryan’s contains the top ten stocks of the Dow Jones. Our goal in choosing these combinations was to find the ideal balance of risk and reward, and to determine whether a portfolio with lots of stability and a lower, more dependable return would perform much better, much worse, or similarly to a portfolio with very risky yet lucrative elements.

## Problem Formulation
We fix our vector μ and seek to optimize the reward via
```bash
max y μ * reward - risk
```

where: 
- reward represents the portfolio's expected return. 
- risk denotes the portfolio's risk measure.

This project employs MATLAB for computation and visualization, using real-world financial data to evaluate and compare portfolio strategies under the Markowitz model.

## Installation and Usage

To run the project:

1. Ensure MATLAB is installed on your system.
2. Clone this repository.
3. Open MATLAB and execute the main script.

## Results
The project generates plots illustrating the Efficient Frontier for each portfolio and the combined portfolio, comparing their risk-reward profiles. Validation and testing data are used to assess and validate portfolio performance across different risk parameters.

## Conclusion
Through rigorous analysis and comparison, this project provides insights into portfolio optimization using the Markowitz model. It demonstrates how varying compositions of financial instruments impact portfolio performance under different risk scenarios, aiding investors in making informed decisions.

## Contributors
1. Jimmy Sitompul
2. Emma Dilley
3. Avery McCrystal
4. Ryan Kessler



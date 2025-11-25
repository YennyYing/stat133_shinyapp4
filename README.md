# Investing in the S&P 500

## Description
An interactive Shiny app that simulates the growth of an S&P 500 investment based on user-selected time period, annual contributions, contribution timing, and contribution growth rate.
Users can explore annual S&P 500 returns, visualize how their investment grows over time, and view a detailed investment table.

**Live App:** https://yuanying.shinyapps.io/stat133shinyapp2/

<img src="https://github.com/YennyYing/stat133_shinyapp4/blob/main/sp500_1.png" width="80%">
<img src="https://github.com/YennyYing/stat133_shinyapp4/blob/main/sp500_2.png" width="80%">
<img src="https://github.com/YennyYing/stat133_shinyapp4/blob/main/sp500_3.png" width="80%">


## Author
Yuan Ying  

## Date
05/02/2025  

---

## How It's Made:

This project combines **financial time series analysis** with **interactive visualization**.
The app retrieves historical S&P 500 prices via `tq_get()` from `tidyquant`, converts daily data to annual returns (1928–2024), and generates a forward-looking investment simulation based on user inputs:
- User-Defined Parameters
- Initial investment
- Annual contributions
- Contribution timing: beginning vs. end of year
- Annual growth rate of contributions
- Time horizon for simulation

**Core Outputs:**
- Annual S&P 500 return chart (interactive bar plot)
- Portfolio growth timeline (area + line plot)
- Detailed investment breakdown (interactive `DT::datatable()`)

Together these components allow users to compare strategies and understand the long-term impact of compounding, market volatility, and contribution patterns.

---

## Features
- Fully interactive investment dashboard built with Shiny
- Real S&P 500 historical data from Yahoo Finance
- Reactive pipeline for dynamic recalculation of investment scenarios
- Visual comparison of contribution strategies and market cycles
- Detailed table of yearly balances, contributions, and returns
- Clean, user-friendly UI design suitable for non-technical audiences

---

## Packages
```markdown
library(shiny)
library(tidyverse)
library(lubridate)
library(tidyquant)
library(plotly)
library(DT)
```
## Lessons Learned:
While developing this app, I gained experience in:

- Working with **financial time series** and calculating **annualized returns**
- Building scalable and efficient **reactive workflows** in Shiny
- Designing intuitive **data applications** with interactive UI components
- Integrating **ggplot2** with **plotly** for hybrid static–interactive graphics
- Translating real-world **investment formulas** into reproducible R code
- Managing performance and memory when processing **100 years of market data**

This work strengthened my skills in financial modeling, user-centered app design, and building interactive analytical tools in R.

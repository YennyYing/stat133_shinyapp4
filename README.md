# Investing in the S&P 500

## Description
An interactive Shiny app that simulates the growth of an S&P 500 investment based on user-selected time period, annual contributions, contribution timing, and contribution growth rate.
Users can explore annual S&P 500 returns, visualize how their investment grows over time, and view a detailed investment table.

**Link to project:** https://yuanying.shinyapps.io/stat133shinyapp2/
<img src="https://github.com/YennyYing/stat133_shinyapp1/blob/main/california%20crash%20explorer.png" width="50%"><img src="https://github.com/YennyYing/stat133_shinyapp1/blob/main/california%20crash%20explorer2.png" width="50%">
<img src="https://github.com/YennyYing/stat133_shinyapp1/blob/main/california%20crash%20explorer3.png" width="50%"><img src="https://github.com/YennyYing/stat133_shinyapp1/blob/main/california%20crash%20explorer4.png" width="50%">

## Author
Yuan Ying  

## Date
05/02/2025  

---

## How It's Made:

**Tech used:** R, Shiny, tidyverse, leaflet, plotly, sf

This project was built as an interactive Shiny web application using R. I used **tidyverse** for data wrangling and visualization, **sf** and **maps** packages to handle California county polygons for choropleth mapping, **leaflet** for interactive web maps, and **plotly** for dynamic exploratory plots.  

The crash data (2021–2023) was cleaned and preprocessed in R to allow filtering by year, location, county, and violation category. Interactive features include clickable crash points, choropleth maps showing county-level crash counts, and faceted trend plots by collision type and severity.  

This project showcases my ability to combine data cleaning, geospatial mapping, and interactive visualization to make complex datasets accessible and insightful.

## Features
- Interactive map showing crash locations in California
- County-level choropleth maps of crash counts
- Trend analysis and exploratory plots by year, county, type of collision, and violation category
- User-friendly filtering options

---

## Packages
```markdown
The app uses the following R packages (install via `install.packages()` if needed):
library(shiny)
library(tidyverse)
library(maps)
library(leaflet)
library(plotly)
library(sf)
```
## Lessons Learned:
Throughout the development of this project, I gained valuable experience in building interactive data applications and working with geospatial data in R. One key lesson was understanding how to efficiently handle large datasets and optimize Shiny reactivity to keep the app responsive. I also learned the importance of preprocessing data and transforming spatial objects correctly to avoid rendering issues in mapping libraries like `leaflet`.

This project strengthened my skills in integrating multiple R packages, structuring a Shiny app for clarity, and designing user-friendly visualizations. Most importantly, it taught me how to break down a complex dataset into accessible, meaningful insights through interactive visual exploration.

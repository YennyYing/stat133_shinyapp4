# Title: Investing in the S&P 500
# Description: This app simulates the growth of an S&P 500 investment over time based on user-defined contributions, returns, and growth rate.
# Author: Yuan Ying
# Date: 04/04/2025


# =======================================================
# Packages (you can use other packages if you want)
# =======================================================
library(shiny)
library(tidyverse)  # for data manipulation and graphics
library(lubridate)  # for working with dates
library(tidyquant)  # financial & quant functions
library(plotly)     # for web interactive graphics
library(DT)

# ======================================================
# Auxiliary objects/functions 
# (that don't depend on input widgets)
# ======================================================
# You may want to add one or more auxiliary objects for your analysis
# (by "auxiliary" we mean anything that doesn't depend on input widgets)

sp500 <- tq_get("^GSPC", from = "1928-01-03", to = "2024-12-31")

sp500_returns <- sp500 %>%
  mutate(year = as.numeric(format(date, "%Y"))) %>%
  group_by(year) %>%
  summarise(
    first_close = first(close),
    last_close = last(close),
    annual_return = (last_close - first_close) / first_close
  ) %>%
  ungroup()

# =======================================================
# Define UI for application
# =======================================================
ui <- fluidPage(
  titlePanel("Investing in the S&P 500"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("years_range", "Investment Period:",
                  min = 1928, max = 2024,
                  value = c(1990, 2015), sep = ""),
      numericInput("initial", "Initial Investment ($):", 
                   value = 5000, min = 0, step = 100),
      sliderInput("annual_contrib", "Annual Contribution ($):",
                  min = 0, max = 20000, value = 1000, step = 100),
      radioButtons("contrib_time", "Contribution Timing:",
                   choices = list("Beginning of Year" = "begin",
                                  "End of Year" = "end"),
                   selected = "begin", inline = TRUE),
      numericInput("growth_rate", "Annual Contribution Growth Rate (%):",
                   value = 3, min = 0, max = 100, step = 0.1)
    ),
    mainPanel(
      h3("Plot 1: S&P 500 Annual Returns"),
      plotlyOutput("plot1"),
      hr(),
      h3("Plot 2: Investment Balance Timeline"),
      plotlyOutput("plot2"),
      hr(),
      h3("Table: Investment Balance"),
      DTOutput("table")
    )
  )
)


# ======================================================
# Define server logic
# ======================================================
server <- function(input, output) {
  investment_data <- reactive({
    df <- sp500_returns %>%
      filter(year >= input$years_range[1],
             year <= input$years_range[2])
    
    g <- input$growth_rate / 100
    contrib_vec <- input$annual_contrib * (1 + g) ^ (0:(nrow(df) - 1))
    growth_factor <- 1 + df$annual_return
    
    balance <- numeric(nrow(df))
    
    if (input$contrib_time == "begin") {
      balance[1] <- (input$initial + contrib_vec[1]) * growth_factor[1]
      for (i in 2:nrow(df)) {
        balance[i] <- (balance[i-1] + contrib_vec[i]) * growth_factor[i]
      }
    } else {
      balance[1] <- input$initial * growth_factor[1] + contrib_vec[1]
      for (i in 2:nrow(df)) {
        balance[i] <- balance[i-1] * growth_factor[i] + contrib_vec[i]
      }
    }
    
    df %>%
      mutate(contribution = round(contrib_vec, 2),
             annual_return = round(df$annual_return, 3),
             balance = round(balance, 2))
  })
  
  # ------------------------------------------------------------
  # Plot (bar-chart of annual returns)
  # (adapt code to make a timeline according to your analysis!!!)
  # ------------------------------------------------------------
  output$plot1 <- renderPlotly({
    sp500_returns %>%
      mutate(selected = year >= input$years_range[1] & year <= input$years_range[2]) %>%
      ggplot(aes(x = year, y = annual_return, fill = selected)) +
      geom_col()+
      scale_fill_manual(values = c("TRUE" = "yellow", "FALSE" = "gray")) +
      scale_y_continuous(labels = scales::percent) +
      labs(x = "Year", y = "Annual Return", fill = "Selected")
  })

  # ------------------------------------------------------------
  # Plot (timeline of investment balance)
  # (adapt code to make a timeline according to your analysis!!!)
  # ------------------------------------------------------------
  output$plot2 <- renderPlotly({
    ggplot(investment_data(), aes(x = year, y = balance)) +
      geom_area(stat = "identity", fill = "red", alpha = 0.5)+
      geom_line(color = "darkred", linewidth = 1.2) +
      labs(title = paste("Annual Performance", input$years_range[1], "-", input$years_range[2]),
           x = "Year", y = "Investment Balance ($)")
  })
  
  # ------------------------------------------------------------
  # Table
  # (adapt code to display appropriate table!!!)
  # ------------------------------------------------------------
  output$table <- renderDT({
    investment_data() %>%
      transmute(
        year,
        return = annual_return,
        balance
      )
  }, options = list(pageLength = 10, lengthMenu = c(5, 10, 20)))
}
# Run the application 
shinyApp(ui = ui, server = server)

#
# This is the user-interface definition of a Shiny web application
# for Understanding Regression towards Mean.
# 
# You can run the application by clicking 'Run App' in RStudio.
#
# Find out more about building applications with Shiny here:
#    http://shiny.rstudio.com/
#
# Jiangbin Yang
# November 11, 2017
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Understanding Regression towards Mean"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("log10SNR", "log10(SNR):",
                  min = -1, max = 1,
                  value = 0, step = 0.1),
      h3("Move the Slider")
    ),
    
    mainPanel(
      plotOutput("distPlot", width = "500px", height = "500px")
    )
  )
))

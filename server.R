#
# This is the server logic of a Shiny web application
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

shinyServer(function(input, output) {
  SNR <- reactive(10^input$log10SNR)
  
  output$distPlot <- renderPlot({
    set.seed(1111)
    x <- rnorm(100, sd=1)
    y <- x + rnorm(100, sd=sqrt(1/SNR()))
    
    # regulate input and output to the same scale:
    xStd <- (x - mean(x))/sd(x)
    yStd <- (y - mean(y))/sd(y)
    cor(xStd, yStd)
    
    plot(xStd, yStd, xlim=c(-3, 3), ylim=c(-3,3), 
         xlab="Standardized Input X", ylab="Standardized Output Y",
         main="Regression towards Mean")
    abline(0, 1, col="red", lty=3, lwd=2)
    abline(h=0, col="green", lwd=2)
    text(2, 2.7, paste("SNR =", round(SNR(), 2)))
    text(-2.5, 0.3, "Mean", col="green")
    
    fit <- lm(yStd ~ xStd + 0)
    abline(fit, col="blue", lwd=2)
    arrows(2, 2*fit$coefficients, 2, 0, length = 0.1, angle = 30, code = 2, 
           col = "blue", lty = 1, lwd = 1)
    arrows(-2, -2*fit$coefficients, -2, 0, length = 0.1, angle = 30, code = 2, 
           col = "blue", lty = 1, lwd = 1)
    text(2, -2, paste("Regression Slope =", round(fit$coefficients, 2)), col="blue")
  })
})

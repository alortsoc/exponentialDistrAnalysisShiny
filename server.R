
#initial values
library(ggplot2)
numExponentials <- 40

#calculates the mean of samplesPerSim exponentials
meanExponential <- function (simulations, samplesPerSim, lambda) {
    result <- NULL
    for (i in 1 : simulations) { 
        result <- c(result, mean(rexp(samplesPerSim, lambda)))
    }
    result
}

#creates a data frame to plot the convergence of the mean (Law of Large Numbers)
dataFrameToPlotConvergence <- function (simulations, lambda) {
  
    means <- NULL
    for (i in 2 : simulations) {
        means <- c(means, mean(meanExponential(i, numExponentials, lambda)))
    }
    data.frame(x = 2 : simulations, y = means)
}   

#plot the convergence with theoretical mean
plotMeanConvergence <- function (dataFrameToPlot, lambda) {
    
    g <- ggplot(dataFrameToPlot, aes(x = x, y = y)) 
    g <- g + geom_hline(yintercept = 1/lambda) + geom_line(size = 2) 
    g <- g + labs(x = "Number of simulations", y = "Sample mean") 
    g
}


#creates a data frame to plot the convergence of the mean (Law of Large Numbers)
dataFrameToPlotDist <- function(simulationsNumber, lambda) {
    
    dataToAdd <- meanExponential(simulationsNumber, numExponentials, lambda)
    data.frame(x = dataToAdd)
}

#plot averages of distributions of exponentials and the gaussian distribution the converge to
plotDistributions <- function(dataFrameToPlot, lambda) {
    
    expMean <- 1/lambda
    expStdDev <- 1/lambda
    
    g <- ggplot(dataFrameToPlot, aes(x = x)) 
    g <- g + geom_histogram(alpha = .20, binwidth=.3, colour = "black", aes(y = ..density..))
    g <- g + labs(x = "Exponential distribution mean average")
    g + stat_function(fun = dnorm, size = 2, args = list(mean = expMean, sd = expStdDev/sqrt(numExponentials)))
}


#renders mean convergence plot and gaussian convergence plot
shinyServer(function(input, output) {
  
    output$covergencePlot <- renderPlot(plotMeanConvergence(dataFrameToPlotConvergence(input$simulations, input$lambda), input$lambda))
    output$normalPlot <- renderPlot(plotDistributions(dataFrameToPlotDist(input$simulations, input$lambda), input$lambda))
})



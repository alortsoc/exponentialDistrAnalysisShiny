library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Exponential distribution analysis"),
    sidebarPanel(
        p("This page shows how Law of Large Numbers and Central Limit Theorem works applied to the the distribution of exponential distribution averages"),
        p("Two plots are displayed: one shows how sample mean will converge its theoretical value (as expected by Law of Large Numbers); the second one plots how the distribution of exponential distribution averages tends to be Gaussian (as expected by the Central Limit Theorem)"),
        p("It is possible to modify plots by changing the number of simulations performed and the lambda parameter of the averaged exponential distributions in below sliders:"),
        sliderInput("simulations", "Number of simulations to run", value = 500, min = 50, max = 1000, step = 50),
        sliderInput("lambda", "lambda value for averaged exponential distribution", value = 0.2, min = 0.01, max = 1, step = 0.1)
    ),
    mainPanel(
        h2("Exponential mean convergence plot:"),
        plotOutput("covergencePlot"),
        h2("Exponential distribution mean convergence to Gaussian distribution plot:"),
        plotOutput("normalPlot")
    )
))
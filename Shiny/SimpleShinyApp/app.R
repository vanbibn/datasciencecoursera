library(shiny)
ui <- fluidPage(
    sliderInput(inputId = "num", 
        label = "Pick a value for N", 
        value = 50, min = 20, max = 100),
    plotOutput(outputId = "hist")
)

server <- function(input, output) {
    output$hist <- renderPlot({
        title <- "N random normal values"
        hist(rnorm(input$num), main = title)
    })
}

shinyApp(ui, server)
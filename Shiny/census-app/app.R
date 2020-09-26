library(shiny)

source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)


# Define the UI
ui <- fluidPage(
    # Title the page
    titlePanel("censusVis"),
    
    # Describe the page layout
    sidebarLayout(
        # Design the side bar
        sidebarPanel(
            helpText("Create demographic maps with information from the 2010 US Census."),
            # add variable selector
            selectInput("var",
                        label = "Choose a varaible to display",
                        choices = list("Percent White",
                                       "Percent Black",
                                       "Percent Hispanic",
                                       "Percent Asian")
            ),
            # add ui for the slider range
            sliderInput("range",
                        label = "Range of interest:",
                        min = 0, max = 100,
                        value = c(0,100)
            )
        ),
        
        # Design the main panel
        mainPanel(
            # textOutput("selected_var"),
            # textOutput("selected_range"),
            
            # add map plot
            plotOutput("map")
        )
    )
)

# Define the server logic
server <- function(input, output) {
    # output$selected_var <- renderText({
    #     paste("You have selected", input$var)
    # })
    # output$selected_range <-  renderText({
    #     paste("You have chosen a range that goes from", 
    #           input$range[1], "to", input$range[2])
    # })
    
    # create the map object
    output$map <- renderPlot({
        data <- switch(input$var, 
                       "Percent White" = counties$white,
                       "Percent Black" = counties$black,
                       "Percent Hispanic" = counties$hispanic,
                       "Percent Asian" = counties$asian)
        color <- switch(input$var, 
                       "Percent White" = "darkgreen",
                       "Percent Black" = "black",
                       "Percent Hispanic" = "darkorange",
                       "Percent Asian" = "purple")
        
        percent_map(var = data,
                    color = color, 
                    legend.title = input$var,
                    min = input$range[1],
                    max = input$range[2])
    })
}

# Run the app
shinyApp(ui = ui, server = server)
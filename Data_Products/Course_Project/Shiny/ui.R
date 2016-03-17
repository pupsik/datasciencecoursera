library(shiny)
library(leaflet)
library(datasets)

ui <- fluidPage(
    titlePanel("Weather:Deviations from Mean Monthly Temperature"),
    mainPanel(leafletOutput("map")),
    fluidRow(column(4,
                
        sliderInput("slider", label=h3("Month"), min=1,max=12,value=1, step=1))
    ),
    
    #Drop Down Menu
    selectInput("selectyear",label = h3("Year"), choices = seq(2010,2015,1), selected=2010),
    selectInput("selectstate",label = h3("State"), choices = state.abb, selected="MA"),
    hr(),
    fluidRow(column(3, verbatimTextOutput("year"))),
    fluidRow(column(4, verbatimTextOutput("month"))),
    fluidRow(column(5, verbatimTextOutput("state")))
)
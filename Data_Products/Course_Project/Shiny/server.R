rm(list=ls())
gc()
library(rnoaa)
library(ggmap) #for reverse geocoding
library(datasets)
library(httr)
library(RODBC)
library(dplyr)
library(rgeos)
library(rgdal)
library(leaflet)
library(RColorBrewer)
library(rdrop2)


#dd="C:/Users/hom42612/Desktop/Coursera/Data_Products/Course_Project"

#Read in Shape Files
temp <- tempdir()
download.file("http://www.nws.noaa.gov/geodata/catalog/wsom/data/z_10nv15.zip",
            paste0(temp,"/z_10nv15.zip"), method="auto")

unzip(paste0(temp,"/z_10nv15.zip"), exdir=paste0(temp,"/z_10nv15"))
SHAPES <- readOGR(paste0(temp,"/z_10nv15/z_10nv15.shp"),"z_10nv15")

stateabb <- state.abb

temp <- tempdir()
token <- drop_auth() #readRDS("droptoken.rds")
drop_read_csv("/Public/MNTN_FULL_SHORTSAMPLE.csv", dest=temp, dtoken=token)
EXPORT <- read.csv(paste0(temp, "/MNTN_FULL_SHORTSAMPLE.csv"), header=TRUE, colClasses = "character")

EXPORT$PLOTVAL <- as.numeric(EXPORT$PLOTVAL)

#Read in min and max and calibrate the palette
pal <- colorNumeric(
    palette = "RdYlBu",
    domain = c(43.05605, -43.05605)
)

#Building a LEAFLET
server <- function(input,output){
    
    #Pick up the YEAR from the UI
    output$year <- renderPrint({(input$selectyear)})
    output$month <- renderPrint({input$slider})
    output$state <- renderPrint({input$selectstate})
    
     output$map <- renderLeaflet({
         year = input$selectyear
         month = input$slider
         state = input$selectstate
     
        #TABLE <- read.csv("https://dl.dropboxusercontent.com/s/6d6vbmr8odndbfe/SHP_MNTN_2001-01-01.csv?dl=0")
        TABLE <- EXPORT[EXPORT$YEAR==year & EXPORT$MONTH==month, ]
        TABLE$PLOTVAL <- TABLE$PLOTVAL*(-1)
        PLOTSHAPES <- SHAPES
        PLOTSHAPES@data <- TABLE
         
        PLOTSHAPES <- PLOTSHAPES[PLOTSHAPES$STATE ==state,]
        
             
         leaflet() %>% 
             addProviderTiles("CartoDB.Positron") %>%
             addPolygons(data=PLOTSHAPES,
                     fillColor = ~pal(PLOTVAL), 
                         fillOpacity = 0.9, 
                         color = "#FFFFFF", 
                         weight = 1,
                         smoothFactor=0.01)
         
         })
}






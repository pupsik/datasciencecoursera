---
title       : My Shiny Presentation
subtitle    : Weather - Deviations from Mean Monthly Temperatures
author      : Rita Linets
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []           # {mathjax, quiz, bootstrap}
ext_widgets : {rCharts: [libraries/leaflet]}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Shiny Application Description

The title of [my Shiny] (https://pupsik.shinyapps.io/Shiny/) application is Deviations from Mean Monthly Temperatures. 

The purpose of the application is to create a visualization that helps decide whether a current month in a chosen state is relatively more or less warm as compared to the historical mean in each public forecast zone within that state. 

--- .class #id 

## Data Sources and Data Description

The source of the data is the [National Oceanic and Atmospheric Administration] (http://www.noaa.gov/).

The series is monthly mean temperature in tens of degrees Celsius. 

The data are available at the weather station level at a monthly frequency. 


--- .class #id

## Data Cleaning and Assumptions

The data were pulled at the weather station level. Each weather station has a unique ID as well as latitude and longitude coordinates associated with them. 

The shapefiles I used are Public Forecast Zones (PFZ) shapefiles published by the NOAA. I then mapped each weather station to the appropriate (PFZ) and extrapolated data into PFZ-s that did not have a single weather station within them. 

I cleaned the data removing all data points that recorded temperature beyond known weather extremes. I then calculated mean temperatures and deviations from the means by month by PFZ between 1950 and 2015. 

The deviations from the mean temperatures represent my final dataset that appears on the map in my Shiny app. 

--- .class #id

<iframe src="./assets/widgets/leaflet.html" width=100% height=100% allowtransparency="true"> </iframe>














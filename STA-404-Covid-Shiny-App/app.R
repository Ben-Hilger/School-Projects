#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Loading Packages
library(shiny)
library(shinythemes)
library(tidyverse)
library(maps)            
library(ggmap)           
library(mapproj)
library(lubridate)
library(plotly)
library(tidyquant)

### DATA LOADING ###

# Reads the COVID data from the Ohio government website
covid_data = read_csv("https://coronavirus.ohio.gov/static/dashboards/COVIDSummaryData.csv")
# Reads the population data from the census website
population_data <- read_csv("https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv")

### GENERAL DATA CLEANING ###

# Cleans the COVID data to remove the total row and makes Onset Date a date object and Age Range a factor
covid_data <- covid_data %>% 
    filter(Sex != "Total") %>%
    mutate(OnsetDate = mdy(`Onset Date`),
           AgeFactor = factor(`Age Range`))

# Makes the county name lowercase
covid_data$County <- str_to_lower(covid_data$County)

# Filters/cleans the population data
population_data_ohio <- population_data %>% 
    filter(STNAME == "Ohio") %>% 
    filter(CTYNAME != "Ohio") %>% 
    select(CTYNAME, POPESTIMATE2019) %>% 
    mutate(County = str_remove_all(CTYNAME," County"))

## MAP DATA ###

# Gets the county long and lat data from map_data
county_map <- map_data("county")
ohio_county_map <- subset(county_map, county_map$region=="ohio")

### Tab 1: Ohio State Map & Tab 3: Comparison Bar Chart Data Cleaning ###

# Gets the number of cases, hospitalized, and dead based on County
OhioCovidDailyCount <- covid_data %>% 
    group_by(County) %>% 
    summarize(numberCases = sum(`Case Count`),
              numberHospitalized = sum(`Hospitalized Count`),
              numberDead = sum(`Death Due to Illness Count`))

OhioCovidDailyCount <- OhioCovidDailyCount %>% 
    # Makes the breaks based on the number of cases
    mutate(CasesCut = cut(numberCases,
                          breaks = c(0, 1000, 2500, 5000, 
                                     15000, 30000, 50000, signif(max(numberCases)+1000, 2))),
           # Makes the breaks based on the number hospitalized
           HosCut = cut(numberHospitalized,
                            breaks = c(0, quantile(numberHospitalized)[2:5],signif(max(numberHospitalized)+1000, 2))),
           # Makes the breaks based on the number dead
           DeadCut = cut(numberDead,
                             breaks = c(0, quantile(numberDead)[2:5], signif(max(numberDead)+1000, 2))))

# Makes the County column lowercase to merge
OhioCovidDailyCount$County <- str_to_lower(OhioCovidDailyCount$County)
population_data_ohio$County <- str_to_lower(population_data_ohio$County)

# Creates the case, hospital and death rate based on the population
OhioCasePop <- OhioCovidDailyCount %>% 
    inner_join(population_data_ohio,
                by=c("County" = "County")) %>% 
                mutate(CaseRate =
                           round(numberCases/POPESTIMATE2019*1000,2),
                       HosRate =
                           round(numberHospitalized/POPESTIMATE2019*1000,2),
                       DeathRate =
                           round(numberDead/POPESTIMATE2019*1000,2))

# Creates the color breaks for the population rates
OhioCasePop <- OhioCasePop %>% 
    mutate(CaseRateCut = cut(CaseRate,
                             breaks = c(0, quantile(CaseRate)[2:5], max(CaseRate)+100)),
           HosRateCut = cut(HosRate,
                            breaks = c(0, quantile(HosRate)[2:5], max(HosRate)+100)),
           DeathRateCut = cut(DeathRate,
                              breaks = c(0, quantile(DeathRate)[2:5], max(DeathRate)+100)))

# Merges the ohio county information, population rate and case information
ohio_county_map_covid <- merge(ohio_county_map, OhioCasePop,
                                by.x="subregion",
                                by.y="County")

# Renames the columns to increase readability
ohio_county_map_covid <- ohio_county_map_covid %>% 
    rename(County = subregion,
           `Number of Cases` = numberCases,
           `Number Dead` =  numberDead,
           `Number Hospitalized` = numberHospitalized,
           `Cases Rate per 1000 Residents` = CaseRate,
           `Death Rate per 1000 Residents` = DeathRate,
           `Hospitalization Rate per 1000 Residents` = HosRate)

# Converts the County back to the first letter being uppercase
ohio_county_map_covid$County <- paste(str_to_upper(substr(ohio_county_map_covid$County, 1, 1)), substr(ohio_county_map_covid$County, 2, str_length(ohio_county_map_covid$County)), sep="")
OhioCasePop$County <- paste(str_to_upper(substr(OhioCasePop$County, 1, 1)), substr(OhioCasePop$County, 2, str_length(OhioCasePop$County)), sep="")

## Tab 2: Bar Chart Data Cleaning ##

# Gets the daily number of cases, hospitalizations, and deaths for each county
OhioCovidDailyCountyCount <- covid_data %>% 
  group_by(County, OnsetDate) %>% 
  summarize(numberCases = sum(`Case Count`),
            numberHospitalized = sum(`Hospitalized Count`),
            numberDead = sum(`Death Due to Illness Count`))
# Converts the county column to lowercase
OhioCovidDailyCountyCount$County <- str_to_lower(OhioCovidDailyCountyCount$County)
population_data_ohio$County <- str_to_lower(population_data_ohio$County)
# Merges the population data and calculates the rate for cases, hospitalizations and deaths
OhioCovidDailyCountyCount <- OhioCovidDailyCountyCount %>% 
  inner_join(population_data_ohio,
             by=c("County" = "County")) %>% 
  mutate(CaseRate =
           numberCases/POPESTIMATE2019*1000,
         HosRate =
           numberHospitalized/POPESTIMATE2019*1000,
         DeathRate =
           numberDead/POPESTIMATE2019*1000)

## Tab 4: Age Comparisons Data Cleaning ##

# Gets the daily number of cases, hospitalizations, deaths for each age group
OhioCovidAge <- covid_data %>% 
  filter(`Age Range` != "Unknown") %>% 
  group_by(OnsetDate, County, `Age Range`) %>% 
  summarize(numberCases = sum(`Case Count`),
            numberHospitalized = sum(`Hospitalized Count`),
            numberDead = sum(`Death Due to Illness Count`))
# Converts the county column to lowercase
OhioCovidAge$County <- str_to_lower(OhioCovidAge$County)
# Merges the population data and calculates the rate for cases, hospitalizations and deaths
OhioCovidAge <- OhioCovidAge %>% 
  inner_join(population_data_ohio,
             by=c("County" = "County")) %>% 
  mutate(CaseRate =
           numberCases/POPESTIMATE2019*1000,
         HosRate =
           numberHospitalized/POPESTIMATE2019*1000,
         DeathRate =
           numberDead/POPESTIMATE2019*1000)

## Tab 5: Age Bar Comparison Data Cleaning ##

# Gets the daily number of cases, hospitalizations, deaths for each age group
OhioCovidAgeBar <- covid_data %>% 
  filter(`Age Range` != "Unknown") %>% 
  group_by(County, `Age Range`) %>% 
  summarize(numberCases = sum(`Case Count`),
            numberHospitalized = sum(`Hospitalized Count`),
            numberDead = sum(`Death Due to Illness Count`))
# Joins the population data and calculates the rates
OhioCovidAgeBar <- OhioCovidAgeBar %>% 
  inner_join(population_data_ohio,
             by=c("County" = "County")) %>% 
  mutate(CaseRate =
           numberCases/POPESTIMATE2019*1000,
         HosRate =
           numberHospitalized/POPESTIMATE2019*1000,
         DeathRate =
           numberDead/POPESTIMATE2019*1000)
# Creates the breaks for the numbers and rates
OhioCovidAgeBar <- OhioCovidAgeBar %>% 
  mutate(CaseRateCut = cut(CaseRate,
                           breaks = c(0,quantile(CaseRate)[2:5], max(CaseRate)+100)),
         HosRateCut = cut(HosRate,
                          breaks = c(quantile(HosRate)[2:5], max(HosRate)+100)),
         DeathRateCut = cut(DeathRate,
                            breaks = c(quantile(DeathRate)[4:5], signif(max(DeathRate)+50, 2))),
         CasesCut = cut(numberCases,
                        breaks = c(0, 100, 250, 500, 1500, 3000, 5000, 10000, max(numberCases)+1000)),
        HosCut = cut(numberHospitalized,
             breaks = c(0, 10, 50, 150, 300, 500, max(numberHospitalized)+100)),
        DeadCut = cut(numberDead,
            breaks = c(0, 1, 5, 10, 50, 150, 500, max(numberDead)+1000)))
# Makes the county start with an uppercase letter
OhioCovidAgeBar$County <- paste(str_to_upper(substr(OhioCovidAgeBar$County, 1, 1)), substr(OhioCovidAgeBar$County, 2, str_length(OhioCovidAgeBar$County)), sep="")

# Define UI for application that draws a histogram
ui <- navbarPage("STAT 404 COVID Dashboard", theme=shinytheme("united"),
                 
          # Creates the tab for the Ohio state map
          tabPanel("Ohio State COVID Map",
            headerPanel("Ohio State Map"),
            sidebarPanel(
            selectInput(inputId = "fillofinterest",
                        label= "Select response to explore:",
                        choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                        selected="Number of Cases")),
            mainPanel(plotlyOutput("distPlot"))),
          # Creates the tab for the response over times bar graph
          tabPanel("Responses Over Times",
              sidebarPanel(
              selectInput(inputId = "fillofinterest2",
                          label= "Select response to explore:",
                          choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                          selected="Number of Cases"),
              selectInput(inputId="County",
                          label="Please select the county to view",
                          choices = OhioCovidCounty$County,
                          selected="Butler"
                          ),
              selectInput(inputId = "type2",
                          label="Please select if you would like to view by Case Counts or the Rate:",
                          choices = c("Counts","Rate"),
                          selected = "Counts"),
              checkboxInput(inputId="add_ma", label = "Include Moving Average"),
              sliderInput(inputId = "ma_amount", label = "Number of days in moving average: ",
                          value = 7, min = 1, max = 21, step = 1)),
              mainPanel(plotOutput("barchart")),
              ),
          # Creates the tab for the comparison bar chart graph
          tabPanel("Comparison Bar Charts",
              sidebarPanel(
              selectInput(inputId = "fillofinterest3",
                              label= "Select response to explore:",
                              choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                              selected="Number of Cases"),
              selectInput(inputId = "type3",
                          label="Please select if you would like to view by Case Counts or the Rate:",
                          choices = c("Counts","Rate")),
              selectInput(inputId = "organizeBy",
                          label= "Select response to organize the bar chart by:",
                          choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                          selected="Number of Cases")),
              mainPanel(plotOutput("combarchart", height="100%"))),
          # Creates the tab for the age facet graph
          tabPanel("Age Comparisons",
              sidebarPanel(
              selectInput(inputId = "fillofinterest4",
                          label= "Select response to explore: ",
                          choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                          selected="Number of Cases"),
              selectInput(inputId="County2",
                          label="Please select the county to view:",
                          choices = OhioCovidCounty$County,
                          selected="Butler"),
              selectInput(inputId = "type4",
                            label="Please select if you would like to view by Case Counts or the Rate:",
                            choices = c("Counts","Rate")),
              checkboxInput(inputId="add_ma2", label = "Include Moving Average"),
              sliderInput(inputId = "ma_amount2", label = "Number of days in moving average: ",
                          value = 7, min = 1, max = 21, step = 1)),
              mainPanel(plotOutput("ageComparison"))),
          # Creates the tab for the age range and county comparison graph
          tabPanel("Age Bar Chart Comparisons",
               sidebarPanel(
                   selectInput(inputId = "fillofinterest5",
                               label= "Select response to explore: ",
                               choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                               selected="Number of Cases"),
                   selectInput(inputId = "ageRange",
                               label = "Please Select the Age Range Desired:",
                               choices = OhioCovidAgeBar$`Age Range`,
                               selected=OhioCovidAgeBar$`Age Range`[0]),
                   selectInput(inputId = "organizeBy2",
                               label= "Select response to organize the bar chart by: ",
                               choices = c("Number of Cases","Number Hospitalized","Number Dead"),
                               selected="Number of Cases")),
               mainPanel(plotOutput("ageBarGraph"))
               ),
          # Creates the tab for the references and resources used in this project
          tabPanel("References",
                sidebarPanel(   
                  # Puts the designers name and date of completion in the sidebar
                  h4("Designed by:"),
                  h2("Ben Hilger"),
                  h3("Date Constructed: December 4th, 2020")),
                mainPanel(
                  # Puts all of the packages and references used in the main panel
                  h3("Data Sources Used:"),
                  h4("Ohio Covid Data: https://coronavirus.ohio.gov/static/dashboards/COVIDSummaryData.csv"),
                  h4("Census Population Data: https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv"),
                  h3("R Packages Used:"),
                  h4("R Core Team (2019). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL
    https://www.R-project.org/"),
                  h4("Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R package version 1.5.0.
    https://CRAN.R-project.org/package=shiny"),
                  h4("Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686"),
                  h4("Original S code by Richard A. Becker, Allan R. Wilks. R version by Ray Brownrigg. Enhancements by Thomas P Minka and Alex Deckmyn. (2018). maps: Draw
    Geographical Maps. R package version 3.3.0. https://CRAN.R-project.org/package=maps"),
                  h4("D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal, 5(1), 144-161. URL
    http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf"),
                  h4("Doug McIlroy. Packaged for R by Ray Brownrigg, Thomas P Minka and transition to Plan 9 codebase by Roger Bivand. (2020). mapproj: Map Projections. R package
    version 1.2.7. https://CRAN.R-project.org/package=mapproj"),
                  h4("Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with lubridate. Journal of Statistical Software, 40(3), 1-25. URL
    http://www.jstatsoft.org/v40/i03/."),
                  h4("C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC Florida, 2020."),
                  h4("Matt Dancho and Davis Vaughan (2020). tidyquant: Tidy Quantitative Financial Analysis. R package version 1.0.1. https://CRAN.R-project.org/package=tidyquant"),
                  h3("References Used:"),
                  h4("“Create a Header Panel.” Shiny, shiny.rstudio.com/reference/shiny/0.11/headerPanel.html."),
                  h4("“Create a Page with a Top Level Navigation Bar.” Shiny, shiny.rstudio.com/reference/shiny/0.11/navbarPage.html."),
                  h4("HendyHendy 8, and Ram NarasimhanRam Narasimhan 21.1k44 gold badges4040 silver badges5252 bronze badges. “Scale and Size of Plot in RStudio Shiny.” Stack Overflow, 1 Sept. 1962, stackoverflow.com/questions/17838709/scale-and-size-of-plot-in-rstudio-shiny"),
                  h4("Shiny Themes, rstudio.github.io/shinythemes/"),
                  h4("Dr. Bailer Live Q&A for Last Project: https://docs.google.com/document/d/1EZMFJyPWpUv6vlH8AM9Hlx4T1mksyy0a3M490aWWEb4/edit")
          ))
    )


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$distPlot <- renderPlotly({
      # Gets the y-variable desired by the user
      inputToFill <- ifelse(input$fillofinterest == "Number of Cases","CasesCut",
          ifelse(input$fillofinterest == "Number Hospitalized", "HosCut", 
          ifelse(input$fillofinterest == "Number Dead", "DeadCut", "CasesCut")))
      # Creates the Ohio plot 
      plot <- ggplot(data=ohio_county_map_covid, 
                    aes_string(x="long", y="lat", group="group", fill=inputToFill, County="County", Cases="`Number of Cases`", Deaths="`Number Dead`", Hospitalizations="`Number Hospitalized`",
                              CaseRate = "`Cases Rate per 1000 Residents`",DeathRate="`Death Rate per 1000 Residents`",HosRate="`Hospitalization Rate per 1000 Residents`")) +
            geom_polygon(color="black") +
            scale_fill_brewer() +
            labs(x="",y="") +
            theme_nothing()
      # Returns a ggplotly graph with the specified tooltips based on the desired response variable
      if(input$fillofinterest == "Number of Cases") {
        ggplotly(plot,
                 tooltip=c("County", "Cases", "CaseRate")) %>%
          layout(showlegend=FALSE) 
      } else if(input$fillofinterest == "Number Hospitalized") {
        ggplotly(plot,
                 tooltip=c("County", "Hospitalizations", "HosRate")) %>% 
          layout(showlegend=FALSE) 
      } else if(input$fillofinterest == "Number Dead") {
        ggplotly(plot,
                 tooltip=c("County", "Deaths", "DeathRate")) %>% 
          layout(showlegend=FALSE) 
      }
          
    })
    
    output$barchart <- renderPlot({
        # Gets the y-variable desired by the user
        inputToFill <- ifelse(input$fillofinterest2 == "Number of Cases", ifelse(input$type2 == "Counts", "numberCases", "CaseRate"),
                              ifelse(input$fillofinterest2 == "Number Hospitalized", ifelse(input$type2 == "Counts", "numberHospitalized", "HosRate"),
                                     ifelse(input$fillofinterest2 == "Number Dead", ifelse(input$type2 == "Counts", "numberDead", "DeathRate"), "numberCases")))
        # Filters by the selected county
        OhioCovidDailyCountyCount <- OhioCovidDailyCountyCount %>% 
            filter(County == str_to_lower(input$County))
        # Creates a bar graph plot with a moving average on the specified variable
        plot <- ggplot(OhioCovidDailyCountyCount, aes_string(x="OnsetDate",y=inputToFill)) +
            geom_col(color="blue") +
            labs(x = "Onset Date", y = "Number of Cases", title=paste("Number of Cases for", input$County)) +
                   scale_x_date(date_breaks = "2 months",
                                date_labels = "%b %d") +
            theme_minimal()
        
        if(input$add_ma) {
          plot <- plot +
            geom_ma(n=input$ma_amount, linetype=1, color="black", size=1.25)
        }
        
        plot
    })
    
    output$combarchart <- renderPlot({
      # Gets the y-variable desired by the user
      inputy <- ifelse(input$fillofinterest3 == "Number of Cases", ifelse(input$type3 == "Counts", "numberCases", "CaseRate"),
                      ifelse(input$fillofinterest3 == "Number Hospitalized", ifelse(input$type3 == "Counts", "numberHospitalized", "HosRate"),
                            ifelse(input$fillofinterest3 == "Number Dead", ifelse(input$type3 == "Counts", "numberDead", "DeathRate"), "CasesCut")))
      # Gets the fill variable based on the desired y-variable  
      inputToFill <- ifelse(input$fillofinterest3 == "Number of Cases", ifelse(input$type3 == "Counts", "CasesCut", "CaseRateCut"),
                         ifelse(input$fillofinterest3 == "Number Hospitalized", ifelse(input$type3 == "Counts", "HosCut", "HosRateCut"),
                                ifelse(input$fillofinterest3 == "Number Dead", ifelse(input$type3 == "Counts", "DeadCut", "DeathRateCut"), "CasesCut")))
      organize <- ifelse(input$organizeBy == "Number of Cases", ifelse(input$type3 == "Counts", "numberCases", "CaseRate"),
                       ifelse(input$organizeBy == "Number Hospitalized", ifelse(input$type3 == "Counts", "numberHospitalized", "HosRate"),
                              ifelse(input$organizeBy == "Number Dead", ifelse(input$type3 == "Counts", "numberDead", "DeathRate"), "CasesCut")))
      
      # Gets the current maximum value of the graph based on the desired y-variable  
      maxVal <- ifelse(input$fillofinterest3 == "Number of Cases", ifelse(input$type3 == "Counts", max(OhioCasePop$numberCases), max(OhioCasePop$CaseRate)),
                         ifelse(input$fillofinterest3 == "Number Hospitalized", ifelse(input$type3 == "Counts", max(OhioCasePop$numberHospitalized), max(OhioCasePop$HosRate)),
                                ifelse(input$fillofinterest3 == "Number Dead", ifelse(input$type3 == "Counts", max(OhioCasePop$numberDead), max(OhioCasePop$DeathRate)), max(OhioCasePop$numberCases))))
      # Expands the max value by 10%
      maxVal2 <- maxVal*1.1
      # Calculates a nudge based on the expanded and original max value
      nudge <- (maxVal2-maxVal)/2
      # Creates the bar graph of the counties and the desired y-value
      ggplot(data=OhioCasePop, 
              aes_string(x=paste("fct_reorder(County,", organize ,")",sep=""), y=inputy, fill=inputToFill)) +
              geom_col(show.legend = FALSE) +
              labs(x="",y="",title=input$fillofinterest) +
              scale_fill_brewer(palette = "PuBu") +
              scale_y_continuous(expand=c(0,0)) +
              coord_flip() +
              guides(fill=FALSE)  +
              theme_nothing() +
              theme(axis.text.y = element_text(size=8)) +
              geom_text(data=OhioCasePop, aes_string(label=inputy,fill=NULL), nudge_y = nudge, size=3) +
              ylim(0, maxVal2)
    }, height=1500)
    
    output$ageComparison <- renderPlot({
      # Gets the desired y-variable 
      inputy <- ifelse(input$fillofinterest4 == "Number of Cases", ifelse(input$type4 == "Counts", "numberCases", "CaseRate"),
                      ifelse(input$fillofinterest4 == "Number Hospitalized", ifelse(input$type4 == "Counts", "numberHospitalized", "HosRate"),
                            ifelse(input$fillofinterest4 == "Number Dead", ifelse(input$type4 == "Counts", "numberDead", "DeathRate"), "CasesCut")))
      # Filters to get the desired county
      OhioCovidAgeCounty <- OhioCovidAge %>% 
        filter(County == str_to_lower(input$County2))
  
      # Creates the desired bar graph faceted by Age Range with the desired y-variable
      plot <- ggplot(OhioCovidAgeCounty, aes_string(x="OnsetDate",y=inputy)) +
            geom_col(color="blue") +
            facet_wrap(~`Age Range`) +
            labs(x="Onset Date", y=input$fillofinterest4, title= paste(input$fillofinterest4, "for", input$County2))
      
      if(input$add_ma2) {
        plot <- plot +
          geom_ma(n=input$ma_amount2, linetype=1, color="black", size=1.25)
      }
      plot
    })
    
    output$ageBarGraph <- renderPlot({
      # Gets the desired response variable
      inputy <- ifelse(input$fillofinterest5 == "Number of Cases", "numberCases",
                        ifelse(input$fillofinterest5 == "Number Hospitalized", "numberHospitalized",
                              ifelse(input$fillofinterest5 == "Number Dead","numberDead", "CasesCut")))
      # Gets the fill cut based on the response variable selected  
      inputToFill <- ifelse(input$fillofinterest5 == "Number of Cases", ifelse(input$type3 == "Counts", "CasesCut", "CaseRateCut"),
                              ifelse(input$fillofinterest5 == "Number Hospitalized", ifelse(input$type3 == "Counts", "HosCut", "HosRateCut"),
                                     ifelse(input$fillofinterest5 == "Number Dead", ifelse(input$type3 == "Counts", "DeadCut", "DeathRateCut"), "CasesCut")))
      organize <- ifelse(input$organizeBy2 == "Number of Cases", ifelse(input$type3 == "Counts", "numberCases", "CaseRate"),
                         ifelse(input$organizeBy2 == "Number Hospitalized", ifelse(input$type3 == "Counts", "numberHospitalized", "HosRate"),
                                ifelse(input$organizeBy2 == "Number Dead", ifelse(input$type3 == "Counts", "numberDead", "DeathRate"), "CasesCut")))
     
      # Filters to get the desired age range
      OhioCovidAgeBarS <- OhioCovidAgeBar %>% 
        filter(`Age Range` == input$ageRange)
      
      # Gets the maximum value of the response variable  
      maxVal <- ifelse(input$fillofinterest5 == "Number of Cases", max(OhioCovidAgeBarS$numberCases),
                       ifelse(input$fillofinterest5 == "Number Hospitalized", max(OhioCovidAgeBarS$numberHospitalized),
                              ifelse(input$fillofinterest5 == "Number Dead", max(OhioCovidAgeBarS$numberDead), max(OhioCovidAgeBar$numberCases))))
      # Expands the max value by 10%
      maxVal2 <- maxVal*1.1
      # Calculates a nudge based on the expanded and original max value
      nudge <- (maxVal2-maxVal)/2
      # Creates the desired bar graph with the desired age range compared for each county
      ggplot(OhioCovidAgeBarS, aes_string(x=paste("fct_reorder(County, ", organize, ")"), y=inputy, fill=inputToFill)) +
            geom_col(show.legend = FALSE) +
            labs(x="",y="",title=input$fillofinterest) +
            scale_fill_brewer(palette = "PuBu") +
            scale_y_continuous(expand=c(0,0)) +
            coord_flip() +
            guides(fill=FALSE)  +
            theme_nothing() +
            theme(axis.text.y = element_text(size=8)) +
            ylim(0, maxVal2) +
            geom_text(data=OhioCovidAgeBarS, aes_string(label=inputy,fill=NULL), nudge_y = nudge, size=3)
    }, height=1500)
}

# Run the application 
shinyApp(ui = ui, server = server)
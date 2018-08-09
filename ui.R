#library(shiny)
library(DT)
library(tidyverse)
#library(lubridate)
library(shinydashboard)
library(semantic.dashboard)
library(shiny.semantic)
#library(magrittr)
library(shinyjs)
library(mailR)
library(rmarkdown)
library(tinytex)
#library(rdrop2)

#Dataimport

table_data <<- data.frame(
  Name = c("Preis", "Porto", "Summe"),
  Lisa = c(0, 0,0),
  Musterfrau = c("€","€","€")
  )


kunden <<- read_csv("kunden.csv", 
                    col_types = cols(Hausnummer = col_character()))


#Preis Funktion:
shinyUI(

  dashboardPage(
dashboardHeader(
  color = "blue",
  title = "Spiele direkt beim Herausgeber Wendelin Holz kaufen",
  inverted = TRUE
  ),
  
  
dashboardSidebar(
  size = "wide", color = "teal",
    sidebarMenu(
      menuItem(tabName = "home", text = "Einkauf", icon = icon("home")),
      menuItem(tabName = "Impresum", text = "Impressum", icon = icon("heart"))
    ),
    div(class = "ui horizontal divider", "Anschrift"),
      textInput("vorname", "Vorname"),
      textInput("nachname", "Nachname"),
      selectInput("geschlecht", "Geschlecht",  choices = c("", "Herr", "Frau")
      ),
      
    div(class = "ui horizontal divider", uiicon("tag"), 
        "Lieferadresse"),
      textInput("lvorname", "Vorname"),
      textInput("lnachname", "Nachname"),
      textInput("email", "E-Mail"),
      
      textInput("strasse", "Straße"),
      textInput("nr", "Hausnummer"),
      textInput("plz", "PLZ"),
      textInput("stadt", "Stadt"),
      textInput("land", "Land"),
    actionButton("addButton", "Kaufen", style = "color: black;background-color: yellow")
    
    #shinyjs::useShinyjs(),
    #uiOutput("test")
    
    #div(class = "ui yellow button", "Kaufen")

    
  ),
  
dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              fluidRow(
                box(
                  
                  numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_berg"),
                  img(src = "tit.png", height = 60, width = 40),
                  shinyjs::useShinyjs(),
                  div(class = "ui star rating"),
                  div(class = "ui divider"),
                  
                  numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_fluss"),
                  img(src = "tit1.png", height = 60, width = 40),
                  div(class = "ui divider"),
                  
                  numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_stadt"),
                  img(src = "tit2.png", height = 60, width = 40),
                  div(class = "ui divider"),
                  
                  numericInput("euland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_euland"),
                  img(src = "tit2.png", height = 60, width = 40),
                  div(class = "ui divider"),
                  
                  numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_land"),
                  img(src = "tit.png", height = 60, width = 40)
                ),
                
                valueBoxOutput("value_box"), title = "", theme = NULL)
              
                ),
      
      # Second tab content
      tabItem(tabName = "Impresum",
              fluidRow(
                h2(class = "ui header","Dazu habe ich keine Lust. Zeigt mich halt an wegen 
             Datenschutz und so. Komm mach schon!! traust du dich eh nicht, mein Papa ist Staatsanwalt :)")
              )
      )
    )
  ))
)



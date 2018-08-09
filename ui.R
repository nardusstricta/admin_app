library(shiny)
library(DT)
library(tidyverse)
library(shinydashboard)
library(mailR)
library(rmarkdown)
library(tinytex)


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
  title = "Wendels Spiele kaufen"
  ),
  
  
dashboardSidebar(
  tags$style(HTML("
      .main-sidebar{
        width: 500px;
      }
    ")),
    sidebarMenu(
      menuItem(tabName = "home", text = "Einkauf", icon = icon("home")),
      menuItem(tabName = "Impresum", text = "Impressum", icon = icon("heart"))
    ),
    splitLayout(
      textInput("vorname", "Vorname"),
      textInput("nachname", "Nachname")
    ),
      selectInput("geschlecht", "Geschlecht",  choices = c("", "Herr", "Frau")
      ),
    
      textInput("lvorname", "Vorname"),
      textInput("lnachname", "Nachname"),
      textInput("email", "E-Mail"),
      
      textInput("strasse", "Straße"),
      textInput("nr", "Hausnummer"),
      textInput("plz", "PLZ"),
      textInput("stadt", "Stadt"),
      textInput("land", "Land"),
    actionButton("addButton", "Kaufen", style = "color: black;background-color: yellow")
  ),
  
dashboardBody(
  tags$head(tags$style(HTML(' .main-sidebar{ width: 500px; } .main-header > .navbar { margin-left: 500px; } .main-header .logo { width: 500px; } .content-wrapper, .main-footer, .right-side { margin-left: 500px; } '))),
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              fluidRow(
                column(width = 6,
                box(
                  title = uiOutput("tab_berg"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                  img(src = "tit.png", height = 110, width = 80),
                  numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ))
                ),
                box(


                  
                  numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_fluss"),
                  img(src = "tit1.png", height = 60, width = 40),

                  
                  numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_stadt"),
                  img(src = "tit2.png", height = 60, width = 40),

                  
                  numericInput("euland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_euland"),
                  img(src = "tit2.png", height = 60, width = 40),

                  
                  numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
                  uiOutput("tab_land"),
                  img(src = "tit.png", height = 60, width = 40)
                ),
                box(
                  title = "Dein Einkauf", status = "warning", solidHeader = TRUE,
                tableOutput('table1')
                )
                ),
      
      # Second tab content
      tabItem(tabName = "Impresum",
              fluidRow(
                h2(class = "ui header","Dazu habe ich keine Lust. Zeigt mich halt an wegen 
             Datenschutz und so. Komm mach schon!! traust du dich eh nicht, mein Papa ist Staatsanwalt :)")
              )
      )
  ))
)
)



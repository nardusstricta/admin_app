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
  tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}"))), 
  tags$style(HTML("
      .main-sidebar{
        width: 500px;
position:fixed; overflow: visible;
      }
    ")),
    sidebarMenu(
      menuItem(tabName = "home", text = "home", icon = icon("home")),
      menuItem(tabName = "Kundendaten", text = "Kundendaten", icon = icon("shopping-cart"),
        splitLayout(
          textInput("vorname", "Vorname"),
          textInput("nachname", "Nachname"),
          selectInput("geschlecht", "Geschlecht",  
                      choices = c("", "Herr", "Frau"),  width="120px"#,
          )
      ),
  p("Lieferadresse:"),
  splitLayout(
      textInput("lvorname", "Vorname"),
      textInput("lnachname", "Nachname")
  ),
      textInput("email", "E-Mail"),
  splitLayout(
      textInput("strasse", "Straße"),
      textInput("nr", "Hausnummer")),
  splitLayout(
      textInput("plz", "PLZ"),
      textInput("stadt", "Stadt")),
  splitLayout(
      textInput("land", "Land"),
    actionButton("addButton", "Kaufen", style = "color: black;background-color: yellow")
  )),
  menuItem(tabName = "Impresum", text = "Impressum", icon = icon("heart"))
  )),
  
dashboardBody(
  tags$head(tags$style(HTML(' .main-sidebar{ width: 500px; } .main-header > .navbar { margin-left: 500px; } .main-header .logo { width: 500px; } .content-wrapper, .main-footer, .right-side { margin-left: 500px; } '))),
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              box(
              fluidRow(
                #column(width = 6,
                box(
                  title = uiOutput("tab_berg"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                  img(src = "tit.png", height = 110, width = 80),
                  numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_fluss"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "tit1.png", height = 110, width = 80),
                    numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_stadt"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "tit2.png", height = 110, width = 80),
                    numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_euland"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "tit2.png", height = 110, width = 80),
                    numericInput("euland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_land"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "tit2.png", height = 110, width = 80),
                    numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                )
                #)
                )),
                box(
                  title = "Dein Einkauf", status = "warning", solidHeader = TRUE,
                tableOutput('table1')
                ))
                ,
      
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



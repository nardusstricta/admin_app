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
  title = "Wendels Kartenspiele kaufen"
  ),
  
  
dashboardSidebar(
    sidebarMenu(
      menuItem(tabName = "home", text = "home", icon = icon("home")),
      menuItem(tabName = "Dein Einkauf", text = "Dein Einkauf", icon = icon("shopping-cart"),
               width = "300px",
               br(),
               br(),
               tableOutput("table1"),
               actionButton("addButton", "Kaufen", style = "color: black;background-color: yellow")
               ),
  menuItem(tabName = "Impresum", text = "Impressum", icon = icon("heart"))
  )),
  
dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              fluidRow(
              box(
              fluidRow(
                box(
                  title = uiOutput("tab_berg"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                  img(src = "titB.png", height = 110, width = 80),
                  numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_fluss"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titF.png", height = 110, width = 80),
                    numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_stadt"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titS.png", height = 110, width = 80),
                    numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_euland"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titEL.png", height = 110, width = 80),
                    numericInput("euland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_land"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titFL.png", height = 110, width = 80),
                    numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                )
                )),
                box(title = "Kundendaten", background = "black",
                  splitLayout(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")),
                    textInput("vorname", "Vorname"),
                    textInput("nachname", "Nachname"),
                    selectInput("geschlecht", "Anrede",  
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
                    actionButton("addButton2", "Kaufen", style = "color: black;background-color: yellow")
                  )
                )))
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



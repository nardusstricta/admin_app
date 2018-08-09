library(shiny)
library(semantic.dashboard)
library(ggplot2)
library(plotly)
library(DT)

fun_preis <- function(berg, fluss, standt, land, euland){
  sum_poduckt <- sum(berg, fluss, standt, land, euland)
  erg <- c(NA, NA)
  if(berg == 1 && fluss == 1 && standt == 1 && land == 1 && euland == 1){
    erg[1] <- 20
    erg[2] <- 0
  }else{
    if(sum_poduckt >= 6){
      erg[1] <- sum_poduckt * 4
      erg[2] <- 0
    }else{
      if(sum_poduckt == 3){
        erg[1] <- 12
        erg[2] <- 2.5
      }else{
        erg[1] <- sum_poduckt * 4.5
        erg[2] <- 2.5
      }
    }
  }
  return(erg)
}


table_data <- data.frame(
  Name = c("John Smith", "Lindsay More"),
  City = c("Warsaw, Poland", "SF, United States"),
  Revenue = c("$210.50", "$172.78"))


kunden <<- read_csv("kunden.csv", 
                    col_types = cols(Hausnummer = col_character()))
#E-mail Optionen:
#panderOptions('table.split.table', Inf) #wie soll die Tabelle aussehen für die E-mail
sender <- "gabriholz@gmail.com"
recipients <- c("gabriholz@gmail.com")

ui <- dashboardPage(
  dashboardHeader(color = "blue",title = "Dashboard Demo", inverted = TRUE),
  dashboardSidebar(
    size = "thin", color = "teal",
    sidebarMenu(
      menuItem(tabName = "main", "Main", icon = icon("home")),
      menuItem(tabName = "extra", "Extra", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      selected = 1,
      tabItem(
        tabName = "home",
        fluidRow(
          box(
            div(class = "ui raised segment", style="margin-left: 20px; max-width: 350px; width: 100%",
                a(class="ui green ribbon label", "Client's info"),
                p(),
                xtable::xtable(table_data) %>%
                  print(html.table.attributes="class = 'ui very basic collapsing celled table'",
                        type = "html", include.rownames = F, print.results = F) %>%
                  HTML
            )
          ),
          box(width = 8,
              title = "Graph 2",
              color = "red", ribbon = TRUE, title_side = "top right",
              column(width = 8,
                     plotlyOutput("dotplot1")
              )
          ),
          
          box(
            numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_berg"),
            img(src = "tit.png", height = 60, width = 40),
            
            numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_berg"),
            img(src = "tit.png", height = 60, width = 40),
            
            numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_fluss"),
            img(src = "tit1.png", height = 60, width = 40),
            
            
            numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_stadt"),
            img(src = "tit2.png", height = 60, width = 40),
            
            
            numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_land"),
            img(src = "tit2.png", height = 60, width = 40),
            
            numericInput("neuland", "Anzahl", value = 0, min = 0, max = 10000, step = 1),
            uiOutput("tab_euland"),
            img(src = "tit2.png", height = 60, width = 40),
            div(class = "ui input", input(placeholder = "Search...")),
          )
        )
      ),
      tabItem(
        tabName = "extra",
        fluidRow(
          dataTableOutput("carstable")
        )
      )
    )
  ), theme = "cerulean"
)

server <- shinyServer(function(input, output, session) {
  
  
  observeEvent(input$addButton,{
    if(input$vorname %in% kunden$Name && 
       input$nachname %in% kunden$Nachname && 
       input$strasse %in% kunden$Strasse){
      id_temp <- kunden$ID[which(input$vorname == kunden$Name) &&
                             which(input$nachname == kunden$Nachname) &&
                             which(input$strasse == kunden$Strasse)][1]
    }else{
      id_temp <- max(kunden$ID)+1
    }
    
    newline <- isolate(data.frame(KundenNR = Sys.Date(),
                                  ID = id_temp,
                                  Name = input$vorname,
                                  Nachname = input$nachname,
                                  Geschlecht = input$geschlecht,
                                  Lvorname = input$lvorname,
                                  Lname = input$lnachname,
                                  Email = input$email,
                                  Strasse = input$strasse,
                                  Hausnummer = input$nr,
                                  PLZ = input$plz,
                                  Land = input$land)
    )
    
  })
  
  
  url_berg <- a("Gebirgsriesen", href="http://www.wendels-kartenspiele.de/gebirgsriesen.html", target="_blank")
  output$tab_berg <- renderUI({
    tagList("", url_berg)
  })
  url_stadt <- a("Städte", href="http://www.wendels-kartenspiele.de/staedte.html")
  output$tab_stadt <- renderUI({
    tagList("", url_stadt)
  })
  
  url_fluss <- a("Flüsse", href="http://www.wendels-kartenspiele.de/gewaesser.html")
  output$tab_fluss <- renderUI({
    tagList("", url_fluss)
  })
  
  url_land <- a("Länder", href="http://www.wendels-kartenspiele.de/gewaesser.html")
  output$tab_land <- renderUI({
    tagList("", url_land)
  })
  
  url_euland <- a("EU-Länder", href="http://www.wendels-kartenspiele.de/gewaesser.html")
  output$tab_euland <- renderUI({
    tagList("", url_euland)
  })
  
  
  output$pay_porto <- renderText({
    erg_port <- fun_preis(berg = input$nberg,
                          fluss = input$nfluss,
                          standt = input$nstadt, 
                          land = input$nland, 
                          euland = input$neuland)
    if(erg_port[1] != 0){
      paste("Preis", erg_port[1],"€", "Porto",  erg_port[2], "€", "Summe:", erg_port[1]+erg_port[2], "€")
    }else{
      "Bitte wählen sie die gewünschte Menge aus"
    }
    
  })
})

shinyApp(ui, server)

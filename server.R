
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(DT)
library(tidyverse)
library(shiny)
library(shinydashboard)
library(mailR)
library(rmarkdown)
library(tinytex)




fun_preis <- function(berg, fluss, standt, land, euland){
  sum_poduckt <- sum(berg, fluss, standt, land, euland, na.rm = T)
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

shinyServer(function(input, output, session){
  
  
  observe({
    xname <- input$vorname
    xnachname <- input$nachname
    # This will change the value of input$inText, based on x
    updateTextInput(session, "lvorname", value = xname)
    updateTextInput(session, "lnachname", value = xnachname)
  })
  
  observeEvent(c(input$addButton, input$addButton2),{if(input$addButton > 0 | input$addButton2 > 0){
    withProgress(message = 'Die Bestellung wird abgeschickt',
                 detail = 'Danke für ein bisschen Geduld', value = 0,{
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
    if(input$vorname %in% kunden$Name && 
       input$nachname %in% kunden$Nachname && 
       input$strasse %in% kunden$Strasse){
      id_temp <- kunden$ID[which(input$vorname == kunden$Name) &&
                             which(input$nachname == kunden$Nachname) &&
                             which(input$strasse == kunden$Strasse)][1]
    }else{
      id_temp <- max(kunden$ID) + 1
    }
    
    newline <- isolate(data.frame(KundenNR = paste0(format(Sys.Date(), "%Y-%m"),"P"),
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
                                  Stadt = input$stadt,
                                  Land = input$land)
    )
    
    write.table(
      newline, "kunden.csv", 
      sep = ",", col.names = F, append = T, row.names = F
    )
    
    #Bilanz informationen
    erg_temp <- fun_preis(berg = input$nberg,
    fluss = input$nfluss,
    standt = input$nstadt, 
    land = input$nland, 
    euland = input$neuland)
    newline_2 <- data.frame(KundenNR = newline$KundenNR, 
                            RechnungsNR = paste0(newline$KundenNR, newline$ID),
                            Produkt = paste(input$nberg,"* Berge;",
                                            input$nfluss, "* Flüsse;",
                                            input$nstadt, "* Städte;",
                                            input$nland, "* Ferne-Länder;", 
                                            input$euland, "* Länder Europas"),
                            soll = erg_temp[1] + erg_temp[2],
                            saldo = c(0),
                            Datum = Sys.Date()
                              )
    
    write.table(
      newline_2, "bilanz.csv", 
      sep = ",", col.names = F, append = T, row.names = F
    )
    updateNumericInput(session, "nberg", value = 0)
    updateNumericInput(session, "nfluss", value = 0)
    updateNumericInput(session, "nstadt", value = 0)
    updateNumericInput(session, "nland", value = 0)
    updateNumericInput(session, "neuland", value = 0)
    
    ##
    #Email an Wendelin
    #
    #E-mail Optionen:
    sender <- "wendels.kartenspiele@gmail.com"
    recipients <- c("wendels.kartenspiele@gmail.com", input$email)
    tempReport <- file.path(tempdir(), "report.Rmd")
    file.copy("report.Rmd", tempReport, overwrite = TRUE)
    # Set up parameters to pass to Rmd document
    params <- list(n = cbind(newline_2, newline))
    rmarkdown::render(tempReport,
                      params = params,
                      envir = new.env(parent = globalenv()))
    
    send.mail(from = sender,
              to = recipients,
              subject= paste("Vielen Dank für ihre Kartenbestellung vom", Sys.Date()),
              body = "Im Anhang befindet sich ihre Rechung der. Vielen Dank bis zum nächsten mal",
              attach.files = paste0(substr(tempReport, 1,nchar(tempReport)-3),"pdf"), #nur für den Kunden
              #smtp = list(host.name = "smtp.gmail.com", port = 465, 
                          #user.name="gabriholz@gmail.com", passwd="Nardusstricta3535995", ssl=TRUE),
              smtp = list(host.name = "smtp.gmail.com", port = 465, 
                          user.name="wendels.kartenspiele@gmail.com", passwd="K4rten2015", ssl=TRUE),
              authenticate = TRUE,
              send = TRUE)
                
    
    
                 })
    
    showModal(modalDialog(
      title = "Bestellung war erfolgreich!",
      paste("Der gesamt Betrag ist", sum(erg_temp[1], erg_temp[2]), "Euro", "Vielen Dank!"),
      easyClose = TRUE
    ))
  }
  
  })
  
  
  url_berg <- a("Berge", href="http://www.wendels-kartenspiele.de/gebirgsriesen.html", target="_blank")
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
  
  url_land <- a("Ferne Länder", href="http://www.wendels-kartenspiele.de/gewaesser.html")
  output$tab_land <- renderUI({
    tagList("", url_land)
  })
  
  url_euland <- a("Länder Europas", href="http://www.wendels-kartenspiele.de/gewaesser.html")
  output$tab_euland <- renderUI({
    tagList("", url_euland)
  })
  

  output$table1 <- renderTable({
    
    erg_port <- fun_preis(berg = input$nberg,
                          fluss = input$nfluss,
                          standt = input$nstadt, 
                          land = input$nland, 
                          euland = input$euland)
    table_data$Lisa <- c(erg_port[1], erg_port[2], sum(erg_port[1]+erg_port[2], na.rm=T))
    colnames(table_data) <- c("Name", input$vorname, input$nachname)
      table_data
    
  }
  )
})

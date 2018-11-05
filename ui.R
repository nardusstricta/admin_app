library(shiny)
library(DT)
library(tidyverse)
library(shinydashboard)
library(mailR)
library(rmarkdown)
library(tinytex)
library(rdrop2)


#Dataimport
token <<- readRDS("token.rds")
table_data <<- data.frame(
  Name = c("Preis", "Porto", "Summe"),
  Lisa = c(0, 0,0),
  Musterfrau = c("€","€","€")
  )


kunden <<- drop_read_csv("/Apps/kunden.csv",
                         colClasses = c("integer","character",
                                        "character","character",
                                        "character","character",
                                        "character","character",
                                        "character","character",
                                        "character",
                                        "character","character", "numeric"))



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
               width = "300px",startExpanded = T,
               br(),
               br(),
               tableOutput("table1"),
               actionButton("addButton", "Kaufen", style = "color: black;background-color: yellow")
               ),
  menuItem(tabName = "Impresum", text = "Impressum", icon = icon("heart")),
  menuItem(tabName = "Datenschutz", text = "Datenschutz", icon = icon("user-secret")),
  menuItem(tabName = "agb", text = "AGB und Widerruf", icon = icon("balance-scale"))
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
                  img(src = "titB.png", height = 123.4, width = 80),
                  numericInput("nberg", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_fluss"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titF.png", height = 123.4, width = 80),
                    numericInput("nfluss", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_stadt"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titS.png", height = 123.4, width = 80),
                    numericInput("nstadt", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_euland"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titEL.png", height = 123.4, width = 80),
                    numericInput("euland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = uiOutput("tab_land"), status = "primary", solidHeader = TRUE,
                  splitLayout(
                    img(src = "titFL.png", height = 123.4, width = 80),
                    numericInput("nland", "Anzahl", value = 0, min = 0, max = 10000, step = 1)
                  )
                ),
                box(
                  title = "Preise", status = "info", solidHeader = TRUE,
                  tableOutput("table2"),
                  textOutput("text1")
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
                    textInput("land", "Land"), checkboxInput("agb", label = HTML("Ich akzeptiere AGB & Widerruf <br/>  sowie die Datenschutzerklärung"), value = FALSE, width = NULL)
                    
                  ),
                  splitLayout(
                    actionButton("addButton2", "Kaufen", style = "color: black;background-color: yellow"),
                    
                    checkboxInput("kk", label = HTML("Ich wil per E-Mail benachichtigt werden, <br/> wenn ein neues Produkt heraus kommt"), value = FALSE, width = NULL)
                  )
                )))
                ,
      
      # Second tab content
      tabItem(tabName = "Impresum",
              h2("Angaben gemäß § 5 TMG:"),
              p(strong("Betreiber der Website:")),
              p("Wendelin Holz"),
              p("Sachsenkamstr. 17"),
              p(" D-81369 München"),
              br(),
              p("004915784624261, holzwendelin@gmail.com"),
              h2("Quellenangaben für die verwendeten Bilder und Grafiken:"),
              p("http://www.johofilm.de/ Quelle: http://www.e-recht24.de"),
              h2(strong("Haftungsausschluss (Disclaimer)")),
              p("Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den
allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht
verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach
Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. Verpflichtungen zur
Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben
hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer
konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen
werden wir diese Inhalte umgehend entfernen."),
              h2("Haftung für Links"),
                        p("Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss
haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die
Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich.
Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft.
Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine permanente
inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer
Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige
Links umgehend entfernen."), 
      h2("Urheberrecht"),
      p("Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem
deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung
außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen
Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nichtkommerziellen Gebrauch gestattet. Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt
wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche
gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten
wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir
derartige Inhalte umgehend entfernen."),
      h2("Datenschutz:"),
      p("Siehe Datenschutzerklärung.")
  ),
  tabItem(tabName = "Datenschutz", h1("Datenschutz"),
          h2("1. Datenschutz auf einen Blick"),
          p(strong("Allgemeine Hinweise")),
          p("Die folgenden Hinweise geben einen einfachen Überblick darüber, was mit Ihren personenbezogenen Daten
passiert, wenn Sie unsere Website besuchen. Personenbezogene Daten sind alle Daten, mit denen Sie
persönlich identifiziert werden können. Ausführliche Informationen zum Thema Datenschutz entnehmen Sie
unserer unter diesem Text aufgeführten Datenschutzerklärung."),
          p(strong("Datenerfassung auf unserer Website")),
          p("Wer ist verantwortlich für die Datenerfassung auf dieser Website?"),
          p("Die Datenverarbeitung auf dieser Website erfolgt durch den Websitebetreiber. Dessen Kontaktdaten
können Sie dem Impressum dieser Website entnehmen."),
          p("Wie erfassen wir Ihre Daten?"),
          p("Ihre Daten werden zum einen dadurch erhoben, dass Sie uns diese mitteilen. Hierbei kann es sich z.B. um
Daten handeln, die Sie in ein Kontaktformular eingeben.
Andere Daten werden automatisch beim Besuch der Website durch unsere IT-Systeme erfasst. Das sind vor
allem technische Daten (z.B. Internetbrowser, Betriebssystem oder Uhrzeit des Seitenaufrufs). Die Erfassung
dieser Daten erfolgt automatisch, sobald Sie unsere Website betreten."),
          p("Wofür nutzen wir Ihre Daten?"),
          p("Ein Teil der Daten wird erhoben, um eine fehlerfreie Bereitstellung der Website zu gewährleisten. Andere
Daten können zur Analyse Ihres Nutzerverhaltens verwendet werden."),
          p("Welche Rechte haben Sie bezüglich Ihrer Daten?"),
          p("Sie haben jederzeit das Recht unentgeltlich Auskunft über Herkunft, Empfänger und Zweck Ihrer
gespeicherten personenbezogenen Daten zu erhalten. Sie haben außerdem ein Recht, die Berichtigung,
Sperrung oder Löschung dieser Daten zu verlangen. Hierzu sowie zu weiteren Fragen zum Thema Datenschutz
können Sie sich jederzeit unter der im Impressum angegebenen Adresse an uns wenden. Des Weiteren steht
Ihnen ein Beschwerderecht bei der zuständigen Aufsichtsbehörde zu. Außerdem haben Sie das Recht, unter
bestimmten Umständen die Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen.
Details hierzu entnehmen Sie der Datenschutzerklärung unter „Recht auf Einschränkung der Verarbeitung“."),
          h2("2. Allgemeine Hinweise und Pflichtinformationen"),
          p(strong("Datenschutz")),
          p("Die Betreiber dieser Seiten nehmen den Schutz Ihrer persönlichen Daten sehr ernst. Wir behandeln Ihre
personenbezogenen Daten vertraulich und entsprechend der gesetzlichen Datenschutzvorschriften sowie
dieser Datenschutzerklärung. Wenn Sie diese Website benutzen, werden verschiedene personenbezogene
Daten erhoben. Personenbezogene Daten sind Daten, mit denen Sie persönlich identifiziert werden können.
Die vorliegende Datenschutzerklärung erläutert, welche Daten wir erheben und wofür wir sie nutzen. Sie
erläutert auch, wie und zu welchem Zweck das geschieht. Wir weisen darauf hin, dass die Datenübertragung im
Internet (z.B. bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann. Ein lückenloser Schutz der
Daten vor dem Zugriff durch Dritte ist nicht möglich."),
          p(strong("Hinweis zur verantwortlichen Stelle")),
          p("Die verantwortliche Stelle für die Datenverarbeitung auf dieser Website ist:"),
          p("Wendelin Holz, Sachsenkamstr. 17, 81369 München, Telefon: +49 (0) 15784624261
E-Mail: holzwendelin@gmail.com"),
          p("Verantwortliche Stelle ist die natürliche oder juristische Person, die allein oder gemeinsam mit anderen über
die Zwecke und Mittel der Verarbeitung von personenbezogenen Daten (z.B. Namen, E-Mail-Adressen o. Ä.)
entscheidet."),
          p(strong("Widerruf Ihrer Einwilligung zur Datenverarbeitung")),
          p("Viele Datenverarbeitungsvorgänge sind nur mit Ihrer ausdrücklichen Einwilligung möglich. Sie können eine
bereits erteilte Einwilligung jederzeit widerrufen. Dazu reicht eine formlose Mitteilung per E-Mail an uns. Die
Rechtmäßigkeit der bis zum Widerruf erfolgten Datenverarbeitung bleibt vom Widerruf unberührt."),
          p(strong("Widerspruchsrecht gegen die Datenerhebung in besonderen Fällen sowie gegen
Direktwerbung (Art. 21 DSGVO)")),
          p("Wenn die Datenverarbeitung auf Grundlage von Art. 6 Abs. 1 lit. e oder f DSGVO erfolgt, haben Sie jederzeit
das Recht, aus Gründen, die sich aus Ihrer besonderen Situation ergeben, gegen die Verarbeitung Ihrer
personenbezogenen Daten Widerspruch einzulegen; dies gilt auch für ein auf diese Bestimmungen gestütztes
Profiling. Die jeweilige Rechtsgrundlage, auf denen eine Verarbeitung beruht, entnehmen Sie dieser
Datenschutzerklärung. Wenn Sie Widerspruch einlegen, werden wir Ihre betroffenen personenbezogenen
Daten nicht mehr verarbeiten, es sei denn, wir können zwingende schutzwürdige Gründe für die
Verarbeitung nachweisen, die Ihre Interessen, Rechte und Freiheiten überwiegen oder die Verarbeitung
dient der Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen (Widerspruch nach Art. 21
Abs. 1 DSGVO). Werden Ihre personenbezogenen Daten verarbeitet, um Direktwerbung zu betreiben, so
haben Sie das Recht, jederzeit Widerspruch gegen die Verarbeitung Sie betreffender personenbezogener
Daten zum Zwecke derartiger Werbung einzulegen; dies gilt auch für das Profiling, soweit es mit solcher
Direktwerbung in Verbindung steht. Wenn Sie widersprechen, werden Ihre personenbezogenen Daten
anschließend nicht mehr zum Zwecke der Direktwerbung verwendet (Widerspruch nach Art. 21 Abs. 2
DSGVO)."),
          p(strong("Beschwerderecht bei der zuständigen Aufsichtsbehörde")),
          p("Im Falle von Verstößen gegen die DSGVO steht den Betroffenen ein Beschwerderecht bei einer
Aufsichtsbehörde, insbesondere in dem Mitgliedstaat ihres gewöhnlichen Aufenthalts, ihres Arbeitsplatzes
oder des Orts des mutmaßlichen Verstoßes zu. Das Beschwerderecht besteht unbeschadet anderweitiger
verwaltungsrechtlicher oder gerichtlicher Rechtsbehelfe."),
          p(strong("Recht auf Datenübertragbarkeit")),
          p("Sie haben das Recht, Daten, die wir auf Grundlage Ihrer Einwilligung oder in Erfüllung eines Vertrags
automatisiert verarbeiten, an sich oder an einen Dritten in einem gängigen, maschinenlesbaren Format
aushändigen zu lassen. Sofern Sie die direkte Übertragung der Daten an einen anderen Verantwortlichen
verlangen, erfolgt dies nur, soweit es technisch machbar ist."),
          p(strong("SSL- bzw. TLS-Verschlüsselung")),
          p("Diese Seite nutzt aus Sicherheitsgründen und zum Schutz der Übertragung vertraulicher Inhalte, wie zum
Beispiel Bestellungen oder Anfragen, die Sie an uns als Seitenbetreiber senden, eine SSL-bzw. TLS
Verschlüsselung. Eine verschlüsselte Verbindung erkennen Sie daran, dass die Adresszeile des Browsers von
“http://” auf “https://” wechselt und an dem Schloss-Symbol in Ihrer Browserzeile.
Wenn die SSL- bzw. TLS-Verschlüsselung aktiviert ist, können die Daten, die Sie an uns übermitteln, nicht von
Dritten mitgelesen werden."),
          p(strong("Auskunft, Sperrung, Löschung und Berichtigung")),
          p("Sie haben im Rahmen der geltenden gesetzlichen Bestimmungen jederzeit das Recht auf unentgeltliche
Auskunft über Ihre gespeicherten personenbezogenen Daten, deren Herkunft und Empfänger und den Zweck
der Datenverarbeitung und ggf. ein Recht auf Berichtigung, Sperrung oder Löschung dieser Daten. Hierzu sowie zu weiteren Fragen zum Thema personenbezogene Daten können Sie sich jederzeit unter der im Impressum
angegebenen Adresse an uns wenden."),
          p(strong("Recht auf Einschränkung der Verarbeitung")),
          p("Sie haben das Recht, die Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen. Hierzu
            können Sie sich jederzeit unter der im Impressum angegebenen Adresse an uns wenden. Das Recht auf
            Einschränkung der Verarbeitung besteht in folgenden Fällen:"),
          p("Wenn Sie die Richtigkeit Ihrer bei uns gespeicherten personenbezogenen Daten bestreiten, benötigen
wir in der Regel Zeit, um dies zu überprüfen. Für die Dauer der Prüfung haben Sie das Recht, die
Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen."),
          p("Wenn die Verarbeitung Ihrer personenbezogenen Daten unrechtmäßig geschah / geschieht, können
Sie statt der Löschung die Einschränkung der Datenverarbeitung verlangen. Wenn wir Ihre
personenbezogenen Daten nicht mehr benötigen, Sie sie jedoch zur Ausübung, Verteidigung oder
Geltendmachung von Rechtsansprüchen benötigen, haben Sie das Recht, statt der Löschung die
Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen."),
          p("Wenn Sie einen Widerspruch nach Art. 21 Abs. 1 DSGVO eingelegt haben, muss eine Abwägung
zwischen Ihren und unseren Interessen vorgenommen werden. Solange noch nicht feststeht, wessen
Interessen überwiegen, haben Sie das Recht, die Einschränkung der Verarbeitung Ihrer
personenbezogenen Daten zu verlangen."),
          p("Wenn Sie die Verarbeitung Ihrer personenbezogenen Daten eingeschränkt haben, dürfen diese Daten
– von ihrer Speicherung abgesehen – nur mit Ihrer Einwilligung oder zur Geltendmachung, Ausübung
oder Verteidigung von Rechtsansprüchen oder zum Schutz der Rechte einer anderen natürlichen oder
juristischen Person oder aus Gründen eines wichtigen öffentlichen Interesses der Europäischen Union
oder eines Mitgliedstaats verarbeitet werden."),
          p(strong("Widerspruch gegen Werbe-E-Mails")),
          p("Der Nutzung von im Rahmen der Impressumspflicht veröffentlichten Kontaktdaten zur Übersendung von nicht
ausdrücklich angeforderter Werbung und Informationsmaterialien wird hiermit widersprochen. Die Betreiber
der Seiten behalten sich ausdrücklich rechtliche Schritte im Falle der unverlangten Zusendung von
Werbeinformationen, etwa durch Spam-E-Mails, vor."),
          p(strong("Verarbeiten von Daten (Kunden- und Vertragsdaten)")),
          p("Wir erheben, verarbeiten und nutzen personenbezogene Daten nur, soweit sie für die Begründung, inhaltliche
Ausgestaltung oder Änderung des Rechtsverhältnisses erforderlich sind (Bestandsdaten). Dies erfolgt auf
Grundlage von Art. 6 Abs. 1 lit. b DSGVO, der die Verarbeitung von Daten zur Erfüllung eines Vertrags oder
vorvertraglicher Maßnahmen gestattet. Personenbezogene Daten über die Inanspruchnahme unserer
Internetseiten (Nutzungsdaten) erheben, verarbeiten und nutzen wir nur, soweit dies erforderlich ist, um dem
Nutzer die Inanspruchnahme des Dienstes zu ermöglichen oder abzurechnen.
Die erhobenen Kundendaten werden nach Abschluss des Auftrags oder Beendigung der Geschäftsbeziehung
gelöscht. Gesetzliche Aufbewahrungsfristen bleiben unberührt."),
          p(strong("Datenübermittlung bei Vertragsschluss für Online-Shops, Händler und Warenversand")),
          p("Wir übermitteln personenbezogene Daten an Dritte nur dann, wenn dies im Rahmen der Vertragsabwicklung
notwendig ist, etwa an die mit der Lieferung der Ware betrauten Unternehmen oder das mit der
Zahlungsabwicklung beauftragte Kreditinstitut. Eine weitergehende Übermittlung der Daten erfolgt nicht bzw.
nur dann, wenn Sie der Übermittlung ausdrücklich zugestimmt haben. Eine Weitergabe Ihrer Daten an Dritte
ohne ausdrückliche Einwilligung, etwa zu Zwecken der Werbung, erfolgt nicht.
Grundlage für die Datenverarbeitung ist Art. 6 Abs. 1 lit. b DSGVO, der die Verarbeitung von Daten zur Erfüllung
eines Vertrags oder vorvertraglicher Maßnahmen gestattet."),
          h2("3. Datenerfassung auf unserer Website"),
          p(strong("Server-Log-Dateien")),
          p("Der Provider der Seiten erhebt und speichert automatisch Informationen in so genannten Server-Log-Dateien,
die Ihr Browser automatisch an uns übermittelt. Dies sind:"),
p("Browsertyp und Browserversion"),
p("verwendetes Betriebssystem"),
p("Referrer URL"),
p("Hostname des zugreifenden Rechners"),
p("Uhrzeit der Serveranfrage"),
p("IP-Adresse"),
p("Eine Zusammenführung dieser Daten mit anderen Datenquellen wird nicht vorgenommen.
Grundlage für die Datenverarbeitung ist Art. 6 Abs. 1 lit. f DSGVO, der die Verarbeitung von Daten zur Erfüllung
eines Vertrags oder vorvertraglicher Maßnahmen gestattet."),
p("Grundlage für die Datenverarbeitung ist Art. 6 Abs. 1 lit. f DSGVO, der die Verarbeitung von Daten zur Erfüllung
eines Vertrags oder vorvertraglicher Maßnahmen gestattet."),
p(strong("Kontaktformular")),
p("Wenn Sie uns per Kontaktformular Anfragen zukommen lassen, werden Ihre Angaben aus dem
Anfrageformular inklusive der von Ihnen dort angegebenen Kontaktdaten zwecks Bearbeitung der Anfrage und
für den Fall von Anschlussfragen bei uns gespeichert. Diese Daten geben wir nicht ohne Ihre Einwilligung
weiter.
Die Verarbeitung der in das Kontaktformular eingegebenen Daten erfolgt somit ausschließlich auf
Grundlage Ihrer Einwilligung (Art. 6 Abs. 1 lit. a DSGVO). Sie können diese Einwilligung jederzeit widerrufen.
Dazu reicht eine formlose Mitteilung per E-Mail an uns. Die Rechtmäßigkeit der bis zum Widerruf erfolgten
Datenverarbeitungsvorgänge bleibt vom Widerruf unberührt.
Die von Ihnen im Kontaktformular eingegebenen Daten verbleiben bei uns, bis Sie uns zur Löschung
auffordern, Ihre Einwilligung zur Speicherung widerrufen oder der Zweck für die Datenspeicherung entfällt (z.B.
nach abgeschlossener Bearbeitung Ihrer Anfrage). Zwingende gesetzliche Bestimmungen – insbesondere
Aufbewahrungsfristen – bleiben unberührt."),
p(strong("Anfrage per E-Mail, Telefon oder Telefax")),
p("Wenn Sie uns per E-Mail, Telefon oder Telefax kontaktieren, wird Ihre Anfrage inklusive aller daraus
hervorgehenden personenbezogenen Daten (Name, Anfrage) zum Zwecke der Bearbeitung Ihres Anliegens bei
uns gespeichert und verarbeitet. Diese Daten geben wir nicht ohne Ihre Einwilligung weiter. Die Verarbeitung
dieser Daten erfolgt auf Grundlage von Art. 6 Abs. 1 lit. b DSGVO, sofern Ihre Anfrage mit der Erfüllung eines
Vertrags zusammenhängt oder zur Durchführung vorvertraglicher Maßnahmen erforderlich ist. In allen übrigen
Fällen beruht die Verarbeitung auf Ihrer Einwilligung (Art. 6 Abs. 1 lit. A DSGVO) und / oder auf unseren
berechtigten Interessen (Art. 6 Abs. 1 lit. f DSGVO), da wir ein berechtigtes Interesse an der effektiven
Bearbeitung der an uns gerichteten Anfragen haben.
Die von Ihnen an uns per Kontaktanfragen übersandten Daten verbleiben bei uns, bis Sie uns zur Löschung
auffordern, Ihre Einwilligung zur Speicherung widerrufen oder der Zweck für die Datenspeicherung entfällt (z.
B. nach abgeschlossener Bearbeitung Ihres Anliegens). Zwingende gesetzliche Bestimmungen – insbesondere
gesetzliche Aufbewahrungsfristen – bleiben unberührt."),
h2("4. Newsletter"),
p(strong("Newsletterdaten")),
p("Wenn Sie den auf der Website angebotenen Newsletter beziehen möchten, benötigen wir von Ihnen eine E-
Mail-Adresse sowie Informationen, welche uns die Überprüfung gestatten, dass Sie der Inhaber der
angegebenen E-Mail-Adresse sind und mit dem Empfang des Newsletters einverstanden sind. Weitere Datenwerden nicht bzw. nur auf freiwilliger Basis erhoben. Diese Daten verwenden wir ausschließlich für den
Versand der angeforderten Informationen und geben diese nicht an Dritte weiter. Die Verarbeitung der in das
Newsletteranmeldeformular eingegebenen Daten erfolgt ausschließlich auf Grundlage Ihrer Einwilligung (Art. 6
Abs. 1 lit. a DSGVO). Die erteilte Einwilligung zur Speicherung der Daten, der E-Mail-Adresse sowie deren
Nutzung zum Versand des Newsletters können Sie jederzeit widerrufen, etwa über den Austragen-Link im
Newsletter. Die Rechtmäßigkeit der bereits erfolgten Datenverarbeitungsvorgänge bleibt vom Widerruf
unberührt. Die von Ihnen zum Zwecke des Newsletter-Bezugs bei uns hinterlegten Daten werden von uns bis zu
Ihrer Austragung aus dem Newsletter gespeichert und nach der Abbestellung des Newsletters gelöscht. Daten,
die zu anderen Zwecken bei uns gespeichert wurden bleiben hiervon unberührt."),
h2("5. Plugins und Tools"),
p(strong("Google Maps")),
p("Diese Seite nutzt über eine API den Kartendienst Google Maps. Anbieter ist die Google Inc., 1600
Amphitheatre Parkway, Mountain View, CA 94043, USA.
Zur Nutzung der Funktionen von Google Maps ist es notwendig, Ihre IP Adresse zu speichern. Diese
Informationen werden in der Regel an einen Server von Google in den USA übertragen und dort gespeichert.
Der Anbieter dieser Seite hat keinen Einfluss auf diese Datenübertragung.
Die Nutzung von Google Maps erfolgt im Interesse einer ansprechenden Darstellung unserer Online-
Angebote und an einer leichten Auffindbarkeit der von uns auf der Website angegebenen Orte. Dies stellt ein
berechtigtes Interesse im Sinne von Art. 6 Abs. 1 lit. f DSGVO dar.
Mehr Informationen zum Umgang mit Nutzerdaten finden Sie in der Datenschutzerklärung von Google:
https://policies.google.com/privacy?hl=de."),
p(strong("6. Analysetools und Cookies")),
p("Diese Website nutzt keine Analyse-Tools und setzt keine Cookies. Wenn Sie also während der Bestellung die
Seite neu Laden oder wechseln, müssen Sie anschließend Ihre Daten neu eingeben. Im Gegenzug werden Ihre
Aktivitäten (Nutzerverhalten) auf der Website nicht überwacht.")

          
          
  
  ),
tabItem(tabName = "agb", p("Hier könnt ihr die  AGB und Widerruf als pdf herunterladen"),
        br(),
        
        h1("AGB und Widerruf"),
        h2("Inhalt:"),
        h3("1.Bestellung und Vertragsschluss"),
        h3("2.Preise, Zahlungsverfahren und Lieferinformationen"),
        h3("3.Produktinfos"),
        h3("4.Mängelhaftungsrechts"),
        h3("5.Widerrufsrecht"),
        br(),
        h1("1. Bestellung und Vertragsschluss"),
        p("Ihr Vertragspartner ist:"),
        p("Wendelin Holz"),
        p("Sachsenkamstr. 17"),
        p("81369 München"),
        p("Tel: 015784624261"),
        p("E-Mail: holzwendelin@gmail.com"),
        br(),
        p("Durch das Anklicken des Buttons „Kaufen“ im Onlineshop von Wendels Kartenspiele oder durch das
Verschicken einer Bestell-Mail, geben Sie eine verbindliche Bestellung ab. Daraufhin erhalten Sie eine
E-Mail mit der Bestellbestätigung und der Rechnung. Gleichzeitig wird dadurch der Versand der Ware
ausgelöst.
Ein verbindlicher Kaufvertrag kommt erst zustande, wenn die Ware angeliefert, d.h. bei Ihnen
angekommen ist. Welche Widerrufsrechte Sie haben finden Sie im Absatz Widerrufsrecht. Wenn Sie
einen Kaufvertrag zugeschickt haben wollen, müssen Sie dies gesondert beim Vertragspartner
beantragen.
Wird das auf der Rechnung angegebene Zahlungsziel nicht eingehalten und auch nach erneuter und
wiederholter Aufforderung die Rechnung von Ihnen nicht bezahlt, müssen Sie damit rechnen, dass
ein Inkassounternehmen beauftragt oder sogar ein gerichtliches Mahnverfahren eingeleitet wird."),
        h1("2. Preise, Zahlungsverfahren und Lieferinformationen"),
        p("4,50 € pro Spiel + 2,50 € Versand"),
        p("Rabatte:"),
        p("3 unterschiedliche Spiele: 12 € + 2,5 € Versand"),
        p("Alle 5 Spiele: 20 € versandkostenfrei"),
        p("Ab 6 Spiele: 4 € pro Spiel versandkostenfrei, egal welches"),
        br(),
        p("Lieferzeiten innerhalb Deutschlands:"),
        p("I.d.R. 2 oder 3 Werktage. In seltenen Fällen bis 5 Werktage. Bei Versand ins Ausland kann die
Versandgebühr von den Angaben im Online Shop und auf der Webseite abweichen. Sie werden im
Fall der Fälle aber diesbezüglich vor Versand der Ware informiert."),
        p("Zahlung: Per Rechn"),
        p("Per Rechnung innerhalb von 14 Kalendertagen nach Erhalt der Ware via Bank-Überweisung. Für
alternative Zahlungsverfahren, wenden Sie sich gerne an die im Impressum angegebene
Kontaktperson."),
        h1("3. Produktinfos"),
        p("Jedes Spiel besteht aus 33 Spielkarten verpackt in Cellophan und in einem Klarsichtetui. Das Format
der Karten ist 59,0 x 91,0 mm und das Material ein 399 g/m2 Quartettkarton. Die Karten sind
beidseitig bedruckt, auf der Vorderseite farbig, aber der Rückseite schwarzweiß. Ein Kartenspiel
wiegt ca. 0,07 kg."),
        h1("4. Mängelhaftungsrecht"),
        p("Ist die Ware mangelhaft, haben Sie gemäß § 437 Abs. 1 bis 3 BGB „Rechte des Käufers bei Mängeln“
u.a. das Recht Nacherfüllung zu verlangen oder vom Vertrag zurück zu treten. Nach § 438 BGB
verjähren diese Ansprüche im Falle von Konsumgütern aber nach 2 Jahren.
Sind Sie ein Kaufmann i.S.d. HGB müssen Sie mir Mängel unverzüglich, spätestens jedoch innerhalb
einer Woche nach Erhalt der Ware, mitteilen. Mängel, die auch bei sorgfältiger Prüfung innerhalb
dieser Frist nicht entdeckt werden können, müssen unverzüglich nach der Entdeckung schriftlich
mitgeteilt werden.
Obwohl die Daten und Informationen, welche auf den Kartenspielen angegeben sind, mit größter
Sorgfalt recherchiert, zusammengetragen und mehrfach überprüft wurden, kann für die Richtigkeit
der Angaben keine Gewähr gegeben werden. Rein inhaltliche Fehler sind somit kein Mangel im Sinne
des § 437 BGB."),
        h1("5. Widerrufsrecht"),
        h2("Umtausch und Rückgaberecht"),
        p("Bei Wendels Kartenspiele haben Sie selbstverständlich volles Rückgaberecht und Sie kaufen ganz
ohne Risiko."),
        h2("Rücksendung"),
        h3("Widerrufsrecht"),
        p("Sie haben das Recht, binnen vierzehn Tagen ohne Angabe von Gründen diesen Vertrag zu
widerrufen."),
        br(),
        p("Die Widerrufsfrist beträgt vierzehn Tage ab dem Tag, an dem Sie oder ein von Ihnen benannter
Dritter, der nicht der Beförderer ist, die Ware in Besitz genommen haben. Um Ihr Widerrufsrecht
auszuüben, müssen Sie mich"),
        p("Wendelin Holz"),
        p("Sachsenkamstr. 17"),
        p("81369 München"),
        p("holzwendelin@gmail.com"),
        p("Telefon: 0049 15784624261"),
        p("mittels einer eindeutigen Erklärung (z. B. mit einem per Post versandten Brief, per Telefax oder E-
Mail) über Ihren Entschluss, diesen Vertrag zu widerrufen, informieren. Sie können dafür das u. g.
Muster-Widerrufsformular verwenden, das jedoch nicht vorgeschrieben ist. Zur Wahrung der
Widerrufsfrist reicht es aus, dass Sie die Mitteilung über die Ausübung des Widerrufsrechts vor
Ablauf der Widerrufsfrist absenden."),
        h3("Folgen des Widerrufs"),
        p("Wenn Sie diesen Kaufvertrag widerrufen, werde ich Ihnen alle Zahlungen, die ich von Ihnen erhalten
haben, einschließlich der Lieferkosten (Standardversand), unverzüglich und spätestens binnen
vierzehn Tagen ab dem Tag zurück zahlen, an dem die Mitteilung über Ihren Widerruf dieses Vertrags
bei mir eingegangen ist. Für diese Rückzahlung verwenden ich dasselbe Zahlungsmittel, das Sie bei
der ursprünglichen Transaktion eingesetzt haben, es sei denn, mit Ihnen wurde ausdrücklich etwas
anderes vereinbart; in keinem Fall werden Ihnen wegen dieser Rückzahlung Entgelte berechnet. Ich
kann die Rückzahlung verweigern, bis ich die Waren wieder zurückerhalten habe oder bis Sie den
Nachweis erbracht haben, dass Sie die Waren zurückgesandt haben, je nachdem, welches der
frühere Zeitpunkt ist.
Sie haben die Waren unverzüglich und in jedem Fall spätestens binnen vierzehn Tagen ab dem Tag,
an dem Sie mich über den Widerruf dieses Vertrags unterrichten, an mich zurückzusenden oder zu
übergeben. Die Frist ist gewahrt, wenn Sie die Waren vor Ablauf der Frist von vierzehn Tagen
absenden."),
        h2("Muster-Widerrufsformular"),
        img(src = "agb.png")
        
        
)
)
)
)
)


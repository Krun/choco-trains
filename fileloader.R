if(!exists("antequera")){
  antequera <- read.csv("Datos/antequera.csv", header = TRUE, sep=";")
}
 
 if(!exists("segovia")) {
   segovia <- read.csv("Datos/segovia.csv", header = TRUE, sep=";")
 }
 
 if(!exists("sevilla")){
   sevilla <- read.csv("Datos/sevilla.csv", header = TRUE, sep=";")
 }
 
 if(!exists("camas")) {
   camas <- read.csv("Datos/camas.csv", header = TRUE, sep=";")
 }
 
 if(!exists("errortext")) {
   errortext <- read.csv("Datos/messagetexts.csv", header = TRUE, sep=";")
 }

sevilla[sevilla$EVENT_TYPE == "FieldElementFailure",]$EVENT_TYPE = "fieldElementFailure"
sevilla$EVENT_TYPE <- droplevels(sevilla$EVENT_TYPE)

antequera$DVNS_ERRORTIME <- as.POSIXlt(strptime(antequera$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
segovia$DVNS_ERRORTIME <- as.POSIXlt(strptime(segovia$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
sevilla$DVNS_ERRORTIME <- as.POSIXlt(strptime(sevilla$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
camas$DVNS_ERRORTIME <- as.POSIXlt(strptime(camas$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
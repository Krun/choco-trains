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
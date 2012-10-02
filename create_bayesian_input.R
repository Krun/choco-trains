source("translate_messages.R")

target <- sevilla
filename <- "bayesian_input/bayesian_sevilla_hours.txt"
groupinterval <- (60*60) #División entera. Segundos que hay en una hora o dia

b_data = data.frame(ERROR = target$ADDITIONAL_TEXT)
b_data$DVNI_INSTALLATIONCODE = target$DVNI_INSTALLATIONCODE
b_data$DVNS_ERRORTIME = target$DVNS_ERRORTIME

rm(target)

b_data$DVNI_INSTALLATIONCODE <- as.factor(b_data$DVNI_INSTALLATIONCODE)
b_data$ERROR <- as.factor(b_data$ERROR)
b_data$DVNS_ERRORTIME <- as.factor(b_data$DVNS_ERRORTIME)

names(b_data)[names(b_data)=="DVNI_INSTALLATIONCODE"] <- "sequenceID"
names(b_data)[names(b_data)=="DVNS_ERRORTIME"] <- "eventID"

b_data$eventID <- strptime(b_data$eventID, "%Y-%m-%d %H:%M:%S")
b_data$eventID <- as.numeric(b_data$eventID)
b_data$eventID <- b_data$eventID - min(b_data$eventID)
b_data$eventID <- as.numeric(b_data$eventID) %/% groupinterval
b_data$eventID <- as.factor(b_data$eventID)

b_data <- b_data[order(b_data$sequenceID, b_data$eventID), ]

b_data_split <- split(b_data, b_data$eventID)

alarms <- levels(b_data_split[[1]]$ERROR)
#alarmtext <- unlist(lapply(alarms,translate_error))

cat(file=filename, alarms, "\n", append=FALSE) 
for(i in 1:length(b_data_split)){
  b_data_frame <- b_data_split[[i]]

  sameseq$sequenceID <- NULL
  items <- alarms %in% b_data_frame$ERROR
  if(length(items) > 0){
    cat(file=filename, items, "\n", append=TRUE)
  }
  rm(b_data_frame)
}

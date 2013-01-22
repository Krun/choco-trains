target <- antequera
bfile = "baskets/antequera_baskets.txt"

#prep <- data.frame(ERROR = paste(antequera$ADDITIONAL_TEXT,gsub(" ","_",antequera$ADDITIONAL_INFOS),sep='#'))
prep <- data.frame(ERROR = target$ADDITIONAL_TEXT)
prep$ERROR <- as.factor(prep$ERROR)
prep$TYPE <- target$EVENT_TYPE

prep$sequenceID <- as.factor(target$DVNI_INSTALLATIONCODE)
prep$eventID <- as.factor(target$DVNS_ERRORTIME)

prep$eventID <- strptime(prep$eventID, "%Y-%m-%d %H:%M:%S")
prep$eventID <- as.numeric(prep$eventID)
prep$eventID <- prep$eventID - min(prep$eventID)
prep$eventID <- as.numeric(prep$eventID) %/% (60*60*24) #Pasamos de segundos a dias.
prep$eventID <- as.factor(prep$eventID)

get_triggers <- function(antecedent, testset) {
  triggers <- testset[testset$event == antecedent[[1]], ]
  triggers$event <- NULL
  if (length(antecedent) == 1){
    return(triggers)
  }
  #else, continue applying conditions to find triggers
  for(i in 2:length(antecedent)){
    triggersn <- testset[testset$event == antecedent[[i]], ]
    triggersn$event <- NULL
    triggers <- merge(triggers, triggersn, by=c("time","installation"))
  }
  return(triggers)
}

precision <- function(antecedent,consequent,testset,winmax,winmin=1) {
  triggers <-get_triggers(antecedent,testset)
  success = 0;
  for(i in 1:nrow(triggers)){
    ins <- triggers[i,]$installation
    tim <- triggers[i,]$time
    valid <- subset(testset, time >= tim+winmin & time <= tim+winmax & installation == ins & event == consequent[[1]])
    success = success + (nrow(valid) >= 1)
  }
  return(success/nrow(triggers))
}
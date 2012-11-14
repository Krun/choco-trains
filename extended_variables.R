library(plyr)

target <- antequera_alimentacion

prep <- data.frame(ERROR = factor(target$ADDITIONAL_TEXT))

prep$sequenceID <- as.factor(target$DVNI_INSTALLATIONCODE)
prep$eventID <- as.factor(target$DVNS_ERRORTIME)

additional_columns <- levels(prep$ERROR)

prep$eventID <- strptime(prep$eventID, "%Y-%m-%d %H:%M:%S")
prep$eventID <- as.numeric(prep$eventID)
prep$eventID <- prep$eventID - min(prep$eventID)
prep$eventID <- as.numeric(prep$eventID) %/% (60*60*24) #Pasamos de segundos a dias.
prep$eventID <- as.factor(prep$eventID)



new <- data.frame(eventID = prep$eventID, sequenceID = prep$sequenceID)
new <- new[!duplicated(new), ]

maxday <- max(as.numeric(as.character(new$eventID)))

days <- 1:maxday
seqs <- levels(factor(prep$sequenceID))
allindexes = expand.grid(days, seqs)
colnames(allindexes) <- c("eventID", "sequenceID")

for (i in 1:length(additional_columns)){
  newid <- length(names(new)) + 1
  new[,newid] = 0;
  colnames(new)[newid] <- additional_columns[[i]]
  for (j in 1:nrow(new)) {
    new[j,newid] <- nrow(subset(prep, sequenceID == new$sequenceID, eventID == new$eventID[[j]] & ERROR == additional_columns[[i]]))
  }
}

allindexes <- merge(allindexes,new,all.x=TRUE, by=c("eventID", "sequenceID"))
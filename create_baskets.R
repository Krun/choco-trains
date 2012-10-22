

#f_antequera <- antequera

f_antequera <- data.frame(ERROR = paste(antequera$ADDITIONAL_TEXT,gsub(" ","_",antequera$ADDITIONAL_INFOS),sep='#'))
f_antequera$ERROR <- as.factor(f_antequera$ERROR)

f_antequera$sequenceID <- as.factor(antequera$DVNI_INSTALLATIONCODE)
f_antequera$eventID <- as.factor(antequera$DVNS_ERRORTIME)

f_antequera$eventID <- strptime(f_antequera$eventID, "%Y-%m-%d %H:%M:%S")
f_antequera$eventID <- as.numeric(f_antequera$eventID)
f_antequera$eventID <- f_antequera$eventID - min(f_antequera$eventID)
f_antequera$eventID <- as.numeric(f_antequera$eventID) %/% (60*60*24) #Pasamos de segundos a dias.
f_antequera$eventID <- as.factor(f_antequera$eventID)

f_antequera <- f_antequera[order(f_antequera$sequenceID, f_antequera$eventID), ]
f_antequera <- f_antequera[!duplicated(f_antequera),]

f_antequera_split <- split(f_antequera, f_antequera$sequenceID) 
#http://r.789695.n4.nabble.com/transaction-object-how-to-coerce-this-data-td2402613.html

options(max.print=5.5E8)

cat(file="basket.txt")
for(i in 1:length(f_antequera_split)){
  sameseq <- f_antequera_split[[i]]
  seqnum <- as.numeric(sameseq$sequenceID[1])
  sameseq$sequenceID <- NULL
  eventsplit <- split(sameseq, sameseq$eventID)
  for (j in 1:length(eventsplit)){
    time <- as.numeric(eventsplit[[j]]$eventID[1])
    items <- as.character(eventsplit[[j]]$ERROR)
    size <- length(items)
    if(size > 0){
      cat(file="basket.txt", seqnum, time, size, items, "\n", append=TRUE)
    }
  }
}

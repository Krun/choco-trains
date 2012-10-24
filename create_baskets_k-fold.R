target <- antequera
bfile = "baskets/antequera_baskets" #sin extension

n <- 10
sptest <- split(target, factor(sort(rank(row.names(target))%%n)))

create_k_basket_files <- function(target,name,k) {
  splits <- split(target, factor(sort(rank(row.names(target))%%k)))
  for (i in 1:length(splits)){
    single_frame <- splits[[i]]
    create_basket_file(single_frame,paste(name,i,".txt",sep=""))
  }
}

create_basket_file <-function(target, bfile) {
  #prep <- data.frame(ERROR = paste(antequera$ADDITIONAL_TEXT,gsub(" ","_",antequera$ADDITIONAL_INFOS),sep='#'))
  prep <- data.frame(ERROR = target$ADDITIONAL_TEXT)
  prep$ERROR <- as.factor(prep$ERROR)
  
  prep$sequenceID <- as.factor(target$DVNI_INSTALLATIONCODE)
  prep$eventID <- as.factor(target$DVNS_ERRORTIME)
  prep$eventID <- strptime(prep$eventID, "%Y-%m-%d %H:%M:%S")
  prep$eventID <- as.numeric(prep$eventID)
  prep <- prep[complete.cases(prep),]
  prep$eventID <- prep$eventID - min(prep$eventID)
  prep$eventID <- as.numeric(prep$eventID) %/% (60*60*24) #Pasamos de segundos a dias.
  prep$eventID <- as.factor(prep$eventID)
  
  prep <- prep[order(prep$sequenceID, prep$eventID), ]
  prep <- prep[!duplicated(prep),]
  
  prep_split <- split(prep, prep$sequenceID) 
  #http://r.789695.n4.nabble.com/transaction-object-how-to-coerce-this-data-td2402613.html
  
  options(max.print=5.5E8)
  
  
  
  cat(file=bfile)
  for(i in 1:length(prep_split)){
    sameseq <- prep_split[[i]]
    seqnum <- as.numeric(sameseq$sequenceID[1])
    sameseq$sequenceID <- NULL
    eventsplit <- split(sameseq, sameseq$eventID)
    for (j in 1:length(eventsplit)){
      time <- as.numeric(eventsplit[[j]]$eventID[1])
      items <- as.character(eventsplit[[j]]$ERROR)
      size <- length(items)
      if(size > 0){
        cat(file=bfile, seqnum, time, size, items, "\n", append=TRUE)
      }
    }
  }
}

rm(bfile)
rm(prep_split)
rm(target)
rm(prep)
rm(size)
rm(time)
rm(items)
rm(i)
rm(j)
rm(eventsplit)
rm(seqnum)
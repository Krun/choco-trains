source('validation.R')

graph_stats <- function() {
  
  plot(autos_data$cars, type="l", col=plot_colors[1], 
       ylim=range(autos_data), axes=F, ann=T, xlab="Days",
       ylab="Total", cex.lab=0.8, lwd=2)
  lines(autos_data$trucks, type="l", lty=2, lwd=2, 
        col=plot_colors[2])
}


tabulate_stats <- function(target,rulefile,days=10) {
  n_target <- normalize_and_group(target,days)
  statdata <- expand_indexes(target,days)
  statdata$numalarms <- 0
  for(i in 1:nrow(statdata)) {
    statdata$numalarms[i] <- numalarms(statdata$eventID[[i]], statdata$sequenceID[[i]], n_target)
  }
  return(statdata)
}

expand_indexes <- function(target, days = 1) {
  sid <- as.factor(target$DVNI_INSTALLATIONCODE)
  eid <- as.factor(target$DVNS_ERRORTIME)
  eid <- strptime(eid, "%Y-%m-%d %H:%M:%S")
  eid <- as.numeric(eid)
  eid <- eid - min(eid)
  eid <- as.numeric(eid) %/% (60*60*24*days) #Pasamos de segundos a dias.
  maxday <- max(as.numeric(as.character(eid)))
  days <- 0:maxday
  seqs <- levels(factor(sid))
  
  allindexes = expand.grid(days, seqs)
  colnames(allindexes) <- c("eventID", "sequenceID")
  return(allindexes)
  
}

normalize_and_group <- function(target,days = 10) {
  prep <- data.frame(ERROR = target$ADDITIONAL_TEXT)
  prep$ERROR <- as.factor(prep$ERROR)
  
  prep$sequenceID <- as.factor(target$DVNI_INSTALLATIONCODE)
  prep$eventID <- as.factor(target$DVNS_ERRORTIME)
  prep$eventID <- strptime(prep$eventID, "%Y-%m-%d %H:%M:%S")
  prep$eventID <- as.numeric(prep$eventID)
  prep <- prep[complete.cases(prep),]
  prep$eventID <- prep$eventID - min(prep$eventID)
  prep$eventID <- as.numeric(prep$eventID) %/% (60*60*24*days) #Pasamos de segundos a dias.
  prep$eventID <- as.numeric(as.character(prep$eventID))
  
  prep <- prep[order(prep$eventID, prep$sequenceID), ]
  prep <- prep[!duplicated(prep),]
  rownames(prep) <- NULL
  return(prep)
}

numalarms <- function(eid, sid, n_target) {
  sub <- n_target[n_target$eventID == eid & n_target$sequenceID == sid,]
  num <- nrow(sub)
  return(num)
}
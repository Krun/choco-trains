precision <- function(antecedent,consequent,testset,winmax,winmin=1) {
  for(i in 1:length(antecedent)){
    testset$time <- as.numeric(testset$time)
    testset$installation <- as.numeric(testset$installation)
    triggers <-get_triggers(antecedent,testset)
    success = 0;
    for(i in 1:nrow(triggers)){
      ins <- triggers[i,]$installation
      tim <- triggers[i,]$time
      valid <- subset(testset, time >= tim+winmin & time <= tim+winmax & installation == ins & event == consequent[[1]])
      success = success + (nrow(valid) >= 1)
    }
  }
  return(success/nrow(triggers))
}

recall <- function(antecedent, consequent, testset, winmax, winmin=1) {
  triggers <-get_triggers(antecedent,testset)
  numtriggers <- nrow(triggers)
  precision <- precision(antecedent,consequent,testset,winmax,winmin)
  valid_predictions <- precision * numtriggers
  numconsequent <- nrow(testset[testset$event == consequent[[1]], ])
  recall <- valid_predictions/numconsequent
  return(recall)
}

get_triggers <- function(antecedent, testset) {
  triggers <- testset[testset$event == antecedent[[1]], ]
  for(i in 2:length(antecedent)){
    triggersn <- testset[testset$event == antecedent[[i]], ]
    triggers <- merge(triggers, triggersn, by=c("time","installation"))
  }
  return(triggers)
}




rule = "<{saml.status.channel_A_CS_unknown,saml.status.channel_B_CS_unknown},{saml.status.channel_B_down}>"
rule = processrule(rule)
antecedent = rule[[1]]
consequent = rule[[2]]
winmax = 80
winmin = 1
testset = load_baskets(filename="baskets/antequera_1_test.txt")
testset$time <- as.numeric(testset$time)
testset$installation <- as.numeric(testset$installation)

triggers <- testset[testset$event == antecedent[[1]], ]
for(i in 2:length(antecedent)){
  triggersn <- testset[testset$event == antecedent[[i]], ]
  triggers <- merge(triggers, triggersn, by=c("time","installation"))
}
success = 0;
for(i in 1:nrow(triggers)){
  ins <- triggers[i,]$installation
  tim <- triggers[i,]$time
  valid <- subset(testset, time >= tim+winmin & time <= tim+winmax & installation == ins & event == consequent[[1]])
  success = success + (nrow(valid) >= 1)
}


# success = 0;
# for(w in winmin:winmax){
#   disp <- testset
#   disp$time <- testset$time-w
#   disp <- disp[disp$event == consequent[[1]],]
#   valid <- merge(triggers,disp, by=c("time","installation"))
#   success = success + nrow(valid)
# }



processrule <- function(rule) {
  #<{A,B},{C,D}>
  splitrule <- strsplit(rule,"{", fixed=TRUE)[[1]]
  antecedent <- strsplit(splitrule[[2]],"}", fixed=TRUE)[[1]][[1]]
  antecedent <- strsplit(antecedent,",",fixed=TRUE)[[1]]
  consequent <- strsplit(splitrule[[3]],"}", fixed=TRUE)[[1]][[1]]
  consequent <- strsplit(consequent,",",fixed=TRUE)[[1]]
  return(list(antecedent,consequent))
}

load_baskets <- function(filename) {
  con <- file(filename, "rt") 
  conbaskets <- readLines(con, -1)
  close(con)
  df <- NULL
  for(i in 1:length(baskets)){
    line <- strsplit(baskets[[i]]," ",fixed=TRUE)
    line <- line[[1]]
    eventid <- line[[1]]
    sequenceid <- line[[2]]
    for(j in 4:length(line)){
      df <- rbind(df,data.frame(time = eventid, installation = sequenceid, event=line[[j]]))
    }
  }
  return(df)
}

processrule <- function(rule) {
  #<{A,B},{C,D}>
  splitrule <- strsplit(rule,"{", fixed=TRUE)[[1]]
  antecedent <- strsplit(splitrule[[2]],"}", fixed=TRUE)[[1]][[1]]
  antecedent <- strsplit(antecedent,",",fixed=TRUE)[[1]]
  consequent <- strsplit(splitrule[[3]],"}", fixed=TRUE)[[1]][[1]]
  consequent <- strsplit(consequent,",",fixed=TRUE)[[1]]
  return(list(antecedent,consequent))
}

precision <- function(antecedent,consequent,window,testset) {
  for(i in 1:length(antecedent)){
    triggers <- 
  }
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
library(arules)
library(arulesSequences)

k = 10
name = "antequera_alimentacion"
path = "baskets/"
pathr = "output/sequences/"
params = list(support=0.3, mingap=1, maxgap=1, maxlen=2, maxsize=5)
for (i in 5:k) {
  filename <- paste(path,name,"_",i,"_learn.txt",sep="")
  info <- c("sequenceID","eventID","SIZE")
  x <- read_baskets(con = filename, info = info)
  cat("Executing cSPADE for",name,i,"\n")
  s <- cspade(x, parameter=params)
  cat("Done\n")
  cat("Converting results to data frame\n")
  s <- as(s,"data.frame")
  cat("Done\n")
  filenamer <- paste(pathr,name,"_",i,".txt",sep="")
  cat("Writing data frame to",filenamer,"\n")
  write.csv(s,file=filenamer)
  cat("Done")
}
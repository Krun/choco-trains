name="antequera_alimentacion"
path="output/sequences/performance/meanperformance/"

filename <- paste(path,name,"_meanperformance.txt",sep="")

rules <- read.csv(filename, header = TRUE)

levels <- 5*1:20
counts <- sapply(levels, pcount, rules=rules)

num <- data.frame(level=levels, counts=counts)


barplot(counts, main="Car Distribution", horiz=FALSE, names.arg=levels, col="darkblue")


pcount <- function (p,rules) {
  prec <- p/100
  n <- nrow(rules[rules$precision>=prec,])
  return(n)
}
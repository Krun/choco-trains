library(arules)
library(arulesSequences)

x <- read_baskets(con = "basket.txt", info = c("sequenceID","eventID","SIZE"))
# defaults: 
# maxsize = 10 (maximum items on an element on a sequence)
# maxlen = 10 (maximum elements on a sequence)
# mingap = none
# maxgap = none
# maxwin = none
# support = 0.1
s1 <- cspade(x, parameter=list(support = 0.3), control=list(verbose = TRUE))
#s2 <- cspade(x, parameter=list(support = 0.1, maxwin = 5, maxlen = 2, maxsize = 2), control=list(verbose = TRUE))
sink("results_2.txt")
as(s1,"data.frame")
sink()
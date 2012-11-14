library(arules)
library(arulesSequences)

y <- read_baskets(con = "baskets/test_1_test.txt", info = c("eventID","sequenceID","SIZE"))
#y <- read_baskets(con = "baskets/test_1_test.txt")
#View(as(y,"data.frame"))
params = list(support=0.01, mingap=1, maxgap=1, maxlen=2, maxsize=5)

y1 <- cspade(y, parameter=params)
y1 <- as(y1,"data.frame")
View(y1)

x <- read_baskets(con = "basket.txt", info = c("sequenceID","eventID","SIZE"))
# defaults: 
# maxsize = 10 (maximum items on an element on a sequence)
# maxlen = 10 (maximum elements on a sequence)
# mingap = none
# maxgap = none
# maxwin = none
# support = 0.1
#s1 <- cspade(x, parameter=list(support = 0.3), control=list(verbose = TRUE))
#s2 <- cspade(x, parameter=list(support = 0.1, maxwin = 5, maxlen = 2, maxsize = 2), control=list(verbose = TRUE))
sink("results_2.txt")
as(s1,"data.frame")
sink()

x1 <- read_baskets(con = "baskets/antequera_alimentacion_1_learn.txt", info = c("sequenceID","eventID","SIZE"))
x2 <- read_baskets(con = "baskets/antequera_alimentacion_2_learn.txt", info = c("sequenceID","eventID","SIZE"))
x3 <- read_baskets(con = "baskets/antequera_alimentacion_3_learn.txt", info = c("sequenceID","eventID","SIZE"))
x4 <- read_baskets(con = "baskets/antequera_alimentacion_4_learn.txt", info = c("sequenceID","eventID","SIZE"))
x5 <- read_baskets(con = "baskets/antequera_alimentacion_5_learn.txt", info = c("sequenceID","eventID","SIZE"))
x6 <- read_baskets(con = "baskets/antequera_alimentacion_6_learn.txt", info = c("sequenceID","eventID","SIZE"))
x7 <- read_baskets(con = "baskets/antequera_alimentacion_7_learn.txt", info = c("sequenceID","eventID","SIZE"))
x8 <- read_baskets(con = "baskets/antequera_alimentacion_8_learn.txt", info = c("sequenceID","eventID","SIZE"))
x9 <- read_baskets(con = "baskets/antequera_alimentacion_9_learn.txt", info = c("sequenceID","eventID","SIZE"))
x10 <- read_baskets(con = "baskets/antequera_alimentacion_10_learn.txt", info = c("sequenceID","eventID","SIZE"))


params = list(support=0.1, mingap=1, maxgap=1, maxlen=2, maxsize=5)

s1 <- cspade(x1, parameter=params)
s1 <- as(s1,"data.frame")

bfile = "sequences/antequera_alimentacion_1.txt"

write.csv(s1, file=bfile)

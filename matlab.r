library(DBI)
library(RMySQL)
library(lattice)
drv <- dbDriver("MySQL")

correlationgraph <- function(data, filename, title="Alarms correlation") {
    x = NULL
    dates = levels(factor(data$DATE))
    for (i in 1:length(dates)) {
        n = as.list(table(segovia[data$DATE == dates[i],]$EVENT_TYPE))
        x = rbind(x,unlist(n))
    }
    xf = as.data.frame(x)
    xf$DATE = dates

    corr = cor(xf[,1:length(names(xf))-1])

    png(filename, width=1000, height=900, res=100)
    rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
    levelplot(corr, main=title, xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01))

    dev.off()
}

dbsegovia <- dbConnect(drv,dbname="BDAlcatel_segovia_dbo","root","root")
segovia <- dbGetQuery(dbsegovia,"select * from ER_ERRORS JOIN ERH_ERRORS_HSL1 using(DVNI_ERRORNUMBER)")
segovia$DVNS_ERRORTIME <- as.POSIXlt(strptime(segovia$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
segovia$EVENT_TYPE = factor(segovia$EVENT_TYPE)
segovia$DATE = as.Date(segovia$DVNS_ERRORTIME)



dbantequera <- dbConnect(drv,dbname="BDAlcatel_Antequera_dbo","root","root")
antequera <- dbGetQuery(dbantequera,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER)")
antequera$DVNS_ERRORTIME <- as.POSIXlt(strptime(antequera$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
antequera$EVENT_TYPE = factor(antequera$EVENT_TYPE)
antequera$DATE = as.Date(antequera$DVNS_ERRORTIME)



dbsevilla <- dbConnect(drv,dbname="BDAlcatel_Sevilla_dbo","root","root")
sevilla <- dbGetQuery(dbsevilla,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER)")
sevilla$DVNS_ERRORTIME <- as.POSIXlt(strptime(sevilla$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
sevilla[sevilla$EVENT_TYPE == "FieldElementFailure",]$EVENT_TYPE = "fieldElementFailure"
sevilla$EVENT_TYPE = factor(sevilla$EVENT_TYPE)
sevilla$DATE = as.Date(sevilla$DVNS_ERRORTIME)




dbcamas <- dbConnect(drv,dbname="BDAlcatel_Camas_dbo","root","root")
camas <- dbGetQuery(dbcamas,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER)")
camas$DVNS_ERRORTIME <- as.POSIXlt(strptime(camas$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
camas$EVENT_TYPE = factor(camas$EVENT_TYPE)
camas$DATE = as.Date(camas$DVNS_ERRORTIME)



correlationgraph(segovia, "segovia_correlation.png", "Segovia - Daily alarm correlation")
correlationgraph(antequera, "antequera_correlation.png", "Antequera - Daily alarm correlation")
correlationgraph(sevilla, "sevilla_correlation.png", "Sevilla - Daily alarm correlation")
correlationgraph(camas, "camas_correlation.png", "Camas - Daily alarm correlation")





dates = levels(factor(segovia$DATE))
types = levels(segovia$EVENT_TYPE)
x = NULL
for (i in 1:length(dates)) {
    n = as.list(table(segovia[segovia$DATE == dates[i],]$EVENT_TYPE))
    x = rbind(x,unlist(n))
}
xf = as.data.frame(x)
xf$DATE = dates

corr = cor(xf[,1:length(names(xf))-1])
symnum(corr)

png("segovia_correlation.png", width=1000, height=900, res=100)
rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
levelplot(corr, main="Segovia - Daily alarm correlation", xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01))
dev.off()



dates = levels(factor(sevilla$DATE))
types = levels(sevilla$EVENT_TYPE)
x = NULL
for (i in 1:length(dates)) {
    n = as.list(table(sevilla[sevilla$DATE == dates[i],]$EVENT_TYPE))
    x = rbind(x,unlist(n))
}
xf = as.data.frame(x)
xf$DATE = dates

corr = cor(xf[,1:length(names(xf))-1])
symnum(corr)

png("sevilla_correlation.png", width=1000, height=900, res=100)
rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
levelplot(corr, main="Sevilla - Daily alarm correlation", xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01))
dev.off()


dates = levels(factor(camas$DATE))
types = levels(camas$EVENT_TYPE)
x = NULL
for (i in 1:length(dates)) {
    n = as.list(table(camas[camas$DATE == dates[i],]$EVENT_TYPE))
    x = rbind(x,unlist(n))
}
xf = as.data.frame(x)
xf$DATE = dates

corr = cor(xf[,1:length(names(xf))-1])
symnum(corr)

png("camas_correlation.png", width=1000, height=900, res=100)
rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
levelplot(corr, main="Camas - Daily alarm correlation", xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01))
dev.off()

dates = levels(factor(antequera$DATE))
types = levels(antequera$EVENT_TYPE)
x = NULL
for (i in 1:length(dates)) {
    n = as.list(table(antequera[antequera$DATE == dates[i],]$EVENT_TYPE))
    x = rbind(x,unlist(n))
}
xf = as.data.frame(x)
xf$DATE = dates

corr = cor(xf[,1:length(names(xf))-1])
symnum(corr)

png("antequera_correlation.png", width=1000, height=900, res=100)
rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
levelplot(corr, main="Antequera - Daily alarm correlation", xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01))
dev.off()



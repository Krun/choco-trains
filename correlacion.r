library(DBI)
library(RMySQL)
library(lattice)
drv <- dbDriver("MySQL")

orgdata <- antequera
filename <- "graphs/correlations/antequera_corr.png"
title <- "Antequera - Alarms correlation"

orgdata <- sevilla
filename <- "graphs/correlations/sevilla_corr.png"
title <- "Sevilla - Alarms correlation"

orgdata <- segovia
filename <- "graphs/correlations/segovia_corr.png"
title <- "Segovia - Alarms correlation"


correlationgraph <- function(orgdata, filename, title="Alarms correlation") {
    data <- orgdata[orgdata$EVENT_TYPE != "other",]
    data$DVNS_ERRORTIME <- as.POSIXlt(strptime(data$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
    data$EVENT_TYPE = factor(data$EVENT_TYPE)
    data$DATE = as.Date(data$DVNS_ERRORTIME)
    x = NULL
    dates = levels(factor(data$DATE))
    for (i in 1:length(dates)) {
        n = as.list(table(data[data$DATE == dates[i],]$EVENT_TYPE))
        x = rbind(x,unlist(n))
    }
    xf = as.data.frame(x)
    xf$DATE = dates

    corr = cor(xf[,1:length(names(xf))-1])

    png(filename, width=1000, height=900, res=150)
    rgb.palette <- colorRampPalette(c("white", "yellow","orange", "red", "black"), space = "rgb")
    levelplot(corr, main=title, xlab="", ylab="", col.regions=rgb.palette(120), cuts=100, at=seq(0,1,0.01), scales = list(x = list(rot = 45)))
    

    dev.off()
}




segovia$DVNS_ERRORTIME <- as.POSIXlt(strptime(segovia$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
segovia$EVENT_TYPE = factor(segovia$EVENT_TYPE)
segovia$DATE = as.Date(segovia$DVNS_ERRORTIME)

antequera$DVNS_ERRORTIME <- as.POSIXlt(strptime(antequera$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
antequera$EVENT_TYPE = factor(antequera$EVENT_TYPE)
antequera$DATE = as.Date(antequera$DVNS_ERRORTIME)

sevilla$DVNS_ERRORTIME <- as.POSIXlt(strptime(sevilla$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
sevilla[sevilla$EVENT_TYPE == "FieldElementFailure",]$EVENT_TYPE = "fieldElementFailure"
sevilla$EVENT_TYPE = factor(sevilla$EVENT_TYPE)
sevilla$DATE = as.Date(sevilla$DVNS_ERRORTIME)

camas$DVNS_ERRORTIME <- as.POSIXlt(strptime(camas$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
camas$EVENT_TYPE = factor(camas$EVENT_TYPE)
camas$DATE = as.Date(camas$DVNS_ERRORTIME)


correlationgraph(segovia, "segovia_correlation.png", "Segovia - Daily alarm correlation")
correlationgraph(antequera, "antequera_correlation.png", "Antequera - Daily alarm correlation")
correlationgraph(sevilla, "sevilla_correlation.png", "Sevilla - Daily alarm correlation")
correlationgraph(camas, "camas_correlation.png", "Camas - Daily alarm correlation")
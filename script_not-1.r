library(DBI)
library(RMySQL)
drv <- dbDriver("MySQL")
dbsegovia <- dbConnect(drv,dbname="BDAlcatel_segovia_dbo","root","root")
dbantequera <- dbConnect(drv,dbname="BDAlcatel_Antequera_dbo","root","root")
dbsevilla <- dbConnect(drv,dbname="BDAlcatel_Sevilla_dbo","root","root")
dbcamas <- dbConnect(drv,dbname="BDAlcatel_Camas_dbo","root","root")
segovia <- dbGetQuery(dbsegovia,"select * from ER_ERRORS JOIN ERH_ERRORS_HSL1 using(DVNI_ERRORNUMBER) WHERE DVNI_ERRORCATEGORY != '-1'")
antequera <- dbGetQuery(dbantequera,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER) WHERE DVNI_ERRORCATEGORY != '-1'")
sevilla <- dbGetQuery(dbsevilla,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER) WHERE DVNI_ERRORCATEGORY != '-1'")
camas <- dbGetQuery(dbcamas,"select * from ER_ERRORS JOIN ERS_ERRORS_SAM_ENCE using(DVNI_ERRORNUMBER) WHERE DVNI_ERRORCATEGORY != '-1'")

png("segovia_graph.png", width=1500, height=700, res=200)
par(mfrow=c(1,3), mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(segovia$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="Segovia - Event type", las=3)
barplot(tabla<-prop.table(table(segovia$INVOKE_TYPE)), col=rainbow(length(names(tabla))), main="Segovia - Invoke type")
barplot(tabla<-prop.table(table(segovia$DVNI_ERRORCATEGORY)),col=rainbow(length(names(tabla))), main="Segovia - Error category")
#pie3D(tabla<-table(segovia$INVOKE_TYPE), explode=0.1, main="Segovia - Invoke Type")
dev.off()

png("antequera_graph.png", width=1500, height=700, res=200)
par(mfrow=c(1,3), mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(antequera$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="antequera - Event type", las=3)
barplot(tabla<-prop.table(table(antequera$INVOKE_TYPE)), col=rainbow(length(names(tabla))), main="antequera - Invoke type")
barplot(tabla<-prop.table(table(antequera$DVNI_ERRORCATEGORY)),col=rainbow(length(names(tabla))), main="antequera - Error category")
#pie3D(tabla<-table(antequera$INVOKE_TYPE), explode=0.1, main="antequera - Invoke Type")
dev.off()

png("camas_graph.png", width=1500, height=700, res=200)
par(mfrow=c(1,3), mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(camas$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="camas - Event type", las=3)
barplot(tabla<-prop.table(table(camas$INVOKE_TYPE)), col=rainbow(length(names(tabla))), main="camas - Invoke type")
barplot(tabla<-prop.table(table(camas$DVNI_ERRORCATEGORY)),col=rainbow(length(names(tabla))), main="camas - Error category")
#pie3D(tabla<-table(camas$INVOKE_TYPE), explode=0.1, main="camas - Invoke Type")
dev.off()

png("sevilla_graph.png", width=1500, height=700, res=200)
par(mfrow=c(1,3), mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(sevilla$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="sevilla - Event type", las=3)
barplot(tabla<-prop.table(table(sevilla$INVOKE_TYPE)), col=rainbow(length(names(tabla))), main="sevilla - Invoke type")
barplot(tabla<-prop.table(table(sevilla$DVNI_ERRORCATEGORY)),col=rainbow(length(names(tabla))), main="sevilla - Error category")
#pie3D(tabla<-table(sevilla$INVOKE_TYPE), explode=0.1, main="sevilla - Invoke Type")
dev.off()

segovia$DVNS_ERRORTIME <- as.POSIXlt(strptime(segovia$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
sevilla$DVNS_ERRORTIME <- as.POSIXlt(strptime(sevilla$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
antequera$DVNS_ERRORTIME <- as.POSIXlt(strptime(antequera$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))
camas$DVNS_ERRORTIME <- as.POSIXlt(strptime(camas$DVNS_ERRORTIME, "%Y-%m-%d %H:%M:%S"))

camas$EVENT_TYPE = factor(camas$EVENT_TYPE)
sevilla$EVENT_TYPE = factor(sevilla$EVENT_TYPE)
antequera$EVENT_TYPE = factor(antequera$EVENT_TYPE)
segovia$EVENT_TYPE = factor(segovia$EVENT_TYPE)


errorsplot <- function(data, filename, title="Hourly distribution", besid=FALSE) {
    types = levels(data$EVENT_TYPE)
    stacks = NULL
    for(i in 1:length(types)){
     ns = data[data$EVENT_TYPE == types[i],]
     hour = factor(ns$DVNS_ERRORTIME$hour,levels=(0:23))
     stacks = rbind(stacks,table(hour))
    }
    png(filename, width=1000, height=900, res=100)
    layout(matrix(c(1,2),byrow=TRUE), heights = c(0.7, 0.3))
    barplot(stacks,col=rainbow(length(types)), main=title, beside=besid)
    plot.new(); 
    plot.window(c(0,1), c(0,1));

    legend(0,1.5, types, fill=rainbow(length(types)), xpd=NA)

    dev.off()
}

errorsplot(antequera, "antequera_timeline.png", "Antequera - Hourly distribution")
errorsplot(sevilla, "sevilla_timeline.png", "Sevilla - Hourly distribution")
errorsplot(segovia, "segovia_timeline.png", "Segovia - Hourly distribution")
errorsplot(camas, "camas_timeline.png", "Camas - Hourly distribution")

errorsplot(antequera, "antequera_timeline_b.png", "Antequera - Hourly distribution", besid=T)
errorsplot(sevilla, "sevilla_timeline_b.png", "Sevilla - Hourly distribution", besid=T)
errorsplot(segovia, "segovia_timeline_b.png", "Segovia - Hourly distribution", besid=T)
errorsplot(camas, "camas_timeline_b.png", "Camas - Hourly distribution",besid=T)

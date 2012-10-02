source('loader.r')

png("segovia_graph.png", width=1800, height=600, res=150)
par(mfrow=c(1,3))
pie(tabla<-table(segovia$EVENT_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Segovia - Event type")
pie(tabla<-table(segovia$INVOKE_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Segovia - Invoke type")
pie(tabla<-table(segovia$DVNI_ERRORCATEGORY),labels=names(tabla), col=rainbow(length(names(tabla))), main="Segovia - Error category")
#pie3D(tabla<-table(segovia$INVOKE_TYPE),labels=names(tabla), explode=0.1, main="Segovia - Invoke Type")
dev.off()

png("antequera_graph.png", width=1800, height=600, res=150)
par(mfrow=c(1,3))
pie(tabla<-table(antequera$EVENT_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Antequera - Event type")
pie(tabla<-table(antequera$INVOKE_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Antequera - Invoke type")
pie(tabla<-table(antequera$DVNI_ERRORCATEGORY),labels=names(tabla), col=rainbow(length(names(tabla))), main="Antequera - Error category")
#pie3D(tabla<-table(segovia$INVOKE_TYPE),labels=names(tabla), explode=0.1, main="Segovia - Invoke Type")
dev.off()

png("camas_graph.png", width=1800, height=600, res=150)
par(mfrow=c(1,3))
pie(tabla<-table(camas$EVENT_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Camas - Event type")
pie(tabla<-table(camas$INVOKE_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Camas - Invoke type")
pie(tabla<-table(camas$DVNI_ERRORCATEGORY),labels=names(tabla), col=rainbow(length(names(tabla))), main="Camas - Error category")
#pie3D(tabla<-table(segovia$INVOKE_TYPE),labels=names(tabla), explode=0.1, main="Segovia - Invoke Type")
dev.off()

png("sevilla_graph.png", width=1800, height=600, res=150)
par(mfrow=c(1,3))
pie(tabla<-table(sevilla$EVENT_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Sevilla - Event type")
pie(tabla<-table(sevilla$INVOKE_TYPE),labels=names(tabla), col=rainbow(length(names(tabla))), main="Sevilla - Invoke type")
pie(tabla<-table(sevilla$DVNI_ERRORCATEGORY),labels=names(tabla), col=rainbow(length(names(tabla))), main="Sevilla - Error category")
#pie3D(tabla<-table(segovia$INVOKE_TYPE),labels=names(tabla), explode=0.1, main="Segovia - Invoke Type")
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

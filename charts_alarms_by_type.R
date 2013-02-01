#png("segovia_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/segovia_graph.png", res=150, height=1000, width=700)
par(mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(segovia$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="", las=3)
dev.off()

#png("antequera_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/antequera_graph.png", res=150, height=1000, width=700)
par(mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(antequera$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="", las=3)
dev.off()

#png("sevilla_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/sevilla_graph.png", res=150, height=1000, width=700)
par(mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(sevilla$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="", las=3)
dev.off()

png("graphs/albacete_graph.png", res=150, height=1000, width=700)
par(mar=c(16,2,2,2))
barplot(tabla<-prop.table(table(albacete$EVENT_TYPE)), col=rainbow(length(names(tabla))), main="", las=3)
dev.off()


## VALORES ABSOLUTOS Y NO PORCENTAJES!!
#png("segovia_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/segovia_graph.png", res=150, height=1400, width=700)
segovia <- segovia[segovia$EVENT_TYPE != "",]
segovia$EVENT_TYPE <- factor(segovia$EVENT_TYPE)
par(mar=c(16,2,7,2))
bp <- barplot(tabla<-table(segovia$EVENT_TYPE), col=rainbow(length(names(tabla))), main="", las=3)
text(x=bp,y=tabla+par("cxy")[2]/2,labels=tabla,cex=1.25,pos=4,xpd=TRUE,srt=90)
dev.off()

#png("antequera_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/antequera_graph.png", res=150, height=1400, width=700)
par(mar=c(16,2,7,2))
bp <- barplot(tabla<-table(antequera$EVENT_TYPE), col=rainbow(length(names(tabla))), main="", las=3)
text(x=bp,y=tabla+par("cxy")[2]/2,labels=tabla,cex=1.25,pos=4,xpd=TRUE,srt=90)
dev.off()

#png("sevilla_graph.png", width=1500, height=700, res=200)
#par(mfrow=c(1,3), mar=c(16,2,2,2))
png("graphs/sevilla_graph.png", res=150, height=1400, width=700)
par(mar=c(16,2,7,2))
bp <- barplot(tabla<-table(sevilla$EVENT_TYPE), col=rainbow(length(names(tabla))), main="", las=3)
text(x=bp,y=tabla+par("cxy")[2]/2,labels=tabla,cex=1.25,pos=4,xpd=TRUE,srt=90)

dev.off()

png("graphs/albacete_graph.png", res=150, height=1400, width=700)
albacete <- albacete[albacete$EVENT_TYPE != "",]
albacete$EVENT_TYPE <- factor(albacete$EVENT_TYPE)
par(mar=c(16,2,7,2))
bp <- barplot(tabla<-table(albacete$EVENT_TYPE), col=rainbow(length(names(tabla))), main="", las=3)
text(x=bp,y=tabla+par("cxy")[2]/2,labels=tabla,cex=1.25,pos=4,xpd=TRUE,srt=90)
dev.off()





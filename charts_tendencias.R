source('extended_variables.R')

extended_o <- extend(target=antequera)



extended_2010 <- extended_o[extended_o$eventID <140,]
extended_2012 <- extend(antequera_2)
extended_2012 <- allindexes

extended_albacete <- extend(target=albacete)
extended_segovia <- extend(target=segovia)
extended_sevilla <- extend(target=sevilla)


path="graphs/tendencias/"
graph_installation_error(extended_albacete,"albacete",path)
#graph_installation_error(extended_2010,"antequera_2010",path)
graph_installation_error(extended_2012,"antequera_2012",path)
graph_installation_error(extended_segovia,"segovia",path)
graph_installation_error(extended_sevilla,"sevilla",path)


graph_installation_error <- function(extended,name,path="graphs/tendencias/"){
  cols=rainbow(length(levels(as.factor(extended$sequenceID))), v=.8)
  cpath <- paste(path,name,sep="")
  dir.create(cpath, showWarnings = FALSE)
  installations <- levels(as.factor(extended$sequenceID))
  for(j in 0:length(installations)) {
    if (j == 0) {
      extended_i <- extended
      type = "p"
    }else{
      extended_i <- extended[extended$sequenceID == installations[[j]], ]
      type = "l"
    }
    cpath <- paste(path,name,"/",j,sep="")
    dir.create(cpath, showWarnings = FALSE)
    jpath <- paste(cpath,"/",sep="")
    graphs = colnames(extended)
    for (i in 3:length(graphs)) {
      if(max(extended_i[,i]) == 0){
        next
      }
      filename = paste(jpath,name,"_",graphs[[i]],".png",sep="")
      png(filename, res=100, height=800, width=1000)
      par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
      with(extended_i,plot(eventID,extended_i[,i], type=type, col=cols[sequenceID], xlab="Day", ylab=graphs[[i]]))
      with(extended_i,legend('topright',inset=c(-0.1,0),legend=levels(sequenceID),col=cols,pch=1,cex=0.5, title='Installation'))
      dev.off()
    }
    
  }
}
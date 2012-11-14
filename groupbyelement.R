sp.byelement <- split(antequera, antequera$ADDITIONAL_INFOS)

antequera_msgd <- antequera
antequera_msgd$ID_LANGUAGE = 1
antequera_msgd <- merge(antequera_msgd, errortext, by=c("ID_LANGUAGE","ADDITIONAL_TEXT"))
antequera_msgd$ID_LANGUAGE <- NULL

antequera_byelement <- split(antequera_msgd, antequera_msgd$ADDITIONAL_INFOS)

bfile = "alarmlists/byelement/antequera.txt"
cat(file = bfile)
for (i in 1:length(antequera_byelement)){
  frame <- antequera_byelement[[i]]
  
  cat ("Elemento ", as.character(frame$ADDITIONAL_INFOS[[1]]), "\n\n", file = bfile, append=TRUE)
  frame$TEXT <- paste(frame$ERROR_TEXT,frame$INVOKE_TYPE,frame$EVENT_TYPE,sep=' --- ')
  levels <- levels(factor(frame$TEXT))
  cat (levels, "\n", sep="\n", file = bfile, append=TRUE) 
}

antequera_msgd$ELEMENT_TYPE <- antequera_msgd$ADDITIONAL_INFOS

write.csv(antequera_msgd,file="Datos/current/antequera_msgd.txt")

elementize <- function(target, bfile){
  target_msgd <- target
  target_msgd$ID_LANGUAGE = 1
  target_msgd <- merge(target_msgd, errortext, by=c("ID_LANGUAGE","ADDITIONAL_TEXT"))
  target_msgd$ID_LANGUAGE <- NULL
  
  target_byelement <- split(target_msgd, target_msgd$ADDITIONAL_INFOS)
  
  cat(file = bfile)
  for(i in 1:length(target_byelement)){
    frame <- target_byelement[[i]]
    
    cat("Elemento ", as.character(frame$ADDITIONAL_INFOS[[1]]), "\n\n", file = bfile, append=TRUE)
    frame$TEXT <- paste(frame$ERROR_TEXT,frame$INVOKE_TYPE,frame$EVENT_TYPE,sep=' --- ')
    levels <- levels(factor(frame$TEXT))
    cat (levels, "\n", sep="\n", file = bfile, append=TRUE)
  }
}

elementize(sevilla, "alarmlists/byelement/sevilla.txt")

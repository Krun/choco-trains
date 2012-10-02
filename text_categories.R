segovia.1 <- table(subset(segovia, segovia$DVNI_ERRORCATEGORY==1)$ADDITIONAL_TEXT)
segovia.2 <- table(subset(segovia, segovia$DVNI_ERRORCATEGORY==2)$ADDITIONAL_TEXT)
segovia.3 <- table(subset(segovia, segovia$DVNI_ERRORCATEGORY==3)$ADDITIONAL_TEXT)
segovia.4 <- table(subset(segovia, segovia$DVNI_ERRORCATEGORY==4)$ADDITIONAL_TEXT)
segovia.5 <- table(subset(segovia, segovia$DVNI_ERRORCATEGORY==5)$ADDITIONAL_TEXT)

camas.1 <- table(subset(camas, camas$DVNI_ERRORCATEGORY==1)$ADDITIONAL_TEXT)
camas.2 <- table(subset(camas, camas$DVNI_ERRORCATEGORY==2)$ADDITIONAL_TEXT)
camas.3 <- table(subset(camas, camas$DVNI_ERRORCATEGORY==3)$ADDITIONAL_TEXT)
camas.4 <- table(subset(camas, camas$DVNI_ERRORCATEGORY==4)$ADDITIONAL_TEXT)
camas.5 <- table(subset(camas, camas$DVNI_ERRORCATEGORY==5)$ADDITIONAL_TEXT)

sevilla.1 <- table(subset(sevilla, sevilla$DVNI_ERRORCATEGORY==1)$ADDITIONAL_TEXT)
sevilla.2 <- table(subset(sevilla, sevilla$DVNI_ERRORCATEGORY==2)$ADDITIONAL_TEXT)
sevilla.3 <- table(subset(sevilla, sevilla$DVNI_ERRORCATEGORY==3)$ADDITIONAL_TEXT)
sevilla.4 <- table(subset(sevilla, sevilla$DVNI_ERRORCATEGORY==4)$ADDITIONAL_TEXT)
sevilla.5 <- table(subset(sevilla, sevilla$DVNI_ERRORCATEGORY==5)$ADDITIONAL_TEXT)

antequera.1 <- table(subset(antequera, antequera$DVNI_ERRORCATEGORY == 1)$ADDITIONAL_TEXT)
antequera.2 <- table(subset(antequera, antequera$DVNI_ERRORCATEGORY == 2)$ADDITIONAL_TEXT)
antequera.3 <- table(subset(antequera, antequera$DVNI_ERRORCATEGORY == 3)$ADDITIONAL_TEXT)
antequera.4 <- table(subset(antequera, antequera$DVNI_ERRORCATEGORY == 4)$ADDITIONAL_TEXT)
antequera.5 <- table(subset(antequera, antequera$DVNI_ERRORCATEGORY == 5)$ADDITIONAL_TEXT)

cat(names(segovia.1))
cat(names(segovia.2))
cat(names(segovia.3))
cat(names(segovia.4))
cat(names(segovia.5))

cat(names(sevilla.1))
cat(names(sevilla.2))
cat(names(sevilla.3))
cat(names(sevilla.4))
cat(names(sevilla.5))

cat(names(camas.1))
cat(names(camas.2))
cat(names(camas.3))
cat(names(camas.4))
cat(names(camas.5))

cat(names(antequera.1))
cat(names(antequera.2))
cat(names(antequera.3))
cat(names(antequera.4))
cat(names(antequera.5))


translatenames <- function (tabla){
  names <- names(tabla)
  for (i in 1:length(names)) {
    #cat(names[i])
    cat(errortext[errortext$ADDITIONAL_TEXT == names[i], 4],"\n")
  }
}

options(max.cat=5.5E8)



sink("alarmlist_antequera.txt")

cat("################\n")
cat("Antequera\n")
cat("################\n")
cat("ERRORCATEGORY 1\n")
translatenames(antequera.1)
cat("ERRORCATEGORY 2\n")
translatenames(antequera.2)
cat("ERRORCATEGORY 3\n")
translatenames(antequera.3)
cat("ERRORCATEGORY 4\n")
translatenames(antequera.4)
cat("ERRORCATEGORY 5\n")
translatenames(antequera.5)

sink()
sink("alarmlist_sevilla.txt")

cat("################\n")
cat("Sevilla\n")
cat("################\n")
cat("ERRORCATEGORY 1\n")
translatenames(sevilla.1)
cat("ERRORCATEGORY 2\n")
translatenames(sevilla.2)
cat("ERRORCATEGORY 3\n")
translatenames(sevilla.3)
cat("ERRORCATEGORY 4\n")
translatenames(sevilla.4)
cat("ERRORCATEGORY 5\n")
translatenames(sevilla.5)

sink()
sink("alarmlist_segovia.txt")

cat("################\n")
cat("Segovia\n")
cat("################\n")
cat("ERRORCATEGORY 1\n")
translatenames(segovia.1)
cat("ERRORCATEGORY 2\n")
translatenames(segovia.2)
cat("ERRORCATEGORY 3\n")
translatenames(segovia.3)
cat("ERRORCATEGORY 4\n")
translatenames(segovia.4)
cat("ERRORCATEGORY 5\n")
translatenames(segovia.5)

sink()



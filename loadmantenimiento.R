tabla11_1 <- read.csv("Datos/GesMan_2011_1.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla11_2 <- read.csv("Datos/GesMan_2011_2.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla11_3 <- read.csv("Datos/GesMan_2011_3.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")

#medidas11 <- merge(tabla11_3,tabla11_2,by=c("Elemento","CentroCodigo","SubcentroCodigo","TecnicaCodigo","ProcedimientoCodigo","PeriodicidadCodigo","PeriodoCodigo","ProcedimientoNumero"))
medidas11 <- merge(tabla11_3,tabla11_2)
rm(tabla11_1,tabla11_2,tabla11_3)
write.table(medidas11, file="Datos/medidas11.csv",col.names=TRUE,sep=";")


tabla10_1 <- read.csv("Datos/GesMan_2010_1.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla10_2 <- read.csv("Datos/GesMan_2010_2.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla10_3 <- read.csv("Datos/GesMan_2010_3.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")

medidas10 <- merge(tabla10_3,tabla10_2)
rm(tabla10_1,tabla10_2,tabla10_3)
write.table(medidas10, file="Datos/medidas10.csv",col.names=TRUE,sep=";")

tabla09_1 <- read.csv("Datos/GesMan_2009_1.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla09_2 <- read.csv("Datos/GesMan_2009_2.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")
tabla09_3 <- read.csv("Datos/GesMan_2009_3.csv", header = TRUE, fileEncoding="ISO-8859-15", sep=";")

medidas09 <- merge(tabla09_3,tabla09_2)
rm(tabla09_1,tabla09_2,tabla09_3)
write.table(medidas09, file="Datos/medidas09.csv",col.names=TRUE,sep=";")

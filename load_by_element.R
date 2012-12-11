antequera_elements <- read.csv("~/prog/trainmining/Datos/current/antequera_elements.csv")
antequera_elements$Column <- NULL

antequera_alimentacion <- antequera_elements[antequera_elements$ELEMENT_TYPE=="alimentacion",]
antequera_alimentacion_ps <- antequera_elements[antequera_elements$ELEMENT_TYPE=="alimentacion_ps",]
antequera_electric_network <- antequera_elements[antequera_elements$ELEMENT_TYPE=="electric_network",]

antequera_alim <- rbind(antequera_alimentacion, antequera_alimentacion_ps, antequera_electric_network)

antequera_agujas <- antequera_elements[antequera_elements$ELEMENT_TYPE=="agujas",]

antequera_luces_s <- antequera_elements[antequera_elements$ELEMENT_TYPE=="luces_s",]
antequera_luces_r <- antequera_elements[antequera_elements$ELEMENT_TYPE=="luces_r",]
antequera_luces_e <- antequera_elements[antequera_elements$ELEMENT_TYPE=="luces_e",]
antequera_luces_num <- antequera_elements[antequera_elements$ELEMENT_TYPE=="luces_num",]
antequera_luces_m <- antequera_elements[antequera_elements$ELEMENT_TYPE=="luces_m",]
antequera_luces <- rbind(antequera_luces_e,antequera_luces_m,antequera_luces_num,antequera_luces_r,antequera_luces_s)
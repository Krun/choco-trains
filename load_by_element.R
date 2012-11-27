antequera_elements <- read.csv("~/prog/trainmining/Datos/current/antequera_elements.csv")

antequera_alimentacion <- antequera_elements[antequera_elements$ELEMENT_TYPE=="alimentacion",]
antequera_alimentacion_ps <- antequera_elements[antequera_elements$ELEMENT_TYPE=="alimentacion_ps",]
antequera_electric_network <- antequera_elements[antequera_elements$ELEMENT_TYPE=="electric_network",]
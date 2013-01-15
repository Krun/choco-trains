antequera_reltypes$DVNI_INSTALLATIONCODE <- NULL
antequera_reltypes$DVNS_ERRORTIME <- NULL
antequera_reltypes$DVNI_ERRORCATEGORY <- NULL
antequera_reltypes$ADDITIONAL_INFOS <- NULL

antequera_reltypes <- antequera_reltypes[!duplicated(antequera_reltypes),]

segovia_reltypes$DVNI_INSTALLATIONCODE <- NULL
segovia_reltypes$DVNS_ERRORTIME <- NULL
segovia_reltypes$DVNI_ERRORCATEGORY <- NULL
segovia_reltypes$ADDITIONAL_INFOS <- NULL

segovia_reltypes <- segovia_reltypes[!duplicated(segovia_reltypes),]

albacete_reltypes$DVNI_INSTALLATIONCODE <-NULL
albacete_reltypes$DVNS_ERRORTIME <-NULL
albacete_reltypes$DVNI_ERRORCATEGORY <-NULL
albacete_reltypes$ADDITIONAL_INFOS <-NULL

albacete_reltypes <- albacete_reltypes[!duplicated(albacete_reltypes),]

sevilla_reltypes$DVNI_INSTALLATIONCODE <-NULL
sevilla_reltypes$DVNS_ERRORTIME <-NULL
sevilla_reltypes$DVNI_ERRORCATEGORY <-NULL
sevilla_reltypes$ADDITIONAL_INFOS <-NULL

sevilla_reltypes <- sevilla_reltypes[!duplicated(sevilla_reltypes),]

write.csv(albacete, file="eventtypes/albacete.txt")
write.csv(sevilla, file="eventtypes/sevilla.txt")
write.csv(segovia, file="eventtypes/segovia.txt")
write.csv(antequera, file="eventtypes/antequera.txt")
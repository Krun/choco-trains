antequera$DVNI_INSTALLATIONCODE <- NULL
antequera$DVNS_ERRORTIME <- NULL
antequera$DVNI_ERRORCATEGORY <- NULL
antequera$ADDITIONAL_INFOS <- NULL

antequera <- antequera[!duplicated(antequera),]

segovia$DVNI_INSTALLATIONCODE <- NULL
segovia$DVNS_ERRORTIME <- NULL
segovia$DVNI_ERRORCATEGORY <- NULL
segovia$ADDITIONAL_INFOS <- NULL

segovia <- segovia[!duplicated(segovia),]

albacete$DVNI_INSTALLATIONCODE <-NULL
albacete$DVNS_ERRORTIME <-NULL
albacete$DVNI_ERRORCATEGORY <-NULL
albacete$ADDITIONAL_INFOS <-NULL

albacete <- albacete[!duplicated(albacete),]

sevilla$DVNI_INSTALLATIONCODE <-NULL
sevilla$DVNS_ERRORTIME <-NULL
sevilla$DVNI_ERRORCATEGORY <-NULL
sevilla$ADDITIONAL_INFOS <-NULL

sevilla <- sevilla[!duplicated(sevilla),]
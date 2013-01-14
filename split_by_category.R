segovia <- segovia[segovia$EVENT_TYPE != "",]
segovia$EVENT_TYPE <- factor(segovia$EVENT_TYPE)

segovia_commproblem <- segovia[segovia$EVENT_TYPE == "CommProblem",]
segovia_communicationsAlarm <- segovia[segovia$EVENT_TYPE == "communicationsAlarm",]
segovia_environmentAlarm <- segovia[segovia$EVENT_TYPE == "environmentAlarm",]
segovia_equipmentAlarm <- segovia[segovia$EVENT_TYPE == "equipmentAlarm",]
segovia_information <- segovia[segovia$EVENT_TYPE == "information",]
segovia_processingErrorAlarm <- segovia[segovia$EVENT_TYPE == "processingErrorAlarm",]

albacete <- albacete[albacete$EVENT_TYPE != "",]
albacete$EVENT_TYPE <- factor(albacete$EVENT_TYPE)

albacete_communicationsAlarm <- albacete[albacete$EVENT_TYPE == "communicationsAlarm",]
albacete_fieldElementAlarm <- albacete[albacete$EVENT_TYPE == "fieldElementAlarm",]
albacete_fieldElementFailure <- albacete[albacete$EVENT_TYPE == "fieldElementFailure",]
albacete_imCpuAndCommunications <- albacete[albacete$EVENT_TYPE == "imCpuAndCommunications",]
albacete_internalDiagnosis <- albacete[albacete$EVENT_TYPE == "internalDiagnosis",]
albacete_internalPloDiagnosis <- albacete[albacete$EVENT_TYPE == "internalPloDiagnosis",]
albacete_operationsDiagnosisCommunications <- albacete[albacete$EVENT_TYPE == "operationsDiagnosisCommunications",]
albacete_operatorInformation <- albacete[albacete$EVENT_TYPE == "operatorInformation",]
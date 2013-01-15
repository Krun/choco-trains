name="antequera_alimentacion"
path="/opt/adri/r-output/sequences/performance/mean/"

filename <- paste(path,name,"_meanperformance.txt",sep="")

rules1 <- read.csv(filename, header = TRUE)

name="antequera_general"
filename <- paste(path,name,"_meanperformance.txt",sep="")
rules2 <- read.csv(filename, header = TRUE)

rules_antequera1day <- rbind(rules1,rules2)

precision_graphs(rules_antequera1day,"Antequera (1 day)")

############################################################
##########################################################
##########################################################
##########################################################
##########################################################


name="albacete_communicationsAlarm_nextday"
filename <- paste(path,name,"_meanperformance.txt",sep="")
rules <- read.csv(filename, header = TRUE)

rules <- rulebind(path,"albacete_fieldElementAlarm_nextday",rules)
rules <- rulebind(path,"albacete_fieldElementFailure_nextday",rules)
rules <- rulebind(path,"albacete_fieldElementCombined_nextday",rules)
rules <- rulebind(path,"albacete_imCpuAndCommunications_nextday",rules)
rules <- rulebind(path,"albacete_internalDiagnosis_nextday",rules)
rules <- rulebind(path,"albacete_internalPloDiagnosis_nextday",rules)
rules <- rulebind(path,"albacete_operationsDiagnosisCommunications_nextday",rules)
rules <- rulebind(path,"albacete_operatorInformation_nextday",rules)
rules <- rulebind(path,"albacete_general_nextday",rules)
rules_albacete1day <- rules

precision_graphs(rules_albacete1day,"Albacete (1 day)")

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################

name="albacete_communicationsAlarm_twodays"
filename <- paste(path,name,"_meanperformance.txt",sep="")
rules_albacete2days <- read.csv(filename, header = TRUE)

precision_graphs(rules_albacete2days,"Albacete (2 days)")


##########################################################
##########################################################
##########################################################
##########################################################
##########################################################

name="albacete_communicationsAlarm_nextweek"
filename <- paste(path,name,"_meanperformance.txt",sep="")
rules <- read.csv(filename, header = TRUE)
rules <- rulebind(path,"albacete_fieldElementAlarm_nextweek",rules)
rules <- rulebind(path,"albacete_fieldElementFailure_nextweek",rules)
rules <- rulebind(path,"albacete_fieldElementCombined_nextweek",rules)
rules <- rulebind(path,"albacete_imCpuAndCommunications_nextweek",rules)
rules <- rulebind(path,"albacete_internalDiagnosis_nextweek",rules)
rules <- rulebind(path,"albacete_internalPloDiagnosis_nextweek",rules)
rules_albacete1week <- rulebind(path,"albacete_general_nextweek",rules)

precision_graphs(rules_albacete1week,"Albacete (7 days)")

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################

name = "sevilla_communicationsAlarm_nextday"
filename <- paste(path,name,"_meanperformance.txt",sep="")
rules <- read.csv(filename, header = TRUE)
rules <- rulebind(path,"sevilla_fieldElementAlarm_nextday", rules)
rules <- rulebind(path,"sevilla_fieldElementFailure_nextday", rules)
rules <- rulebind(path,"sevilla_imCpuAndCommunications_nextday", rules)
rules <- rulebind(path,"sevilla_internalDiagnosis_nextday", rules)
rules <- rulebind(path,"sevilla_internalPloDiagnosis_nextday", rules)
rules <- rulebind(path,"sevilla_operationsDiagnosisCommunications_nextday", rules)
rules <- rulebind(path,"sevilla_operatorInformation_nextday", rules)
rules <- rulebind(path,"sevilla_general_nextday", rules)

rules_sevilla1day <- rules
precision_graphs(rules_sevilla1day,"Sevilla (1 day)")

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################
rm(rules)
rules <- rulebind(path,"segovia_processingErrorAlarm_nextday", NULL)
rules <- rulebind(path,"segovia_information_nextday", rules)
rules <- rulebind(path,"segovia_equipmentAlarm_nextday", rules)
rules <- rulebind(path,"segovia_environmentAlarm_nextday", rules)
rules <- rulebind(path,"segovia_communicationsAlarm_nextday", rules)
rules <- rulebind(path,"segovia_commproblem_nextday", rules)
#rules <- rulebind(path,"segovia_general_nextday", rules)

rules_segovia1day <- rules
precision_graphs(rules_segovia1day,"Segovia (1 day)")

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################
rm(rules)
rules <- rulebind(path,"segovia_processingErrorAlarm_twodays", NULL)
rules <- rulebind(path,"segovia_information_twodays", rules)
#rules <- rulebind(path,"segovia_equipmentAlarm_twodays", rules)
rules <- rulebind(path,"segovia_environmentAlarm_twodays", rules)
rules <- rulebind(path,"segovia_communicationsAlarm_twodays", rules)
rules <- rulebind(path,"segovia_commproblem_twodays", rules)
#rules <- rulebind(path,"segovia_general_twodays", rules)

rules_segovia2days <- rules
precision_graphs(rules_segovia2days,"Segovia (2 days)")

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################
rm(rules)
rules <- rulebind(path,"segovia_processingErrorAlarm_nextweek", NULL)
rules <- rulebind(path,"segovia_information_nextweek", rules)
rules <- rulebind(path,"segovia_equipmentAlarm_nextweek", rules)
rules <- rulebind(path,"segovia_environmentAlarm_nextweek", rules)
rules <- rulebind(path,"segovia_communicationsAlarm_nextweek", rules)
rules <- rulebind(path,"segovia_commproblem_nextweek", rules)
rules <- rulebind(path,"segovia_general_nextweek", rules)

rules_segovia7days <- rules
precision_graphs(rules_segovia7days,"Segovia (7 days)")


rulebind <- function(path, name, prules) {
  if (!is.data.frame(prules)) {
    filename <- paste(path,name,"_meanperformance.txt",sep="")
    rules <- read.csv(filename, header = TRUE)
    return(rules)
  }
  filename <- paste(path,name,"_meanperformance.txt",sep="")
  rules1 <- read.csv(filename, header = TRUE)
  binded <- rbind(prules,rules1)
  return(binded)
}

precision_graphs <- function(rules_s,name,path="graphs/precision"){
  dir.create(path, showWarnings = FALSE)
  levels <- 5*1:20
  levels <- c(0,levels)
  counts <- sapply(levels, pcount, rules=rules_s)
  phist <- rules_s$precision
  phist <- phist * 100
  filename <- paste(path,"/",name,"_precision_hist.png",sep="")
  png(filename, res=100, height=800, width=1000)
    hist(phist, col="lightblue", xlab="Precision", ylab="Number of rules", main=paste("Precision histogram for",name))
  dev.off()
  filename <- paste(path,"/",name,"_precision_accum.png",sep="")
  png(filename, res=100, height=800, width=1000)
    barplot(counts, main=paste("Accumulative rule distribution for",name), horiz=FALSE, names.arg=levels, col="lightblue", xlab="Precision threshold", ylab="Number of rules")
  dev.off()

}

pcount <- function (p,rules_s) {
  prec <- p/100
  n <- nrow(rules_s[rules_s$precision>=prec,])
  return(n)
}
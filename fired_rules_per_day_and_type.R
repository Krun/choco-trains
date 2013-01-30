antequera_fired <- read.csv("fired_rules/antequera_timeline_out.txt", header= TRUE, sep=" ")
antequera_fired$accum <- antequera_fired$valid + antequera_fired$invalid

data <- antequera_fired[antequera_fired$alarm_type == "fieldElementFailure", ]
data <- antequera_fired[antequera_fired$time < 50,]
data <- data[with(data, order(time)), ]


days_types_plot <- function(data, name, title="Valid vs invalid predictions", path="graphs/fired_timelines", besid=FALSE) {
  dir.create(path, showWarnings = FALSE)
  filename <- paste(path,"/",name,"_pred_type_dist.png",sep="")
  types = levels(as.factor(data$alarm_type))
  numtyp = length(types)
  height = 1/numtyp
  png(filename, width=1000, height=300*numtyp, res=100)
  plot.new()
  #ord = 2*1:numtyp
  #ordd = ord - 1
  ord = (numtyp+1):(2*numtyp)
  ordd = 1:numtyp
  orders = cbind(ordd,ord)
  layout(orders, heights = rep(height,numtyp), widths=c(0.9,0.1))
  for(i in 1:numtyp) {
    stacks = NULL
    ns = data[data$alarm_type == types[i],]
    rownames(ns) <- ns$time
    day = factor(ns$time)
    stacks = rbind(stacks,ns$valid)
    stacks = rbind(stacks,ns$invalid)
    rownames(stacks) <- c("valid","invalid")
    colnames(stacks) <- ns$time
    barplot(stacks,col=c("lawngreen","tomato"), main=paste(name,title,types[i],sep=" - "), beside=besid)
    legend(60,15, c("right","wrong"), fill=c("lawngreen","tomato"), xpd=NA)
  }
  dev.off()
}

days_types_pred_fract <- function(data, name, title="Predicted vs not predicted events", path="graphs/fired_timelines", besid=FALSE) {
  dir.create(path, showWarnings = FALSE)
  filename <- paste(path,"/",name,"_pred_vs_notpred.png",sep="")
  types = levels(as.factor(data$alarm_type))
  numtyp = length(types)
  height = 1/numtyp
  png(filename, width=1000, height=300*numtyp, res=100)
  plot.new()
  #ord = 2*1:numtyp
  #ordd = ord - 1
  ord = (numtyp+1):(2*numtyp)
  ordd = 1:numtyp
  orders = cbind(ordd,ord)
  layout(orders, heights = rep(height,numtyp), widths=c(0.9,0.1))
  for(i in 1:numtyp) {
    stacks = NULL
    ns = data[data$alarm_type == types[i],]
    rownames(ns) <- ns$time
    day = factor(ns$time)
    ns$nonpred <- ns$real - ns$valid
    stacks = rbind(stacks,ns$valid)
    stacks = rbind(stacks,ns$nonpred)
    rownames(stacks) <- c("predicted","non predicted")
    colnames(stacks) <- ns$time
    barplot(stacks,col=c("lawngreen","orange"), main=paste(name,title,types[i],sep=" - "), beside=besid)
    legend(58,60, c("predicted","not predicted"), fill=c("lawngreen","tomato"), xpd=NA)
  }
  dev.off()
}

days_types_pred_fract(data,"Antequera")

pred_per_day_type <- function(data, name, title="Predicted alarms per type", path="graphs/fired_timelines", besid=FALSE) {
  dir.create(path, showWarnings = FALSE)
  filename <- paste(path,"/",name,"_firedalarmstimeline.png",sep="")
  types = levels(as.factor(data$alarm_type))
  numtyp = length(types)
  png(filename, width=1000, height=500, res=100)
  plot.new()
  layout(matrix(c(1,2)), heights=c(0.9,0.1))
  stacks = NULL
  alldays = data.frame(time = min(data$time):max(data$time))
  for(i in 1:numtyp) {
    ns = data[data$alarm_type == types[i],]
    ns <- merge(ns,alldays,by="time", all.y = TRUE)
    ns$alarm_type <- NULL
    ns[is.na(ns)] <- 0
    rownames(ns) <- ns$time
    stacks = rbind(stacks,ns$accum)
  }
  rownames(stacks) <- types
  colnames(stacks) <- alldays$time
  barplot(stacks,col=rainbow(numtyp), main=paste(name,title,sep=" - "), beside=besid)
  legend(0,-5, types, fill=rainbow(numtyp), xpd=NA)
  dev.off()
}

pred_per_day_type(data,"Antequera")
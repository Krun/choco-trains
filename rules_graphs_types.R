consequent_type_chart(rules_albacete1day, albacete_reltypes, "albacete1day", "Albacete (1 day)")
consequent_type_chart(rules_albacete1week, albacete_reltypes, "albacete1week", "Albacete (7 days)")
consequent_type_chart(rules_antequera1day, antequera_reltypes, "antequera1day", "Antequera (1 day)")
consequent_type_chart(rules_segovia1day, segovia_reltypes, "segovia1day", "Segovia (1 day)")
consequent_type_chart(rules_segovia2days, segovia_reltypes, "segovia2days", "Segovia (2 days)")
consequent_type_chart(rules_segovia7days, segovia_reltypes, "segovia7days", "Segovia (7 days)")

consequent_type_chart <- function(ruleset, translationdf, name, title="", path="graphs/consequent_types") {
  dir.create(path, showWarnings = FALSE)
  rules <- as.character(ruleset$rule)
  consequents <- sapply(rules, getconsequent)
  consequents <- data.frame(consequent = consequents)
  
  consequent_types <- merge(consequents,translationdf, by.x = "consequent", by.y ="ADDITIONAL_TEXT")
  numtypes <- table(consequent_types$EVENT_TYPE)
  proptypes <- prop.table(numtypes)
  filename <- paste(path,"/",name,"_conseqtypes.png",sep="")
  png(filename, res=150, height=1000, width=1000)
  par(mar=c(16,5,5,5))
  barplot(numtypes, col=rainbow(length(names(numtypes))), main=paste("Distribution by consequent type for",title), las=3)
  dev.off()  
}


getconsequent <- function(rule) {
  cons <- strsplit(rule,"\\{")
  cons <- cons[[1]]
  cons <- cons[[length(cons)]]
  cons <- strsplit(cons,"\\}")
  cons <- cons[[1]]
  cons <- cons[[1]]
  return(cons)
}
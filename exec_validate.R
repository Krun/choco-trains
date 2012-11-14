source('validation.R')

name = "antequera_alimentacion"
i = 1

s1 <- read.csv(paste("sequences/",name,"_",i,".txt", sep=""))
rules <- as.character(s1$sequence)
winmax = 1
winmin = 1
testset = load_baskets(filename=paste("baskets/",name,"_",i,"_test.txt",sep=""))

bfile = paste("sequences/",name,"_eval_",i,".txt",sep="")
cat(file=bfile)
for (i in 1:length(rules)){
  orgrule = rules[[i]]
  rule = processrule(orgrule)
  if (single_consequent(rule)){
    antecedent = rule[[1]]
    consequent = rule[[2]]
    prec <- precision(antecedent, consequent, testset, winmax, winmin)
    rec <- recall(antecedent, consequent, testset, winmax, winmin)
    if(is.nan(prec) | prec < 0.5 | is.nan(rec)) {
      next
    }
    cat(file=bfile, orgrule, prec, rec, "\n", append=TRUE)
  }
}
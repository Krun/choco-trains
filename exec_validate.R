source('validation.R')

testset = load_baskets(filename="baskets/test_1_test.txt")

orgrule = "<{A,B,C},{D}>"
rule = processrule(orgrule)

antecedent = rule[[1]]
consequent = rule[[2]]
prec <- precision(antecedent, consequent, testset, winmax, winmin)
rec <- recall(antecedent, consequent, testset, winmax, winmin)






s1 <- read.csv("sequences/antequera1.txt")
rules <- as.character(s1$sequence)
winmax = 1
winmin = 1
testset = load_baskets(filename="baskets/antequera_1_test.txt")

bfile = "sequences/antequera_eval_1.txt"
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














rule = "<{saml.status.channel_A_CS_unknown,saml.status.channel_B_CS_unknown},{saml.status.channel_B_down}>"
rule = processrule(rule)
antecedent = rule[[1]]
consequent = rule[[2]]
winmax = 80
winmin = 1
testset = load_baskets(filename="baskets/antequera_1_test.txt")
testset$time <- as.numeric(testset$time)
testset$installation <- as.numeric(testset$installation)
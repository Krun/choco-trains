source('validation.R')
source('cspade_wrapper.R')
source('create_baskets_k-fold.R')

name = "antequera_general"
target <- antequera
k=10
days=1
gap=1
params=list(support=0.3, mingap=gap, maxgap=gap, maxlen=2, maxsize=5)

create_k_basket_files(target,name,k,"baskets/",days)
cspade_k_fold(name,k,"baskets/","output/sequences/",params)
auto_k_validate(name, k, winmax=gap, winmin=gap, path="output/sequences/",minprec=0.1)
av <- k_average(name,k)
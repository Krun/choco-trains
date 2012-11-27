source('validation.R')

name = "antequera_alimentacion"

auto_k_validate(name,10)

auto_validate(name,6)

av <- k_average(name,10)
setwd("~/Desktop/KU/Github/WafflingAround")


library(readr) # to read in data
waffle <- read_delim("WaffleDivorce.csv", 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)
head(waffle)
## remove slavery columns :(
waffle <- waffle[,-c(11,13)]

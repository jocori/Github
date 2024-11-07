library(readr) # to read in data
library(here) # so all collaborators can easily get data

waffle <- read_delim(here("data", "WaffleDivorce.csv"), 
                     delim = ";", escape_double = FALSE, trim_ws = TRUE)
#hello
## remove slavery columns :(
waffle <- waffle[,-c(11,13)]
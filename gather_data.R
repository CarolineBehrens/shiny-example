# This is a script in which all my code for gathering data lives. I only run
# this interactively, when I want to up my data. This results from this might,
# for starters, be stored in the raw_dat directory.

# Any libraries needed should be loaded here.

library(tidyverse)
library(primer.data)


ex_data <- governors %>% 
  select(lived_after, sex, election_age)


write_rds(ex_data, file = "voting/clean_data/shiny_data.rds")

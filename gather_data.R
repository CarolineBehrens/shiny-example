# This is a script in which all my code for gathering data lives. I only run
# this interactively, when I want to up my data. This results from this might,
# for starters, be stored in the raw_data directory.

# Any libraries needed should be loaded here.

library(tidyverse)
library(primer.data)
library(rstanarm)


ex_data <- governors %>% 
  select(lived_after, sex, election_age)

fit_2 <- stan_glm(data = ex_data,
                  formula = lived_after ~ sex + election_age + sex*election_age,
                  refresh = 0,
                  seed = 12)

newobs <- tibble(sex = rep(c("Male", "Female"), 3), 
                 election_age = rep(c(30, 45, 60), 2),
                 names = paste(sex, election_age, sep = "_"))

pe <- posterior_epred(fit_2,
                      newdata = newobs) %>% 
  as_tibble() %>% 
  set_names(newobs$names)

# Note the new arguments to pivot_longer(). This trick is due to Nosa and his
# breakout room. We don't need separate(), although you can use it if you like.

x <- pe %>% 
  pivot_longer(names_to = c("Gender", "Age"),
               names_sep = "_",
               values_to = "Years",
               cols = everything()) 

write_rds(x, file = "voting/clean_data/shiny_data.rds")

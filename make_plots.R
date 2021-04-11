# This is for making plots. Note that each R script is separate for any others.
# Include all the libraries you need. Of course, I could just do everything in
# one R script. For small projects, that is fine. And it can simplify things
# since we don't need to write out and then read in data, as we do here. But
# one-big-file can also make you crazy.


library(tidyverse)
library(rstanarm)
library(ggdist)

# This path is a little suspect

x <- read_rds("voting/clean_data/shiny_data.rds")



plot_1 <- x %>% 
  ggplot(aes(x = Years, y = Age, fill = Gender)) +
  
  stat_slab(alpha = 0.5) +
  labs(title = "Candidate Longevity versus Gender and Age at Election",
       subtitle = "Age at election does not matter to longevity for female candidates . . . ?", 
       x = "Expected Years To Live Post Election",
       y = "Age at Election",
       caption = "Source: Barfort, Klemmensen & Larsen (2019)")

# Now that I have a plot object, I need to save the object in the App directory
# so that it is available in the cloud.

ggsave(filename = "voting/plot_1.png", 
       plot = plot_1, 
       dpi = 300)

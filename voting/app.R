#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/


# You need to load any necessary libraries yourself. If something works locally
# but not when you put it on the web, the most likely cause is a failure to load
# necessary libraries here.

# Restart your R session often! Doing so will catch these sorts of errors and
# give you a sensible error message.

library(shiny)
library(tidyverse)
library(ggdist)


ui <- fluidPage(

    titlePanel("Candidate Longevity"),

        mainPanel(
           plotOutput("distPlot")
        )
)


server <- function(input, output) {
    
    # Key issue is that the path is relative to the app directory, not the
    # project directory.
    
    x <- read_rds("clean_data/shiny_data.rds")

    output$distPlot <- renderPlot({
        x %>% 
            ggplot(aes(x = Years, y = Age, fill = Gender)) +
            
            stat_slab(alpha = 0.5) +
            labs(title = "Candidate Longevity versus Gender and Age at Election",
                 subtitle = "Age at election does not matter to longevity for female candidates . . . ?", 
                 x = "Expected Years To Live Post Election",
                 y = "Age at Election",
                 caption = "Source: Barfort, Klemmensen & Larsen (2019)") +
            theme_classic(base_size = 15)
    })
    

}


shinyApp(ui = ui, server = server)

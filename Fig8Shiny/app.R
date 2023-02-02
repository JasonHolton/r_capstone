# Fig 8: Shiny App showing the median % of respondents who eat fruit once/day or less, filtered by age group

library(shiny)
library(shinyWidgets)
library(ggplot2)
library(ggthemes)


ui <- fluidPage(
  
  titlePanel("CDC Behavioral Risk Factor Surveillance System"),
  
  sidebarLayout(
    sidebarPanel(
      sliderTextInput(inputId="age_input",
                      label="Age Group",
                      choices=sort(unique(fig8$Stratification1))),
    ),
    mainPanel(
      plotOutput("fig8")
    )
  )
)

server <- function(input, output) {
  
  output$fig8<-renderPlot({
    
    fig8_age <- fig8[fig8$Stratification1 == input$age_input, ]
    
    ggplot(fig8_age, aes(x=LocationDesc, y=median)) + 
      geom_bar(stat = "identity", width = 0.5, color="blue", fill=rgb(0.1,0.4,0.5,0.7)) +
      coord_flip() +
      geom_rangeframe() +
      theme_calc() +
      labs(x="State/Territory", y="Median % of Responders", title="Median % Of Responders Who Eat Fruit Less than Once Per Day ")
    
  })
}

shinyApp(ui = ui, server = server)

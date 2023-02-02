# Fig 3: Shiny App showing the median % of respondents who eat vegetables once/day or less, filtered by income

library(shiny)
library(shinyWidgets)


ui <- fluidPage(

    titlePanel("CDC Behavioral Risk Factor Surveillance System"),

    sidebarLayout(
        sidebarPanel(
          sliderTextInput(inputId="income_input",
                      label="Income Level",
                      choices=sort(unique(fig3$Income))),
        ),
        mainPanel(
           plotOutput("fig3")
        )
    )
)

server <- function(input, output) {

  output$fig3<-renderPlot({
    
    fig3_income <- fig3[fig3$Income == input$income_input, ]
    
    ggplot(fig3_income) + 
      geom_sf(aes(fill = median)) +
      scale_fill_viridis_c(option = "plasma") +
      labs(title = "Median % of Respondents by Income Level who Eat Vegetables Once or Less Daily, 2011-2021") +
      labs(fill = "Median %") +
      theme(
        plot.title = element_textbox(hjust = 0.25,
                                     width = unit(0.75, "npc"),
                                     margin = margin(b = 15)),
        plot.title.position = "plot"
      )
  })
}

shinyApp(ui = ui, server = server)

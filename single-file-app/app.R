# load packages ----
library(shiny)
library(DT)
library(palmerpenguins)
library(tidyverse)

# ui ----
ui <- fluidPage(

  # app title ----
  tags$h1("My app title"),

  # app subtitle ----
  tags$p(tags$strong("Exploring Antarctic Penguin Data")),

  # body mass sliderInput ----
  sliderInput(inputId = "body_mass_input", label = "Select a range of body masses (g): ",
              min = 2700, max = 6300, value = c(3000, 4000)),

  # body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterPlot"),

  # yearly checkbox ----
  checkboxGroupInput(inputId = "yearly_input", label = "Select year(s):",
                     choices = unique(penguins$year),
                     selected = c("2007", "2008")),

  # yearly table output ----
  DT::dataTableOutput(outputId = "yearly_table")


) # END fluidPage

# server ----
server <- function(input, output) {


# plot ----

    # filter data ----
    body_mass_df <- reactive({
      penguins |>
        filter(body_mass_g %in% input$body_mass_input[1]:input$body_mass_input[2])
    }) # END filter of filtering for the input of body mass

    # render plot
    output$bodyMass_scatterPlot <- renderPlot({

      ggplot(na.omit(body_mass_df()),
             aes(x = flipper_length_mm, y = bill_length_mm,
                 color = species, shape = species)) +
        geom_point() +
        scale_color_manual(values = c("Adelie" = "#FEA346",
                                      "Chinstrap" = "#B251F1",
                                      "Gentoo" = "4BA4A4")) +
        scale_shape_manual(values = c("Adelie" = 19,
                                      "Chinstrap" = 17,
                                      "Gentoo" = 15))

    }) # END render scatter plot

# table
  # filter data ----
  yearly_table_df <- reactive({

    penguins |>
      filter(year %in% c(input$yearly_input))

  }) # END filter of penguins for years

  # render dataframe ----
  output$yearly_table <- DT::renderDataTable({

    DT::datatable(yearly_table_df())

    }) # END output data frame

} # END server

# combine ui & server ----
shinyApp(ui = ui, server = server)

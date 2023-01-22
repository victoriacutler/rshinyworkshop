server <- function(input, output) {


  # trout dataframe filtering and making it reactive ----
  trout_filtered_df <- reactive({

    validate(
      need(length(input$channel_type_input) > 0, "Select at least one channel type."),
      need(length(input$section_input) > 0, "Select at least one forest section.")
    )

    clean_trout |>
      filter(channel_type %in% c(input$channel_type_input)) |>
      filter(section %in% c(input$section_input))

  })

  # trout plotting based off of the dataframe filtering
  output$trout_scatterplot <- renderPlot({

    # plot trout ----
    ggplot(trout_filtered_df(), aes(x = length_mm, y = weight_g,
                            color = channel_type)) +
      geom_point(alpha = 0.7, size = 5) +
      scale_color_manual(values = c("R" = "blue", "C" = "purple", "S" = "black", "P" = "yellow", "SC" = "pink", "I" = "orange", "IP" = "red"))

  }, alt = "some alt text will live here to explain the graphic"
  ) # END of trout renderplot


} # END of ui

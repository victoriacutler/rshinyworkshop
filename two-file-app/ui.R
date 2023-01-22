ui <- navbarPage(

  title = "LTER Animal Data Explorer",

  # page 1: intro tabPanel ----
  tabPanel(title = "About this App",

           "background info here"

  ), # END page 1 (background) tabPanel

  # page 2: data tabPanel ----
  tabPanel(title = "Explore the Data",

           tabsetPanel(

             # trout tab ----
             tabPanel(title = "Trout",

                      # trout sidebarLayout ----
                      sidebarLayout(

                        # trout sidebar panel ----
                        sidebarPanel(

                          # channel type pickerInput ----
                         shinyWidgets::pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      options = pickerOptions(actionsBox = TRUE),
                                      selected = c("C", "S"),
                                      multiple = TRUE
                                      ), # END trout pickerInput

                          # checkboxGroupButtonInput ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = unique(clean_trout$section),
                                               selected = c("clear cut forest"),
                                               individual = FALSE,
                                               justified = TRUE,
                                               checkIcon = list(yes = icon("ok", lib = "glyphicon"),
                                                                no = icon("remove", lib = "glyphicon"))) # END trout section group buttons

                        ), # END trout sidebarPanel


                        # trout mainPanel ----
                        mainPanel(

                          plotOutput(outputId = "trout_scatterplot") |> withSpinner(type = 1, color = "green")

                        ) # END trout mainPanel

                      ) # END trout sidebarLayout

             ), # END trout tabset tabPanel

             # penguin tab ----
             tabPanel(title = "Penguins",

                      # penguin sidebarLayout ----
                      sidebarLayout(

                        sidebarPanel(

                          "penguin inputs"

                        ), # END penguin sidebar

                        mainPanel(

                          "penguin outputs"

                        ) # END penguin mainbar

                      ) # END penguin sidebarLayout

             ) # END penguin tabset tabPanel

           ) # END tabsetPanel

  ) # END page 2 (data) tabPanel

) # END ui

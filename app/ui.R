# Define UI for application that plots random distributions
shinyUI(fluidPage(

  # Set layout
  sidebarLayout(

    # Sidebar content
    sidebarPanel(
      h3("Earthquakes!"),
      br(),
      rHandsontableOutput("spreadsheet")
    ),

    # Show a map with the data
    mainPanel(
      leafletOutput("map", width = "100%", height = "800px")
    )
  )
))

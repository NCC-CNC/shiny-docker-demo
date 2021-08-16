# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {

  # Print information for example logging
  message("")
  message(cli::rule())
  message("Starting new instance")
  message(Sys.time())
  message(cli::rule())
  message("")

  # Import earthquake data
  ## note that we import the data inside the server.R file so that
  ## the data will be re-loaded when opening a new session,
  ## this means that we can edit the quakes.csv file and it will be
  ## re-uploaded when we refresh the browser
  quake_data <-
    read.table(
      "/data/quakes.csv", header = TRUE, stringsAsFactors = FALSE, sep = ","
    ) %>%
    mutate(show = TRUE)

  # Create reactive value
  quake_val <- reactiveVal(quake_data)

  # Initialize spreadsheet
  output$spreadsheet <- renderRHandsontable({
    quake_data %>%
    rhandsontable(readOnly = TRUE) %>%
    hot_col("show", readOnly = FALSE)
  })

  # Specify reactive binding for spreadsheet
  observeEvent(input$spreadsheet, {
    quake_val(hot_to_r(input$spreadsheet))
  })

  # Create color palette for map
  pal <- colorNumeric(palette = "viridis", domain = quake_data$mag)

  # Initialize map
  output$map <- renderLeaflet({
    ## create initial leaflet object
    leaflet(quake_data) %>%
    ## add basemap
    addProviderTiles(
      providers$Stamen.TonerLite,
      options = providerTileOptions(noWrap = TRUE)
    ) %>%
    ## add markers
    addCircleMarkers(
      data = quake_data,
      popup = popupTable(quake_data, row.numbers = FALSE),
      color = ~pal(mag)
    ) %>%
    ## add legend
    addLegend(
      "topright",
      pal = pal,
      values = quake_data$mag,
      title = "Magnitude",
      opacity = 1
    )
  })

  # Set reactive binding for map
  observeEvent(quake_val(), {
    ## prepare data for mapping
    ## i.e. extract points selected to show
    d <- {quake_val()}
    d <- d[d$show > 0.5, , drop = FALSE]
    ## update map
    leafletProxy("map") %>%
      clearMarkers() %>%
      addCircleMarkers(
        data = d,
        popup = popupTable(d, row.numbers = FALSE),
        color = ~pal(mag)
      )
  })

})

#!/bin/bash

# launch application and save log files
/usr/local/bin/Rscript -e \
  "options(shiny.port=3838,shiny.host='0.0.0.0');shiny::runApp()" \
  2>&1 | tee /logs/log.txt

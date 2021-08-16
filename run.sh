#!/bin/bash

ls -la /logs

# launch application and save log files
/usr/local/bin/Rscript -e \
  "options(shiny.port=3838,shiny.host='0.0.0.0');shiny::runApp()" \
  > /logs/log.txt 2>&1

# base image
FROM rocker/shiny:4.1.0 AS base

## remove example apps
RUN rm -rf /srv/shiny-server/*

## install system libraries
RUN apt-get update && apt-get install -y \
  software-properties-common

## install R package dependencies
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
    apt-get update && apt-get install -y \
      libcurl4-gnutls-dev \
      libssl-dev \
      libudunits2-dev \
      libudunits2-dev \
      libgdal-dev \
      libgeos-dev \
      libproj-dev \
    && rm -rf /var/lib/apt/lists/*

## install R packages
RUN install2.r --error \
    shiny \
    sf \
    rhandsontable \
    leaflet \
    dplyr \
    leafpop \
    cli

# set up data directory
## create directory
RUN mkdir /data
## set read-only permissions (i.e. r--r--r--)
RUN chmod -R 444 /data

# set up log file directory
## create directory
RUN mkdir /logs
# set read/write-only permissions (i.e. -rw-rw-rw-)
RUN chmod -R 666 /logs

# set user
USER shiny

# install app
RUN mkdir /home/shiny/app
COPY app/global.R /home/shiny/app/global.R
COPY app/server.R /home/shiny/app/server.R
COPY app/ui.R /home/shiny/app/ui.R

# expose port
EXPOSE 3838

# set working directory
WORKDIR /home/shiny/app

# run app
CMD ["/usr/local/bin/Rscript", "-e", "options(shiny.port=3838,shiny.host= '0.0.0.0');shiny::runApp('.')", ">&", "/logs/log.txt"]

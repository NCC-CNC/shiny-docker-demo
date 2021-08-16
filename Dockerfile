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

# install app
RUN mkdir /home/shiny/app
COPY --chown=shiny:shiny app/global.R /home/shiny/app/global.R
COPY --chown=shiny:shiny app/server.R /home/shiny/app/server.R
COPY --chown=shiny:shiny app/ui.R /home/shiny/app/ui.R
COPY --chown=shiny:shiny run.sh /home/shiny/app/run.sh

# set executable permissions
RUN chmod +x /home/shiny/app/run.sh

# expose port
EXPOSE 3838

# set working directory
WORKDIR /home/shiny/app

# run app
CMD "/home/shiny/app/run.sh"

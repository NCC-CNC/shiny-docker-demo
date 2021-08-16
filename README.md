# Demo for running a Shiny web application via Docker

[![lifecycle](https://img.shields.io/badge/Lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![Docker Status](https://img.shields.io/docker/cloud/build/naturecons/shiny-docker-demo?label=Docker%20build)](https://hub.docker.com/r/naturecons/shiny-docker-demo)

This repository contains an demo for running a [Shiny Web application](https://shiny.rstudio.com/) via [Docker](https://www.docker.com/). It shows how Docker can be used to manage (i) installation of system dependencies, (ii) installation of R packages, (iii) access to external data files, and (iv) application log files. Although this repository provides a simple example showcasing Shiny and Docker integration, it lacks many features critical for real-world software development (e.g. documentation, R package version control, unit testing, automatic scaling). **Therefore, it is strongly recommended that readers explore the [golem framework](https://thinkr-open.github.io/golem/) for developing Shiny web applications and the [ShinyProxy](https://www.shinyproxy.io/) for deploying them with Docker.**

## Usage

To run the demo, please install the [Docker Engine](https://www.docker.com/) ([see here for instructions](https://docs.docker.com/get-docker/)). After completing this step, you can install the application from the [DockerHub repository](https://hub.docker.com/repository/docker/naturecons/shiny-docker-demo). Specifically, please use the following system command:

```{bash, eval = FALSE}
docker run \
  --detach \
  --tty \
  --interactive \
  --publish 3838:3838 \
  --volume "$(pwd)"/data:/data \
  --volume "$(pwd)"/logs:/logs \
  --name shiny-docker-demo \
  naturecons/shiny-docker-demo:latest
```

You can then view the application by opening the following link in your web browser: http://localhost:3838. After you have finished using the application, you can terminate it using the following system command. **Note that if you don't terminate the application once you are finished using it, then it will continue running in the background.**

```{bash, eval = FALSE}
docker rm -f  shiny-docker-demo
```

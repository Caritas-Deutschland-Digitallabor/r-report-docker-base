FROM rocker/tidyverse:latest

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libsodium-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpoppler-cpp-dev \
    libxml2-dev \
    libpq-dev \
    libgfortran5 \
    libblas-dev \
    liblapack-dev \
    libpng-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libtiff5-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN R -e "options(repos = c(RSPM = 'https://packagemanager.posit.co/cran/latest')); \
  pkgs <- c('shiny', 'renv', 'htmltools', 'DBI', 'openssl', \
           'base64enc', 'ggrepel', 'patchwork', 'nleqslv', 'ggforce', \
           'scales', 'pdftools', 'gridExtra', 'RColorBrewer', 'RPostgres', \
           'openxlsx', 'openxlsx2', 'aws.s3', 'tidytext', 'ggwordcloud', \
           'svglite', 'shinycssloaders', 'config', 'stopwords', 'tm',
					 'SnowballC'); \
  to_install <- setdiff(pkgs, rownames(installed.packages())); \
  try(install.packages(to_install, type = 'binary'), silent = TRUE); \
  still_missing <- setdiff(pkgs, rownames(installed.packages())); \
  if (length(still_missing)) install.packages(still_missing, type = 'source'); \
  missing <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]; \
  if (length(missing)) stop('Fehlende Pakete: ', paste(missing, collapse = ', '))"

# Windows Schriften installieren
RUN apt-get update && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends ttf-mscorefonts-installer && \
    fc-cache -f -v && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

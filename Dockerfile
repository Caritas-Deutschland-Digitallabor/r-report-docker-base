FROM r-base

# Systemabhängige Bibliotheken installieren
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    make \
    libsodium-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpoppler-cpp-dev \
    libxml2 \
    libxml2-dev \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# R-Pakete installieren in einem einzigen Schritt
RUN R -e "options(install.packages.compile.from.source = 'default'); \
  pkgs <- c( \
    'shiny', 'renv', 'dplyr', 'htmltools', 'DBI', 'purrr', 'rmarkdown', 'stringr', 'openssl', \
    'testthat', 'ggplot2', 'base64enc', 'ggrepel', 'xml2', 'readr', 'forcats', 'lubridate', \
    'tidyr', 'jsonlite', 'httr', 'httr2', 'patchwork', 'nleqslv', 'ggforce', 'broom', 'scales', \
    'pdftools', 'gridExtra', 'RColorBrewer', 'RPostgres', 'dbplyr', 'openxlsx', 'openxlsx2', \
    'aws.s3', 'tidytext', 'ggwordcloud', 'svglite', 'shinycssloaders', 'config'); \
  install.packages(pkgs, dependencies = TRUE); \
  missing <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]; \
  if (length(missing) > 0) { stop('Fehlende Pakete: ', paste(missing, collapse = ', ')) }"



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
    libpq-dev \
    libgfortran5 \
    libblas-dev \
    liblapack-dev && \
    rm -rf /var/lib/apt/lists/*

# R-Pakete installieren in einem einzigen Schritt
RUN R -e "options(repos = c(RSPM = 'https://packagemanager.posit.co/cran/latest'), \
                 install.packages.compile.from.source = 'never'); \
  pkgs <- c('shiny', 'renv', 'htmltools', 'DBI', 'openssl', \
           'base64enc', 'ggrepel', 'patchwork', 'nleqslv', 'ggforce', \
           'scales', 'pdftools', 'gridExtra', 'RColorBrewer', 'RPostgres', \
           'openxlsx', 'openxlsx2', 'aws.s3', 'tidytext', 'ggwordcloud', \
           'svglite', 'shinycssloaders', 'config'); \
  to_install <- setdiff(pkgs, rownames(installed.packages())); \
  if (length(to_install)) install.packages(to_install); \
  missing <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]; \
  if (length(missing)) stop('Fehlende Pakete: ', paste(missing, collapse = ', '))"


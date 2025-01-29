FROM r-base

# Systemabhängige Bibliotheken installieren
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    make \
    libsodium-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpoppler-cpp-dev

# R-Pakete installieren
RUN R -e "options(install.packages.compile.from.source = 'always'); install.packages(c( \
    'renv', 'dplyr', 'htmltools', 'DBI', 'purrr', 'rmarkdown', 'stringr', 'openssl', \
    'testthat', 'ggplot2', 'base64enc', 'ggrepel', 'xml2', 'readr', 'forcats', 'lubridate', \
    'tidyr', 'jsonlite', 'httr', 'patchwork', 'nleqslv', 'ggforce', 'broom', 'scales', 'pdftools'))"

FROM rocker/tidyverse
COPY . /usr/local/src/scripts
WORKDIR /usr/local/src/scripts
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    make \
    libsodium-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpoppler-cpp-dev 
RUN Rscript  /usr/local/src/scripts/dockerScripts/install_libraries.r
CMD ["Rscript", "autostart.R"]
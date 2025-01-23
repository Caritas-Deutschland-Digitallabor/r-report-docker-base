FROM rocker/tidyverse
COPY . /usr/local/src/scripts
WORKDIR /usr/local/src/scripts
RUN Rscript script.R
CMD ["Rscript", "main.R"]
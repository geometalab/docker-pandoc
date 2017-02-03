FROM debian:latest
MAINTAINER geometalab@hsr.ch

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  -o Acquire::Retries=10 --no-install-recommends \
    texlive-full \
    fontconfig \
    libxrender1 \
    lmodern \
    git \
    wget \
    tar \
    xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O pandoc.deb https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb
RUN dpkg --install pandoc.deb

WORKDIR /wkhtmltopdf
RUN wget -O wkhtmltox-0.12.3_linux-generic-amd64.tar.xz http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz

ENV PATH ${PATH}:/wkhtmltopdf/wkhtmltox/bin

WORKDIR /pandoc

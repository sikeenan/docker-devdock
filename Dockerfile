FROM ubuntu:18.04

USER  root

ENV BUILD_MAINTAINER="simon.keenan@computacenter.com"
ENV BUILD_COMPANY="Computacenter UK LTD"
ENV BUILD_DEVELOPER="sikeenan@icloud.com"
ENV BUILD_ERSION="201911"
ENV BUILD_NAME="devdock"
ENV BUILD_ROI="NOTSET"

ENV   PYTHONIOENCODING=utf-8:surrogateescape

ENV   LANG C.UTF-8
ENV   LC_ALL C.UTF-8

RUN	apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y \
            apt-utils \
            curl \
            freetds-bin \
            libssl1.0.0 \
            gnupg2 \
            git \
            mysql-client \
            python-pip \
            python3 \
            python3-pip \
            sudo \
            unixodbc \
            unixodbc-dev \
            vim \
            wget && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN   pip3 install \
            configparser \
            pymysql \
            requests \
            urllib3

RUN useradd -rm -d /development -s /bin/bash -g root -G sudo -u 1001 -p "$(openssl passwd -1 mydefpass1)" developer

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN  chmod 755 /docker-entrypoint.sh

USER developer

WORKDIR /development

EXPOSE 5000
EXPOSE 4440
EXPOSE 80
EXPOSE 8080 
EXPOSE 443

ENTRYPOINT /docker-entrypoint.sh

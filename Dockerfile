FROM sikeenan/ccbasepyth:202001

USER  root

ENV BUILD_MAINTAINER="simonjkeenan@gmail.com"
ENV BUILD_DEVELOPER="simonjkeenan@gmail.com"
ENV BUILD_VERSION="202001"
ENV BUILD_NAME="devdock"
ENV BUILD_LOC="Docker Local"
ENV BUILD_GITURL="https://github.com/sikeenan/docker-devdock.git"

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

EXPOSE 5000 4440 8080 9000

ENTRYPOINT /docker-entrypoint.sh

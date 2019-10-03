# DOCKER
# DEVBOX
#
FROM ubuntu:18.04

USER  root

ENV   MYSQL_HOSTNAME 172.17.0.1
ENV   MYSQL_PORT 3306
ENV   MYSQL_USERNAME archangel
ENV   MYSQL_PASSWORD mydefpass1
ENV   MYSQL_ROOT_PASSWORD mydefpass1
ENV   MYSQL_DBNAME archangel

ENV   MSSQL_HOSTNAME 172.17.0.1
ENV   MSSQL_PORT 1433
ENV   MSSQL_USERNAME SA
ENV   MSSQL_PASSWORD mydefpass1
ENV   MSSQL_DBNAME ITSM_Request_Orchestration
ENV   MSSQL_DRIVER pyodbc
ENV   MSSQL_SEARCH None

ENV   RUNDECK_HOSTNAME 172.17.0.1
ENV   RUNDECK_PORT 4440
ENV   RUNDECK_CONNECTION http
ENV   RUNDECK_TOKEN notoken

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

RUN   curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \   
      curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
      apt-get update && \
            ACCEPT_EULA=Y apt-get install msodbcsql17 && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN   pip3 install \
            configparser \
            pymssql \
            pymysql \
            pyodbc \
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

FROM ghcr.io/linuxserver/baseimage-alpine:arm64v8-edge

VOLUME /tmp
WORKDIR /app

COPY root/ /

ENV LC_ALL=en_US.UTF-8
ENV KOMF_CONFIG_DIR="/config"

RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-17-openjdk/jre/bin:/usr/lib/jvm/java-17-openjdk/bin

RUN set -x && apk add --no-cache openjdk17 && [ "$JAVA_HOME" = "$(docker-java-home)" ]

EXPOSE 8085

# debug only
COPY config/ /config 

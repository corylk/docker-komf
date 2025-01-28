FROM openjdk:17-alpine

VOLUME /tmp
WORKDIR /app

COPY build/libs/komf-1.3.0.jar ./
COPY root/ /

ENV LC_ALL=en_US.UTF-8
ENV KOMF_CONFIG_DIR="/config"

EXPOSE 8085

ENTRYPOINT ["java","-jar", "komf-1.3.0.jar"]

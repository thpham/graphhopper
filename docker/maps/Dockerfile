FROM openjdk:8-jdk as builder
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
		maven \
		osmium-tool \
	&& rm -rf /var/lib/apt/lists/*
RUN mkdir -p /data
RUN mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

ARG MAP_FILES=europe_germany_berlin.pbf
ENV MAP_FILES=${MAP_FILES}
COPY ./docker/maps/download-merge-maps.sh ./docker/maps/config.properties ./
RUN ./download-merge-maps.sh ${MAP_FILES}

ARG JAVA_OPTS="-Xmx4g -Xms4g -server"
ENV JAVA_OPTS=${JAVA_OPTS}
RUN ./graphhopper.sh import /data/osmconvert.pbf

FROM alpine:latest as image

COPY --from=builder /data /data

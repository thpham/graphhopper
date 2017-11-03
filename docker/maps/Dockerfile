FROM openjdk:8-jdk-alpine as builder
RUN apk --update --no-cache add bash wget maven

RUN mkdir -p /data
RUN mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

ARG MAP_FILE=europe_germany_berlin.pbf
ENV MAP_FILE=${MAP_FILE}
COPY ./docker/maps/config.properties ./
RUN ./graphhopper.sh import /data/${MAP_FILE}

FROM alpine:latest as image

COPY --from=builder /data /data

FROM openjdk:8-jdk-alpine as builder
RUN apk --update --no-cache add bash wget maven

RUN mkdir -p /data
RUN mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

RUN ./graphhopper.sh buildweb

ARG MAP_FILE=europe_germany_berlin.pbf
ENV MAP_FILE=${MAP_FILE}
COPY ./docker/config.properties ./
RUN ./graphhopper.sh import /data/${MAP_FILE}

FROM openjdk:8-jre-alpine as image
RUN apk --update --no-cache add unzip tini

WORKDIR /graphhopper

COPY --from=builder /graphhopper/web/target/graphhopper-web-*-bin.zip ./graphhopper-web.zip
RUN unzip graphhopper-web.zip && rm graphhopper-web.zip
COPY --from=builder /data /data

COPY ./docker/entrypoint.sh ./docker/config.properties ./

ENTRYPOINT ["/sbin/tini", "--", "/graphhopper/entrypoint.sh"]

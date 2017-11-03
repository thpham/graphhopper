FROM openjdk:8-jdk-alpine as builder
RUN apk --update --no-cache add bash wget maven

RUN mkdir -p /data
RUN mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

RUN ./graphhopper.sh buildweb

FROM openjdk:8-jre-alpine as image
RUN apk --update --no-cache add unzip tini

WORKDIR /graphhopper

COPY --from=builder /graphhopper/web/target/graphhopper-web-*-bin.zip ./graphhopper-web.zip
RUN unzip graphhopper-web.zip && rm graphhopper-web.zip

COPY ./docker/entrypoint.sh ./

ENTRYPOINT ["/sbin/tini", "--", "/graphhopper/entrypoint.sh"]

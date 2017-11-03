#!/bin/sh

if [ -z "$OSM_FILE" ]; then
  OSM_FILE=`ls /data/*.pbf`
fi

if [ -z "${JAVA_OPTS}" ]; then
    JAVA_OPTS="$JAVA_EXTRA_OPTS -Djava.net.preferIPv4Stack=true"
    JAVA_OPTS="$JAVA_OPTS -server -Djava.awt.headless=true -Xconcurrentio"
    echo "Setting default JAVA_OPTS"
fi

RUN_ARGS=" -jar *.jar jetty.port=${JETTY_PORT:-8989} jetty.host=0.0.0.0 jetty.resourcebase=webapp config=config.properties datareader.file=$OSM_FILE"

echo "JAVA_OPTS= ${JAVA_OPTS}"
echo "RUN_ARGS= ${RUN_ARGS}"

exec java $JAVA_OPTS $RUN_ARGS
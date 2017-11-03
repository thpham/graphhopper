#!/bin/bash

MAP_FILES=$1

MAPS=""
list=$(echo $MAP_FILES | tr "|" "\n")
for MAP_NAME in $list
do
  LINK=$(echo $MAP_NAME | tr '_' '/')      
  if [ ${MAP_NAME: -4} == ".pbf" ]; then
    LINK="http://download.geofabrik.de/${LINK%.*}-latest.osm.pbf"
    wget -S -nv -O "/tmp/$MAP_NAME" "$LINK"
    MAPS="$MAPS /tmp/$MAP_NAME"
  fi
done

echo "Merging all maps: $MAPS"

osmium merge $MAPS -o /data/osmconvert.pbf

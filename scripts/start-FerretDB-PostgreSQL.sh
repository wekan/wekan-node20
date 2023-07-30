#!/bin/bash

## mongodb://username:password@127.0.0.1/ferretdb?authMechanism=PLAIN

#export FERRETDB_TELEMETRY=disable
# OR:
#./ferretdb --telemetry=disable

sudo mkdir /data

sudo docker run -d --rm --name ferretdb -p 27017:27017 \
  -v /data:/data/ -e FERRETDB_HANDLER=sqlite \
  -e FERRETDB_TELEMETRY=disable \
  -e FERRETDB_SQLITE_URL=file:/data/ \
  ghcr.io/ferretdb/all-in-one

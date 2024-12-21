#!/bin/bash

## mongodb://username:password@127.0.0.1/ferretdb?authMechanism=PLAIN

#export FERRETDB_TELEMETRY=disable
# OR
#./ferretdb --telemetry=disable

sudo docker run -d --rm --name fepo -p 27010:27017 \
-e FERRETDB_TELEMETRY=disable \
ghcr.io/ferretdb/all-in-one

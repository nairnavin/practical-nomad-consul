#!/bin/bash

docker run -d -p 9999:9999 -p 9998:9998 -v $PWD/external-services/fabio.properties:/etc/fabio/fabio.properties fabiolb/fabio

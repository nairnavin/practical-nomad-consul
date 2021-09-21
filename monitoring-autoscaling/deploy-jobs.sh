#!/bin/bash
set -ex
# docker-compose up -d
# curl --request PUT --data @external-services/postgres.json 172.16.1.101:8500/v1/catalog/register
nomad job run jobs/prometheus.nomad
nomad job run jobs/autoscaler.nomad
nomad job run jobs/petclinicapi-egw.nomad
nomad job run jobs/petclinicapi-api.nomad
nomad job run jobs/petclinicapi-web.nomad
nomad job run jobs/petclinicapi-ingw.nomad
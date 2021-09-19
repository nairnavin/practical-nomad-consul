#!/bin/bash
set -ex
# docker-compose up -d
# curl --request PUT --data @external-services/postgres.json 172.16.1.101:8500/v1/catalog/register
nomad job run jobs/monitoring-autoscaling/prometheus.nomad
nomad job run jobs/monitoring-autoscaling/autoscaler.nomad
nomad job run jobs/monitoring-autoscaling/egw.nomad
nomad job run jobs/monitoring-autoscaling/api.nomad
nomad job run jobs/monitoring-autoscaling/web.nomad
nomad job run jobs/monitoring-autoscaling/ingw.nomad
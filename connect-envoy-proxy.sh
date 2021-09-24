#!/bin/bash
ENVOY_PROXIES_LIST=envoy_proxies.txt
consul-template -template "template/nomad-redis-service.tpl:${ENVOY_PROXIES_LIST}" -once
CLUSTER_ADDR=$(cat envoy_proxies.txt | head -n 1 |tr -d " \t\n\r" | cut -d ':' -f 1)
CLUSTER_PORT=$(cat envoy_proxies.txt | head -n 1 |tr -d " \t\n\r" | cut -d ':' -f 2)
echo $CLUSTER_ADDR $CLUSTER_PORT
nomad job run -var="cluster_addr=$CLUSTER_ADDR" -var="cluster_port=$CLUSTER_PORT" jobs/cli-jobs/envoy-service.nomad

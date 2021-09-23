#!/bin/bash
curl --location --request PUT '172.16.1.101:8500/v1/catalog/register' \
--header 'Content-Type: application/json' \
--data-raw '{
  "Node": "rabbitmq-node-1",
  "Address": "172.16.1.101",
  "NodeMeta": {
    "external-node": "true",
    "external-probe": "true"
  },
  "Service": {
    "ID": "rabbitmq-svc-1",
    "Service": "rabbitmq-svc",
    "Port": 5672
  }
}'

curl --location --request PUT '172.16.1.101:8500/v1/catalog/register' \
--header 'Content-Type: application/json' \
--data-raw '{
  "Node": "rabbitmq-node-2",
  "Address": "172.16.1.102",
  "NodeMeta": {
    "external-node": "true",
    "external-probe": "true"
  },
  "Service": {
    "ID": "rabbitmq-svc-2",
    "Service": "rabbitmq-svc",
    "Port": 5672
  }
}'

curl --location --request PUT '172.16.1.101:8500/v1/catalog/register' \
--header 'Content-Type: application/json' \
--data-raw '{
  "Node": "rabbitmq-node-3",
  "Address": "172.16.1.103",
  "NodeMeta": {
    "external-node": "true",
    "external-probe": "true"
  },
  "Service": {
    "ID": "rabbitmq-svc-3",
    "Service": "rabbitmq-svc",
    "Port": 5672
  }
}'
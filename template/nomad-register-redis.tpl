#!/bin/bash

{{- range $index,  $service := service "redis" }} 
curl --location --request PUT '172.16.1.101:8500/v1/catalog/register' \
--header 'Content-Type: application/json' \
--data-raw '{
  "Node": "redis-{{$index}}",
  "Address": "{{.Address}}",
  "NodeMeta": {
    "external-node": "true",
    "external-probe": "true"
  },
  "Service": {
    "ID": "redis-svc-{{$index}}",
    "Service": "redis-svc",
    "Port": {{.Port}}
  }
}'
{{end}}


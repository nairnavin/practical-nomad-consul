#!/bin/bash
redis-cli --cluster create {{- range service "redis" }} {{.Address}}:{{.Port}} {{end}} --cluster-replicas 1
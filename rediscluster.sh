#!/bin/bash
consul-template -template "template/start-redis-cluster.sh.tpl:start-redis-cluster.sh" -once
chmod +x ./start-redis-cluster.sh
./start-redis-cluster.sh

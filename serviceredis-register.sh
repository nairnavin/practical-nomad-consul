#!/bin/bash
consul-template -template "template/nomad-register-redis.tpl:external-services/service-register-redis.sh" -once
chmod +x external-services/service-register-redis.sh


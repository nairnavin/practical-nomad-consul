#!/bin/bash

cd $HOME

# Form Consul Cluster
ps -C consul
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall consul
fi
sudo cp /vagrant/consul-config/consul-client-dc1.hcl /etc/consul.d/consul-client-dc1.hcl
sudo nohup consul agent --config-file /etc/consul.d/consul-client-dc1.hcl &>$HOME/consul.log &

# Form Nomad Cluster
ps -C nomad
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall nomad
fi
sudo mkdir -p /var/lib/rabbitmq/data
sudo cp /vagrant/nomad-config/nomad-client-dc1.hcl /etc/nomad.d/nomad-client-dc1.hcl
sudo nohup nomad agent -config /etc/nomad.d/nomad-client-dc1.hcl &>$HOME/nomad.log &

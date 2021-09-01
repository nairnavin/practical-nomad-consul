curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v0.9.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v0.9.0.tgz
sudo mkdir -p /opt/cni/bin
sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz

# To allow container traffic
echo 1 > /proc/sys/net/bridge/bridge-nf-call-arptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

cat > 50-bridge-sysctl.conf <<EOT
net.bridge.bridge-nf-call-arptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOT

# To preserve the settings
sudo cp -p 50-bridge-sysctl.conf /etc/sysctl.d
rm -f cni-plugins.tgz 50-bridge-sysctl.conf

#!/bin/bash

mkdir package
cd package

latest_cni_release=$(curl -s "https://api.github.com/repos/containernetworking/plugins/releases/latest" | jq -r ".tag_name")
latest_containerd_release=$(curl -s "https://api.github.com/repos/containerd/containerd/releases/latest" | jq -r ".tag_name")
latest_runc_release=$(curl -s "https://api.github.com/repos/opencontainers/runc/releases/latest" | jq -r ".tag_name")

# containerd_tag=${latest_containerd_release/v/}
containerd_tag=${latest_containerd_release#v~}

# download
curl -LO "https://github.com/containerd/containerd/releases/download/${latest_containerd_release}/containerd-${containerd_tag}-linux-amd64.tar.gz"
echo "containerd-${containerd_tag}-linux-amd64.tar.gz"
tar -tf "containerd-${containerd_tag}-linux-amd64.tar.gz"


curl -LO "https://github.com/containernetworking/plugins/releases/download/${latest_cni_release}/cni-plugins-linux-amd64-${latest_cni_release}.tgz"
echo "cni-plugins-linux-amd64-${latest_cni_release}.tgz"
tar -tf "cni-plugins-linux-amd64-${latest_cni_release}.tgz"


mkdir -p usr/local/sbin
curl -Lo usr/local/sbin/runc "https://github.com/opencontainers/runc/releases/download/${latest_runc_release}/runc.amd64"
chmod +x usr/local/sbin/runc
ls -lR

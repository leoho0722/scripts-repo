#!/bin/bash

cd ~

# ===== Install zip unzip from apt =====

sudo apt-get update
sudo apt-get install -y zip

# ===== Download Kubeflow v1.6.1 from GitHub =====
# https://github.com/kubeflow/manifests/releases/tag/v1.6.1

echo "Downloading Kubeflow manifests v1.6.1 from GitHub..."
wget -O manifests-1.6.1.zip https://github.com/kubeflow/manifests/archive/refs/tags/v1.6.1.zip
echo "Finished downloading Kubeflow manifests v1.6.1 from GitHub..."

# ===== Unzip manifests-1.6.1.zip =====

unzip manifests-1.6.1.zip -d .

# ===== Download Kustomize v3.2.0 from GitHub =====
# https://github.com/kubernetes-sigs/kustomize/releases/tag/v3.2.0

cd ./manifests-1.6.1

echo "Downloading Kustomize v3.2.0 from GitHub..."
wget -O kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v3.2.0/kustomize_3.2.0_linux_amd64
echo "Finished downloading Kustomize v3.2.0 from GitHub..."
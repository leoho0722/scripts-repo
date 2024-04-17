#!/bin/bash

# 1. Install Istio
./kustomize build common/istio-1-14/istio-crds/base | kubectl apply -f -
./kustomize build common/istio-1-14/istio-namespace/base | kubectl apply -f -
./kustomize build common/istio-1-14/istio-install/base | kubectl apply -f -

# 2. Install Knative Serving
./kustomize build common/knative/knative-serving/overlays/gateways | kubectl apply -f -
./kustomize build common/istio-1-14/cluster-local-gateway/base | kubectl apply -f -

# 3. Install Cert Manager
./kustomize build common/cert-manager/cert-manager/base | kubectl apply -f -
./kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -

# 4. Install KServe
kubectl apply -f https://github.com/kserve/kserve/releases/download/v0.8.0/kserve.yaml

# 5. Install KServe Built-in ClusterServingRuntimes
kubectl apply -f https://github.com/kserve/kserve/releases/download/v0.8.0/kserve-runtimes.yaml

# 6. Install Other
# Dex
./kustomize build common/dex/overlays/istio | kubectl apply -f -

# OIDC AuthService
./kustomize build common/oidc-authservice/base | kubectl apply -f -
kubectl apply -f kubeflow-pv.yaml -l name=authservice

# Kubeflow Namespace
./kustomize build common/kubeflow-namespace/base | kubectl apply -f -

# Kubeflow Roles
./kustomize build common/kubeflow-roles/base | kubectl apply -f -

# Kubeflow Istio Resources
./kustomize build common/istio-1-14/kubeflow-istio-resources/base | kubectl apply -f -

# Kubeflow Pipelines
./kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | kubectl apply -f -
kubectl apply -f kubeflow-pv.yaml -l name=kubeflow

# katib
./kustomize build apps/katib/upstream/installs/katib-with-kubeflow | kubectl apply -f -
kubectl apply -f kubeflow-pv.yaml -l name=katib-mysql

# Central Dashboard
./kustomize build apps/centraldashboard/upstream/overlays/kserve | kubectl apply -f -

# Admission Webhook
./kustomize build apps/admission-webhook/upstream/overlays/cert-manager | kubectl apply -f -

# Notebooks
./kustomize build apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl apply -f -

# Profiles + KFAM
./kustomize build apps/profiles/upstream/overlays/kubeflow | kubectl apply -f -

# Volumes Web App
./kustomize build apps/volumes-web-app/upstream/overlays/istio | kubectl apply -f -

# Tensorboard
./kustomize build apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl apply -f -

# * Training Operator
./kustomize build apps/training-operator/upstream/overlays/kubeflow | kubectl apply -f -

# User Namespace
./kustomize build common/user-namespace/base | kubectl apply -f -
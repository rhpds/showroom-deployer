#!/bin/bash
#
echo "Pulling..."
podman pull docker.io/library/nginx:1.25 --platform=linux/amd64
podman pull docker.io/wettyoss/wetty:latest --platform=linux/amd64
podman pull docker.io/codercom/code-server:latest --platform=linux/amd64

echo "Pushing..."

podman push docker.io/library/nginx:1.25 quay.io/rhpds/nginx:1.25
podman push docker.io/wettyoss/wetty:latest quay.io/rhpds/wetty:latest
podman push docker.io/codercom/code-server:latest quay.io/rhpds/code-server:latest

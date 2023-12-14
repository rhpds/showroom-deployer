# Use Red Hat UBI9 as the base image
# No AuthN necessary to this docker registry
FROM --platform=linux/amd64 registry.access.redhat.com/ubi9/nodejs-20:latest

USER root

# Install necessary tools
RUN dnf -y update && dnf -y upgrade && \
    dnf -y --quiet install \
    git \
    nodejs \
    wget && \
    dnf clean all && \
    rm -rf /var/cache/yum /root/.cache

RUN wget -q https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    -O /usr/bin/yq && chmod +x /usr/bin/yq

RUN npm install -g gulp @antora/cli @antora/site-generator

# Create a user named 'antora'
RUN useradd -ms /bin/bash antora && \
    mkdir -p /antora && \
    chown -R antora:antora /antora

# Copy the entrypoint script into the container
COPY ./entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable and change ownership
RUN chmod +x /entrypoint.sh && \
    chown antora:antora /entrypoint.sh

# Switch to the 'antora' user
USER antora

EXPOSE 80

# Set the entrypoint script as the command to run when the container starts
ENTRYPOINT ["/entrypoint.sh"]

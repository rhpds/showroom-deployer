IMAGE_NAME 						= showroom-builder


REGISTRY 							= docker.io/tonykay
CONTAINER_RUNTIME 		= podman
ARCH 									= x86_64

CONTAINER_HOSTNAME 		= antora
# RHEL_VERSION 					= 8.5
# SSH_PORT 							= 2222
# SHELL_COMMAND 				= sudo su - devops

# Used instead of docker run.... bash 

: ## TIP! make supports tab completion with *modern* shells e.g. zsh etc
: ##  

help: ## Show this help - technically unnecessary as `make` alone will do 
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build-x86 : ## Do a docker based build
build-x86 : ##    EXTRA_ARGS='--squash --no-cache' for example
	docker build \
	-f Containerfile \
    --platform linux/amd64 \
    --tag $(REGISTRY)/$(IMAGE_NAME):$${VERSION:-latest} \
    --load \
    $(EXTRA_ARGS) .

build-multi : ## Do a docker based build
build-multi : ##    EXTRA_ARGS='--squash --no-cache' for example
	docker buildx build \
    --platform linux/arm64/v8,linux/amd64 \
    --tag $(REGISTRY)/$(IMAGE_NAME):$${VERSION:-latest} \
    $(EXTRA_ARGS) .


    # --push \

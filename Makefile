registry ?= "ghcr.io/nikaro"
tag ?= $(shell git rev-parse --short HEAD)

.PHONY: all clean test login build push

all: build

clean:
	docker system prune --all --filter="label=org.opencontainers.image.url=https://github.com/nikaro/containers" --force

test:
	pre-commit run --all-files

login:
	docker login ${registry} -u nologin --password-stdin <<< "${SCW_SECRET_KEY}"

build:
	docker build --tag ${registry}/wolfi-devcontainer:${tag} --tag ${registry}/wolfi-devcontainer:latest --file ./wolfi-devcontainer.Dockerfile .
	# docker build --tag ${registry}/debian-devcontainer:${tag} --tag ${registry}/debian-devcontainer:latest --file ./debian-devcontainer.Dockerfile .
	# docker build --tag ${registry}/alpine-devcontainer:${tag} --tag ${registry}/alpine-devcontainer:latest --file ./alpine-devcontainer.Dockerfile .
	# docker build --tag ${registry}/wait-for-it:${tag} --tag ${registry}/wait-for-it:latest --file ./wait-for-it.Dockerfile .
	# docker build --tag ${registry}/pulumi-executor:${tag} --tag ${registry}/pulumi-executor:latest --file ./pulumi-executor.Dockerfile .

push:
	docker push --all-tags ${image}

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

%.Dockerfile:
	docker build \
		--tag ${registry}/$(patsubst %.Dockerfile,%,$@):${tag} \
		--tag ${registry}/$(patsubst %.Dockerfile,%,$@):latest \
		--file ./$(patsubst %.Dockerfile,%,$@).Dockerfile \
		.

build: $(wildcard *.Dockerfile)

push:
	docker push --all-tags ${image}

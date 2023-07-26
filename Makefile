registry ?= "rg.fr-par.scw.cloud/devc"
tag ?= $(shell git rev-parse --short HEAD)

all: build

lint:
	pre-commit run --all-files

login:
	docker login ${registry} -u nologin --password-stdin <<< "${SCW_SECRET_KEY}"

build:
	docker build --tag ${registry}/alpine:${tag} --tag ${registry}/alpine:latest --file ./alpine-devcontainer.Dockerfile .

push:
	docker push --all-tags ${image}

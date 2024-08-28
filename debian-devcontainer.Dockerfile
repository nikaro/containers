FROM debian:12.6-slim

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="debian-devcontainer"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  apt-get update && \
  apt-get upgrade --yes && \
  apt-get install --yes --no-install-recommends locales && \
  locale-gen && \
  apt-get install --yes --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    fd-find \
    fish \
    git \
    jq \
    less \
    openssh-client \
    python3-minimal \
    ripgrep \
    sudo \
    unzip \
    vim \
    && \
  rm -rf /var/lib/apt/lists/* && \
  && \
  :

RUN \
  addgroup --gid 1000 vscode && \
  adduser --uid 1000 --gid 1000 --shell /usr/bin/fish --disabled-password vscode && \
  echo "vscode ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vscode && \
  :


ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US

USER vscode
WORKDIR /workspace

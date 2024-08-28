FROM alpine:edge

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="alpine-devcontainer"

RUN \
  apk add --no-cache \
    build-base \
    curl \
    fd \
    fish \
    git \
    jq \
    openssh-client \
    python3 \
    ripgrep \
    sudo \
    unzip \
    vim \
  && \
  :

RUN \
  addgroup -g 1000 vscode && \
  adduser -u 1000 -G vscode -s /usr/bin/fish -D vscode && \
  echo "vscode ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vscode && \
  :

USER vscode
WORKDIR /workspace

# hadolint ignore=DL3007
FROM cgr.dev/chainguard/wolfi-base:latest

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="wolfi-devcontainer"

# renovate: datasource=pypi depName=pre-commit
ENV PRE_COMMIT_VERSION="3.6.1"

# hadolint ignore=DL3018
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
    sudo-rs \
    vim \
  && \
  mkdir -p /usr/local/bin && \
  curl -L \
    "https://github.com/pre-commit/pre-commit/releases/download/v${PRE_COMMIT_VERSION}/pre-commit-${PRE_COMMIT_VERSION}.pyz" \
    -o /usr/local/bin/pre-commit \
    && \
  chmod 0755 /usr/local/bin/pre-commit \
  && \
  :

RUN \
  addgroup -g 1000 vscode && \
  adduser -u 1000 -G vscode -D vscode && \
  echo "vscode ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  :

USER vscode
WORKDIR /workspace

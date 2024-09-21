FROM debian:testing

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.source="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="gha"

ENV DEBIAN_FRONTEND=noninteractive
ENV NONINTERACTIVE=true
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar
ENV HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH

# Install Homebrew
ADD --chown=1001:1001 https://github.com/Homebrew/brew.git /home/linuxbrew/.linuxbrew
RUN \
  apt-get install --update --yes --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  file \
  git \
  procps \
  && \
  groupadd --gid 1001 nonroot && \
  useradd --uid 1001 --gid 1001 --create-home nonroot && \
  chown -R 1001:1001 /home/linuxbrew/.linuxbrew/ && \
  :

USER nonroot

# Install formulae
RUN brew install --verbose \
  actionlint \
  check-jsonschema \
  fd \
  gh \
  go-task \
  hadolint \
  jq \
  prettier \
  shellcheck \
  shfmt \
  yamlfmt \
  yamllint \
  && \
  :

WORKDIR /workspace

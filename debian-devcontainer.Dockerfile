FROM debian:12.4-slim

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="debian-devcontainer"

# renovate: datasource=repology depName=build-essential packageName=debian_12/build-essential-mipsen versioning=loose
ENV BUILD_ESSENTIALS_VERSION="12.9"
# renovate: datasource=repology depName=ca-certificates packageName=debian_12/ca-certificates versioning=loose
ENV CA_CERTIFICATES_VERSION="20230311"
# renovate: datasource=repology depName=curl packageName=debian_12/curl versioning=loose
ENV CURL_VERSION="7.88.1-10+deb12u5"
# renovate: datasource=repology depName=fd packageName=debian_12/fd-find versioning=loose
ENV FD_VERSION="8.6.0-3"
# renovate: datasource=repology depName=fish packageName=debian_12/fish versioning=loose
ENV FISH_VERSION="3.6.0-3.1"
# renovate: datasource=repology depName=git packageName=debian_12/git versioning=loose
ENV GIT_VERSION="1:2.39.2-1.1"
# renovate: datasource=repology depName=jq packageName=debian_12/jq versioning=loose
ENV JQ_VERSION="1.6-2.1"
# renovate: datasource=repology depName=openssh packageName=debian_12/openssh versioning=loose
ENV OPENSSH_VERSION="1:9.2p1-2+deb12u2"
# renovate: datasource=pypi depName=pre-commit
ENV PRE_COMMIT_VERSION="3.6.0"
# renovate: datasource=repology depName=python3 packageName=debian_12/python3 versioning=loose
ENV PYTHON_VERSION="3.11.2-1+b1"
# renovate: datasource=repology depName=ripgrep packageName=debian_12/ripgrep versioning=loose
ENV RIPGREP_VERSION="13.0.0-4+b2"
# renovate: datasource=repology depName=sudo packageName=debian_12/sudo versioning=loose
ENV SUDO_VERSION="1.9.13p3-1+deb12u1"
# renovate: datasource=repology depName=vim packageName=debian_12/vim versioning=loose
ENV VIM_VERSION="2:9.0.1378-2"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  apt-get update && \
  apt-get upgrade --yes && \
  apt-get install --yes --no-install-recommends \
    "build-essential=${BUILD_ESSENTIALS_VERSION}" \
    "ca-certificates=${CA_CERTIFICATES_VERSION}" \
    "curl=${CURL_VERSION}" \
    "fd-find=${FD_VERSION}" \
    "fish=${FISH_VERSION}" \
    "git=${GIT_VERSION}" \
    "jq=${JQ_VERSION}" \
    "openssh-client=${OPENSSH_VERSION}" \
    "python3-minimal=${PYTHON_VERSION}" \
    "ripgrep=${RIPGREP_VERSION}" \
    "sudo=${SUDO_VERSION}" \
    "vim=${VIM_VERSION}" \
    && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L \
    "https://github.com/pre-commit/pre-commit/releases/download/v${PRE_COMMIT_VERSION}/pre-commit-${PRE_COMMIT_VERSION}.pyz" \
    -o /usr/local/bin/pre-commit \
    && \
  chmod 0755 /usr/local/bin/pre-commit \
  && \
  :

RUN \
  addgroup --gid 1000 vscode && \
  adduser --uid 1000 --gid 1000 --shell /usr/bin/fish --disabled-password vscode && \
  echo "vscode ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vscode && \
  :

USER vscode
WORKDIR /workspace

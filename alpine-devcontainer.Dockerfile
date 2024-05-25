FROM alpine:3.20.0

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="alpine-devcontainer"

# renovate: datasource=repology depName=alpine_3_20/build-base versioning=loose
ENV BUILD_BASE_VERSION="0.5-r3"
# renovate: datasource=repology depName=alpine_3_20/curl versioning=loose
ENV CURL_VERSION="8.5.0-r0"
# renovate: datasource=repology depName=alpine_3_20/fd versioning=loose
ENV FD_VERSION="8.7.1-r0"
# renovate: datasource=repology depName=alpine_3_20/fish versioning=loose
ENV FISH_VERSION="3.6.3-r0"
# renovate: datasource=repology depName=alpine_3_20/git versioning=loose
ENV GIT_VERSION="2.43.4-r0"
# renovate: datasource=repology depName=alpine_3_20/jq versioning=loose
ENV JQ_VERSION="1.7.1-r0"
# renovate: datasource=repology depName=openssh packageName=debian_12/openssh versioning=loose
ENV OPENSSH_VERSION="9.6_p1-r0"
# renovate: datasource=pypi depName=pre-commit
ENV PRE_COMMIT_VERSION="3.7.1"
# renovate: datasource=repology depName=alpine_3_20/python3 versioning=loose
ENV PYTHON_VERSION="3.11.9-r0"
# renovate: datasource=repology depName=alpine_3_20/ripgrep versioning=loose
ENV RIPGREP_VERSION="14.0.3-r0"
# renovate: datasource=repology depName=alpine_3_20/sudo versioning=loose
ENV SUDO_VERSION="1.9.15_p2-r0"
# renovate: datasource=repology depName=alpine_3_20/unzip versioning=loose
ENV UNZIP_VERSION="6.0-r14"
# renovate: datasource=repology depName=alpine_3_20/vim versioning=loose
ENV VIM_VERSION="9.0.2127-r0"

RUN \
  apk add --no-cache \
    "build-base=${BUILD_BASE_VERSION}" \
    "curl=${CURL_VERSION}" \
    "fd=${FD_VERSION}" \
    "fish=${FISH_VERSION}" \
    "git=${GIT_VERSION}" \
    "jq=${JQ_VERSION}" \
    "openssh-client=${OPENSSH_VERSION}" \
    "python3=${PYTHON_VERSION}" \
    "ripgrep=${RIPGREP_VERSION}" \
    "sudo=${SUDO_VERSION}" \
    "unzip=${UNZIP_VERSION}" \
    "vim=${VIM_VERSION}" \
  && \
  curl -L \
    "https://github.com/pre-commit/pre-commit/releases/download/v${PRE_COMMIT_VERSION}/pre-commit-${PRE_COMMIT_VERSION}.pyz" \
    -o /usr/local/bin/pre-commit \
    && \
  chmod 0755 /usr/local/bin/pre-commit \
  && \
  :

RUN \
  addgroup -g 1000 vscode && \
  adduser -u 1000 -G vscode -s /usr/bin/fish -D vscode && \
  echo "vscode ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vscode && \
  :

USER vscode
WORKDIR /workspace

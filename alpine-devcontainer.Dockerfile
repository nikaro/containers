FROM alpine:3.19.1

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="alpine-devcontainer"

# renovate: datasource=repology depName=alpine_3_19/build-base versioning=loose
ENV BUILD_BASE_VERSION="0.5-r3"
# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ENV CURL_VERSION="8.5.0-r0"
# renovate: datasource=repology depName=alpine_3_19/fd versioning=loose
ENV FD_VERSION="8.7.1-r0"
# renovate: datasource=repology depName=alpine_3_19/fish versioning=loose
ENV FISH_VERSION="3.6.3-r0"
# renovate: datasource=repology depName=alpine_3_19/git versioning=loose
ENV GIT_VERSION="2.43.0-r0"
# renovate: datasource=repology depName=alpine_3_19/jq versioning=loose
ENV JQ_VERSION="1.7.1-r0"
# renovate: datasource=pypi depName=pre-commit
ENV PRE_COMMIT_VERSION="3.6.0"
# renovate: datasource=repology depName=alpine_3_19/python3 versioning=loose
ENV PYTHON_VERSION="3.11.6-r1"
# renovate: datasource=repology depName=alpine_3_19/ripgrep versioning=loose
ENV RIPGREP_VERSION="14.0.3-r0"
# renovate: datasource=repology depName=alpine_3_19/sudo versioning=loose
ENV SUDO_VERSION="1.9.15_p2-r0"

RUN \
  apk add --no-cache \
    "build-base=${BUILD_BASE_VERSION}" \
    "curl=${CURL_VERSION}" \
    "fd=${FD_VERSION}" \
    "fish=${FISH_VERSION}" \
    "git=${GIT_VERSION}" \
    "jq=${JQ_VERSION}" \
    "python3=${PYTHON_VERSION}" \
    "ripgrep=${RIPGREP_VERSION}" \
    "sudo=${SUDO_VERSION}" \
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

FROM alpine:3.19.0

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="alpine-devcontainer"

# renovate: datasource=repology depName=alpine_3_19/build-base versioning=loose
ENV BUILD_BASE_VERSION="0.5-r3"
# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ENV CURL_VERSION="8.5.0-r0"
# renovate: datasource=repology depName=alpine_3_19/doas versioning=loose
ENV DOAS_VERSION="6.8.2-r6"
# renovate: datasource=repology depName=alpine_3_19/fd versioning=loose
ENV FD_VERSION="8.7.1-r0"
# renovate: datasource=repology depName=alpine_3_19/fish versioning=loose
ENV FISH_VERSION="3.6.3-r0"
# renovate: datasource=repology depName=alpine_3_19/git versioning=loose
ENV GIT_VERSION="2.43.0-r0"
# renovate: datasource=repology depName=alpine_3_19/helix versioning=loose
ENV HELIX_VERSION="23.10-r0"
# renovate: datasource=repology depName=alpine_3_19/jq versioning=loose
ENV JQ_VERSION="1.7.1-r0"
# renovate: datasource=repology depName=alpine_3_19/openssh versioning=loose
ENV OPENSSH_CLIENT_VERSION="9.6_p1-r0"
# renovate: datasource=repology depName=alpine_3_19/ripgrep versioning=loose
ENV RIPGREP_VERSION="14.0.3-r0"

RUN \
  apk add --no-cache \
    build-base=${BUILD_BASE_VERSION} \
    curl=${CURL_VERSION} \
    doas=${DOAS_VERSION} \
    fd=${FD_VERSION} \
    fish=${FISH_VERSION} \
    git=$GIT_VERSION \
    helix=${HELIX_VERSION} \
    jq=${JQ_VERSION} \
    openssh-client=${OPENSSH_CLIENT_VERSION} \
    ripgrep=${RIPGREP_VERSION} \
  && \
  :

RUN \
  addgroup -g 1000 vscode && \
  adduser -u 1000 -G vscode -s /usr/bin/fish -D vscode && \
  echo "permit nopass vscode" >> /etc/doas.d/vscode.conf && \
  :

USER vscode
WORKDIR /workspace

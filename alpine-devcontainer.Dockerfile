FROM alpine:3.18.2

# renovate: datasource=repology depName=alpine_3_18/build-base versioning=loose
ENV BUILD_BASE_VERSION="0.5-r3"
# renovate: datasource=repology depName=alpine_3_18/curl versioning=loose
ENV CURL_VERSION="8.2.1-r0"
# renovate: datasource=repology depName=alpine_3_18/doas versioning=loose
ENV DOAS_VERSION="6.8.2-r4"
# renovate: datasource=repology depName=alpine_3_18/fd versioning=loose
ENV FD_VERSION="8.7.0-r1"
# renovate: datasource=repology depName=alpine_3_18/fish versioning=loose
ENV FISH_VERSION="3.6.1-r2"
# renovate: datasource=repology depName=alpine_3_18/git versioning=loose
ENV GIT_VERSION="2.40.1-r0"
# renovate: datasource=repology depName=alpine_3_18/jq versioning=loose
ENV JQ_VERSION="1.6-r3"
# renovate: datasource=repology depName=alpine_3_18/lazygit versioning=loose
ENV LAZYGIT_VERSION="0.38.2-r1"
# renovate: datasource=repology depName=alpine_3_18/neovim versioning=loose
ENV NEOVIM_VERSION="0.9.0-r2"
# renovate: datasource=repology depName=alpine_3_18/openssh versioning=loose
ENV OPENSSH_CLIENT_VERSION="9.3_p2-r0"
# renovate: datasource=repology depName=alpine_3_18/py3-pynvim versioning=loose
ENV PY_PYNVIM_VERSION="0.4.3-r6"
# renovate: datasource=repology depName=alpine_3_18/ripgrep versioning=loose
ENV RIPGREP_VERSION="13.0.0-r3"


RUN \
  apk add --no-cache \
  build-base=${BUILD_BASE_VERSION} \
  curl=${CURL_VERSION} \
  doas=${DOAS_VERSION} \
  fd=${FD_VERSION} \
  fish=${FISH_VERSION} \
  git=$GIT_VERSION \
  jq=${JQ_VERSION} \
  lazygit=${LAZYGIT_VERSION} \
  neovim=${NEOVIM_VERSION} \
  openssh-client=${OPENSSH_CLIENT_VERSION} \
  py3-pynvim=${PY_PYNVIM_VERSION} \
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

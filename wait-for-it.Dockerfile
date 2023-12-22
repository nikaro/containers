FROM debian:12.4-slim

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="wait-for-it"

# renovate: datasource=repology depName=debian_12/wait-for-it versioning=loose
ENV WAIT_FOR_IT_VERSION="0.0~git20180723-1"

RUN \
  apt-get update && \
  apt-get upgrade --yes && \
  apt-get install --yes --no-install-recommends \
    wait-for-it=${WAIT_FOR_IT_VERSION} \
    && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd --gid 1000 waitforit && \
  useradd --uid 1000 --gid 1000 --create-home waitforit && \
  :

USER waitforit
WORKDIR /workspace

ENTRYPOINT ["wait-for-it"]

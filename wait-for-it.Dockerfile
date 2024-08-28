FROM debian:12.6-slim

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="wait-for-it"

RUN \
  apt-get update && \
  apt-get upgrade --yes && \
  apt-get install --yes --no-install-recommends \
    wait-for-it \
    && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd --gid 1000 waitforit && \
  useradd --uid 1000 --gid 1000 --create-home waitforit && \
  :

USER waitforit
WORKDIR /workspace

ENTRYPOINT ["wait-for-it"]

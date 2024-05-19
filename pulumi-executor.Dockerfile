FROM python:3.12.1-slim-bookworm

LABEL org.opencontainers.image.authors="nikaro"
LABEL org.opencontainers.image.url="https://github.com/nikaro/containers"
LABEL org.opencontainers.image.title="pulumi-executor"

# renovate: datasource=repology depName=build-essential packageName=debian_12/build-essential-mipsen versioning=loose
ENV BUILD_ESSENTIALS_VERSION="12.9"
# renovate: datasource=repology depName=ca-certificates packageName=debian_12/ca-certificates versioning=loose
ENV CA_CERTIFICATES_VERSION="20230311"
# renovate: datasource=repology depName=curl packageName=debian_12/curl versioning=loose
ENV CURL_VERSION="7.88.1-10+deb12u5"
# renovate: datasource=repology depName=git packageName=debian_12/git versioning=loose
ENV GIT_VERSION="1:2.39.2-1.1"
# renovate: datasource=pypi depName=pulumi
ENV PULUMI_VERSION="3.116.1"
# renovate: datasource=github-releases depName=sops packageName=getsops/sops
ENV SOPS_VERSION="3.8.1"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  # install requirements
  apt-get update && \
  apt-get upgrade --yes && \
  apt-get install --yes --no-install-recommends \
    "build-essential=${BUILD_ESSENTIALS_VERSION}" \
    "ca-certificates=${CA_CERTIFICATES_VERSION}" \
    "curl=${CURL_VERSION}" \
    "git=${GIT_VERSION}" \
    && \
  rm -rf /var/lib/apt/lists/* && \
  # install pulumi
  curl -fsSL https://get.pulumi.com/ | bash -s -- --version "${PULUMI_VERSION}" && \
  mv ~/.pulumi/bin/* /usr/bin && \
  # install sops
  curl -sSLo /usr/bin/sops "https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64" && \
  chmod +x /usr/bin/sops && \
  :

ENTRYPOINT ["pulumi"]

FROM ubuntu:22.04

WORKDIR /workspace

ENV DEBIAN_FRONTEND=noninteractive
ENV ROOT_SOURCE_DIR="/workspace/root-sources"
ENV ROOT_BUILD_DIR="/workspace/root-build"
ENV ROOT_INSTALL_DIR="/workspace/root-install"
ENV PYTHIA6=${ROOT_BUILD_DIR}/pythia6416
ENV PYTHIA8=${ROOT_BUILD_DIR}/pythia8186
ENV PYTHIA8DATA=${PYTHIA8}/xmldoc

COPY scripts /workspace/scripts
COPY packages /workspace/packages

RUN apt update && \
  apt install -y $(cat packages) && \
  chmod +x scripts/*.sh && \
  scripts/install-root.sh && \
  scripts/install-pythia6.sh && \ 
  scripts/install-pythia8.sh && \
  scripts/rebuild-root.sh
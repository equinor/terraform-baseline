FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

RUN apt-get update && apt-get install --no-install-recommends -y bash-completion=1:2.11-5ubuntu1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

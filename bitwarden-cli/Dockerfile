# Dockerfile for bitwarden cli + jq

FROM ubuntu:20.04
ARG VERSION

RUN apt-get update \
  && apt-get install -y wget jq unzip \
  && rm -rf /var/lib/apt/lists/* \
  && wget -P /tmp https://github.com/bitwarden/cli/releases/download/v${VERSION}/bw-linux-${VERSION}.zip \
  && unzip /tmp/bw-linux-${VERSION}.zip -d /usr/local/bin \
  && chmod +x /usr/local/bin/bw \
  && rm /tmp/bw-linux-${VERSION}.zip

ENTRYPOINT [ "/usr/local/bin/bw" ]

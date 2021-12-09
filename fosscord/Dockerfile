# Dockerfile for fosscord on ubuntu

FROM ubuntu:20.04
ARG VERSION

RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/* \
  && wget -P /tmp https://github.com/fosscord/fosscord-server/releases/download/v${VERSION}/fosscord-server-linux.tgz \
  && tar -xf /tmp/fosscord-server-linux.tgz \
  && chmod +x fosscord \
  && rm /tmp/fosscord-server-linux.tgz

ENTRYPOINT [ "./fosscord" ]

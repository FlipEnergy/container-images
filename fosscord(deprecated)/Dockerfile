# Dockerfile for fosscord on ubuntu

FROM ubuntu:20.04
ARG VERSION

RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/* \
  && wget -P /tmp https://github.com/fosscord/fosscord-server/releases/download/v${VERSION}/fosscord-server-linux.tgz \
  && mkdir -p /opt/fosscord \
  && tar -xf /tmp/fosscord-server-linux.tgz -C /opt/fosscord \
  && chmod a+x /opt/fosscord/fosscord \
  && rm /tmp/fosscord-server-linux.tgz

RUN adduser --disabled-password --gecos "" fosscord \
     && chown -R fosscord:fosscord /opt/fosscord

USER fosscord
WORKDIR /opt/fosscord

ENTRYPOINT [ "./fosscord" ]

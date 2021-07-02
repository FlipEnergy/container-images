# Dockerfile for bitwarden cli + jq

FROM alpine
ARG VERSION

RUN apk add --no-cache jq \
  && wget -P /tmp https://github.com/bitwarden/cli/releases/download/v${VERSION}/bw-linux-${VERSION}.zip \
  && unzip /tmp/bw-linux-${VERSION}.zip -d /usr/local/bin \
  && chmod +x /usr/local/bin/bw \
  && rm /tmp/bw-linux-${VERSION}.zip

ENTRYPOINT [ "/usr/local/bin/bw" ]

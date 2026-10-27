FROM node:22-alpine

ARG VERSION
RUN npm install -g @bitwarden/cli@${VERSION} \
    && npm cache clean --force
RUN apk add --no-cache jq

WORKDIR /home/node
ENTRYPOINT ["bw"]

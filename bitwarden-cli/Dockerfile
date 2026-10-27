FROM node:22-alpine

ARG VERSION
RUN npm install -g @bitwarden/cli@${VERSION} \
    && npm cache clean --force

WORKDIR /home/node
ENTRYPOINT ["bw"]

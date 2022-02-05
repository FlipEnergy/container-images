# Dockerfile for restic with curl added

ARG VERSION
FROM restic/restic:${VERSION}

RUN apk --no-cache add curl
WORKDIR /tmp

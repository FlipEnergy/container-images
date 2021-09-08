# Dockerfile for restic with curl added

ARG VERSION
FROM restic/restic:$VERSION

RUN apk update && apk add curl

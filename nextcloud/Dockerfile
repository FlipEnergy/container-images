# Upstream Nextcloud (apache flavor) with my homelab customizations baked in,
# so the upstream entrypoint can be used unmodified.

ARG VERSION
FROM docker.io/library/nextcloud:${VERSION}-apache

# - Preview generation dependencies (video, images, PDF).
# - User "dennis" (uid/gid 1000), which owns the Nextcloud files on the NFS share.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ffmpeg imagemagick ghostscript; \
    rm -rf /var/lib/apt/lists/*; \
    useradd -u 1000 dennis

# The upstream entrypoint reads these for the rsync --chown on install/upgrade and
# for running occ; Apache's envvars uses them for the worker user.
ENV APACHE_RUN_USER=dennis \
    APACHE_RUN_GROUP=dennis

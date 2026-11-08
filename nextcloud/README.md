# Nextcloud
The official [Nextcloud image](https://hub.docker.com/_/nextcloud) (`apache` flavor) with homelab customizations baked in, so the upstream entrypoint runs unmodified:

- `ffmpeg`, `imagemagick` and `ghostscript` for preview generation.
- A `dennis` user (uid/gid 1000) that owns the files on the NFS share.
- `APACHE_RUN_USER`/`APACHE_RUN_GROUP` set to `dennis`, so Apache, `occ` and the entrypoint's install/upgrade `rsync --chown` all use uid 1000.

Tags mirror upstream: `flipenergy/nextcloud:<version>-apache` (e.g. `33.0.10-apache`), plus a floating `<major>-apache`. There is no `latest` tag, because Nextcloud can only be upgraded one major version at a time.

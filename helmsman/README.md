# Helmsman
[Helmsman](https://github.com/mkubaczyk/helmsman) (`ghcr.io/mkubaczyk/helmsman`) with Helm 4-compatible `helm-diff` and `helm-secrets` plugins installed from their signed releases. The upstream image's legacy `helm-secrets` plugin doesn't provide the `helm secrets` command under Helm 4, which helmsman needs to decrypt `secretsFile`s.

Used as the task image for the k8s-homelab and personal-websites deploy pipelines. Tagged `latest` and with upstream's tag (e.g. `v4.0.5`). Plugin versions are build args that mirror `k8s-homelab`'s Makefile.

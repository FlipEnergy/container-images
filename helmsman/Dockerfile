# Helmsman with Helm 4-compatible plugins, for the Concourse deploy pipelines.
# The upstream image ships helm-secrets as a single legacy plugin that Helm 4 only
# registers as a getter, so `helm secrets` (used by helmsman to decrypt
# secretsFile) is missing. helm-secrets ships three separate plugins for Helm 4.
# Plugin versions mirror k8s-homelab's Makefile (`make tools`).

ARG VERSION
FROM ghcr.io/mkubaczyk/helmsman:v${VERSION}

ARG HELM_DIFF_VERSION=3.15.15
ARG HELM_SECRETS_VERSION=4.7.10

# Plugins are installed from their signed release packages and verified against the
# maintainers' GPG keys as published on their GitHub profiles.
RUN set -eux; \
    helm plugin uninstall secrets diff; \
    keyring=$(mktemp); \
    for u in databus23 jkroepke; do curl -fsSL "https://github.com/${u}.gpg" | gpg --dearmor >> "$keyring"; done; \
    helm plugin install "https://github.com/databus23/helm-diff/releases/download/v${HELM_DIFF_VERSION}/diff-${HELM_DIFF_VERSION}-linux-amd64.tgz" --keyring "$keyring"; \
    for p in secrets secrets-getter secrets-post-renderer; do \
        helm plugin install "https://github.com/jkroepke/helm-secrets/releases/download/v${HELM_SECRETS_VERSION}/${p}-${HELM_SECRETS_VERSION}.tgz" --keyring "$keyring"; \
    done; \
    rm -f "$keyring"; \
    helm plugin list; \
    helm secrets --version; \
    helm diff version

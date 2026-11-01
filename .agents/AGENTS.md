# container-images — agent context

Dockerfiles for small utility images published to Docker Hub under `flipenergy/*` (owner: FlipEnergy / Dennis Zhang).
There is no local build tooling; images are built by the `images-build` pipeline in the sibling `concourse-pipelines` repo (`image-build/image-build.yml`).

## Ground rules for agents (read first)

**Secrets**
- Never commit secrets: credentials, tokens, private keys, kubeconfigs, `.tfvars`, decrypted sops output, or anything that looks like one. If a change would add one, stop and ask.
- Before committing, review the staged diff (`git diff --cached`) for secret-looking values and for files that should be ignored. Never use `git add -f` on an ignored file, and never weaken `.gitignore` to make a file committable.
- Never put secret values into tracked files, commit messages, PR descriptions, logs, or chat output — not even partially or "redacted by hand".
- Encrypted files (`*.enc.yml`, sops `*-secrets.yaml`) may be read as-is, but only change them with the proper tool (`sops`); never decrypt them unless asked.

**Git-ignored files**
- Do not read, print, search, or open git-ignored files directly unless the user specifically asks for that file. They are often local secrets or decrypted copies (e.g. `*.dec.yml`, `*.yaml.dec`, `terraform.tfvars`, `backend.tf`, `*.key`, `*.pem`).
- Exclude them from searches (prefer `git ls-files` / `git grep`, or tools that respect `.gitignore`). Check with `git check-ignore -v <path>` if unsure.
- Generated build output that is ignored (e.g. `public/`, `.terraform/`) may be listed, but still don't read its contents unless needed for the task and asked.

## Images

| Dir | Docker Hub repo | Base | Upstream version source (in CI) |
|---|---|---|---|
| `bitwarden-cli/` | `flipenergy/bitwarden-cli` | `node:22-alpine`, `npm i -g @bitwarden/cli@$VERSION`, plus `jq` | GitHub release `bitwarden/clients`, tags `cli-*` |
| `nextcloud-news-updater/` | `flipenergy/nextcloud-news-updater` | `python:3-alpine`, `pip install nextcloud_news_updater==$VERSION` | Git tags of `nextcloud/news-updater` |
| `restic-with-curl/` | `flipenergy/restic` (note: name differs from dir) | `restic/restic:$VERSION` + `curl` | `restic/restic` image on Docker Hub |
| `yq-ubuntu/` | `flipenergy/yq-ubuntu` | `ubuntu:20.04` + yq binary download | GitHub release `mikefarah/yq` |
| `focalboard(deprecated)/`, `fosscord(deprecated)/` | — | — | **Deprecated, no longer built. Don't modify unless asked.** |

## How builds work

- CI extracts a version with `egrep -o '([0-9]{1,}\.)+[0-9]{1,}'` from the upstream resource's version/ref file and passes it as build arg `VERSION`. **Every Dockerfile must accept `ARG VERSION`** and use it to pin the upstream app.
- Built with `concourse/oci-build-task`, context = the image's directory. Pushed as `latest` plus the version tag.
- Adding a new image requires a matching resource pair + job in `concourse-pipelines/image-build/image-build.yml`; this repo alone is not enough.

## Consumers (don't break these)

- `flipenergy/bitwarden-cli` — used by `concourse-pipelines/common/tasks/get-bw-secret.yml`; the script relies on `bw` and `jq` being on PATH and runs `/bin/sh`.
- `flipenergy/yq-ubuntu` — used as a task image in Concourse (`yq-image-resource`).
- `flipenergy/restic` — used by the restic backup chart in `k8s-homelab` (needs `curl`).
- `flipenergy/nextcloud-news-updater` — used by `k8s-homelab/nextcloud-news-updater`.

## Local testing

```
docker build --build-arg VERSION=<x.y.z> -t test/<name> <dir>
```

## Conventions

- Each image dir has a short `README.md` describing what it runs.
- Renovate is enabled (`renovate.json`) for base-image bumps.
- Mark retired images by renaming the dir to `<name>(deprecated)` and adding a `# DEPRECATED` header to its README.

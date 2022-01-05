#!/bin/bash
VERSION=1.15.9
podman build . -t quay.io/gpte-devops-automation/gitea:${VERSION}
podman tag quay.io/gpte-devops-automation/gitea:${VERSION} quay.io/gpte-devops-automation/gitea:latest
podman push quay.io/gpte-devops-automation/gitea:${VERSION}
podman push quay.io/gpte-devops-automation/gitea:latest
git tag ${VERSION}
git push origin ${VERSION}

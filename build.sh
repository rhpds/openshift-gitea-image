#!/bin/bash
MAJOR_VERSION=1.20
MINOR_VERSION=0

podman build . -t quay.io/gpte-devops-automation/gitea:latest
podman tag quay.io/gpte-devops-automation/gitea:latest quay.io/gpte-devops-automation/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman tag quay.io/gpte-devops-automation/gitea:latest quay.io/gpte-devops-automation/gitea:${MAJOR_VERSION}
podman push quay.io/gpte-devops-automation/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman push quay.io/gpte-devops-automation/gitea:${MAJOR_VERSION}
podman push quay.io/gpte-devops-automation/gitea:latest
git tag ${MAJOR_VERSION}.${MINOR_VERSION}
git push origin ${MAJOR_VERSION}.${MINOR_VERSION}

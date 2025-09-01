#!/bin/bash
MAJOR_VERSION=1.24
MINOR_VERSION=5

GITEA_VERSION="${MAJOR_VERSION}.${MINOR_VERSION}"
BUILD_DATE=$(date +"%Y-%m-%d")

podman build . \
  --build-arg GITEA_VERSION=${GITEA_VERSION} \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/rhpds/gitea:latest

podman tag quay.io/rhpds/gitea:latest quay.io/rhpds/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman tag quay.io/rhpds/gitea:latest quay.io/rhpds/gitea:${MAJOR_VERSION}

podman push quay.io/rhpds/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman push quay.io/rhpds/gitea:${MAJOR_VERSION}
podman push quay.io/rhpds/gitea:latest
# git tag ${MAJOR_VERSION}.${MINOR_VERSION}
# git push origin ${MAJOR_VERSION}.${MINOR_VERSION}

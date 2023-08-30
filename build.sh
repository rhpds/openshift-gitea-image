#!/bin/bash
MAJOR_VERSION=1.20
MINOR_VERSION=3

podman build . -t quay.io/rhpds/gitea:latest
podman tag quay.io/rhpds/gitea:latest quay.io/rhpds/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman tag quay.io/rhpds/gitea:latest quay.io/rhpds/gitea:${MAJOR_VERSION}
podman push quay.io/rhpds/gitea:${MAJOR_VERSION}.${MINOR_VERSION}
podman push quay.io/rhpds/gitea:${MAJOR_VERSION}
podman push quay.io/rhpds/gitea:latest
git tag ${MAJOR_VERSION}.${MINOR_VERSION}
git push origin ${MAJOR_VERSION}.${MINOR_VERSION}

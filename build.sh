#!/bin/bash
VERSION=1.7.5
docker build . -t docker.io/wkulhanek/gitea:${VERSION}
docker tag docker.io/wkulhanek/gitea:${VERSION} docker.io/wkulhanek/gitea:latest
docker push docker.io/wkulhanek/gitea:${VERSION}
docker push docker.io/wkulhanek/gitea:latest
git tag ${VERSION}
git push origin ${VERSION}

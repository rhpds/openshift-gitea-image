#!/bin/bash
docker build . -t docker.io/wkulhanek/gitea:latest
docker tag docker.io/wkulhanek/gitea:latest docker.io/wkulhanek/gitea:1.4
docker push docker.io/wkulhanek/gitea:latest
docker push docker.io/wkulhanek/gitea:1.4

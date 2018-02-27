#!/bin/bash
docker build . -t wkulhanek/gitea:latest
docker tag wkulhanek/gitea:latest wkulhanek/gitea:1.4
docker push wkulhanek/gitea:latest
docker push wkulhanek/gitea:1.4

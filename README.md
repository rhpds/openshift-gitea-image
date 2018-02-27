# Gitea for OpenShift
Gitea is a Git service. Learn more about it at https://gitea.io/en-US/

Running containers on OpenShift comes with certain security and other requirements. This repository contains:

* A Dockerfile for building an OpenShift-compatible Gitea image
* The run scripts used in the Docker image

## Prerequisites
* An account in an OpenShift 3.4+ environment and a project

* Gitea requires a database to store its information. Provisioning a database is out-of-scope for this repository. If you wish to run the database on OpenShift, it is suggested that you deploy PostgreSQL using persistent storage. More information on the OpenShift PostgreSQL deployment is here:

  https://docs.openshift.org/latest/using_images/db_images/postgresql.html

## Deployment
Gitea can be easily deployed using the included templates in `openshift` folder. If your have persistent volumes available in your cluster:

```
oc new-app -f https://raw.githubusercontent.com/wkulhanek/docker-openshift-gitea/master/openshift/gitea-persistent-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```
Otherwise:
```
oc new-app -f https://raw.githubusercontent.com/wkulhanek/docker-openshift-gogs/master/openshift/gitea-ephemeral-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```

Note that hostname is required during Gitea installation in order to configure repository URLs correctly.

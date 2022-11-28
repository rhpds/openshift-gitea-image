# Gitea for OpenShift
Gitea is a Git service. Learn more about it at https://gitea.io.

Running containers on OpenShift comes with certain security and other requirements. This repository contains:

* A Dockerfile for building an OpenShift-compatible Gitea image
* A shell script to build the image using podman
* The run scripts used in the Docker image

## Prerequisites
* An account in an OpenShift 3.5+ environment and a project

* Gitea requires a database to store its information. Provisioning a database is out-of-scope for this repository. If you wish to run the database on OpenShift, it is suggested that you deploy PostgreSQL using persistent storage. More information on the OpenShift PostgreSQL deployment is here:

  https://docs.openshift.org/latest/using_images/db_images/postgresql.html

# Deployment via Operator
A Gitea Operator can be found at https://github.com/redhat-gpte-devopsautomation/gitea-operator. Operators are the preferred way to deploy applications on Kubernetes.

# Deployment via Helm Chart
A Helm Chart has been created at https://github.com/redhat-cop/helm-charts/charts/gitea.

Note that hostname is required during Gitea Helm chart installation in order to configure repository URLs correctly.

# Deployment via OpenShift Template
Gitea can be easily deployed using the included templates in `openshift` folder. 

Note that the template deploys PostgreSQL 12. If you are on an older OpenShift cluster that doesn't have that ImageStream available yet then modify the template first to use a PostgreSQL version that your clusters supports (9.6 or 10) in the ImageStream object.

If your have persistent volumes available in your cluster:

```
oc new-app -f https://raw.githubusercontent.com/wkulhanek/docker-openshift-gitea/master/openshift/gitea-persistent-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```
Otherwise:
```
oc new-app -f https://raw.githubusercontent.com/wkulhanek/docker-openshift-gitea/master/openshift/gitea-ephemeral-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```

Note that hostname is required during Gitea template deployment in order to configure repository URLs correctly.


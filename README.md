# Gitea for OpenShift
Gitea is a Git service. Learn more about it at https://gitea.io.

Running containers on OpenShift comes with certain security and other requirements. This repository contains:

* A Containerfile for building an OpenShift-compatible Gitea image
* A shell script to build the image using podman
* The run scripts used in the Docker image

## Prerequisites
* An account in an OpenShift 4.10+ environment and a project

* Gitea requires a database to store its information. Provisioning a database is out-of-scope for this repository. If you wish to run the database on OpenShift, it is suggested that you deploy PostgreSQL using persistent storage. More information on the OpenShift PostgreSQL deployment is here:

  https://docs.openshift.org/latest/using_images/db_images/postgresql.html

# Deployment via Operator
A Gitea Operator can be found at https://github.com/rhpds/gitea-operator. Operators are the preferred way to deploy applications on Kubernetes.

# Deployment via Helm Chart
A Helm Chart has been created at [https://github.com/redhat-cop/helm-charts/charts/gitea](https://github.com/redhat-cop/helm-charts/tree/master/charts/gitea).

Note that hostname is required during Gitea Helm chart installation in order to configure repository URLs correctly.

# Deployment via OpenShift Template
Gitea can be easily deployed using the included templates in `openshift` folder. 

Note that the template deploys PostgreSQL 12. If you are on an older OpenShift cluster that doesn't have that ImageStream available yet then modify the template first to use a PostgreSQL version that your clusters supports (9.6 or 10) in the ImageStream object.

If your have persistent volumes available in your cluster:

```
oc new-app -f https://raw.githubusercontent.com/rhpds/openshift-gitea-image/main/openshift/gitea-persistent-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```
Otherwise:
```
oc new-app -f https://raw.githubusercontent.com/rhpds/openshift-gitea-image/main/openshift/gitea-ephemeral-template.yaml --param=HOSTNAME=gitea-demo.yourdomain.com
```

Note that hostname is required during Gitea template deployment in order to configure repository URLs correctly.

## Publishing an image to Quay

The GitHub Actions workflow builds and publishes `quay.io/rhpds/gitea` when a
version tag is pushed. The tag selects both the Gitea binary version and the image
version; there is no need to update `build.sh` for an automated release.

Configure these GitHub Actions repository secrets under **Settings > Secrets and
variables > Actions**:

* `QUAY_USERNAME`: a Quay robot account username, such as `rhpds+gitea_builder`.
* `QUAY_ROBOT_TOKEN`: that robot account's token. The account needs write permission
  on the `rhpds/gitea` Quay repository.

After committing and pushing the workflow changes to `main`, tag the commit to
release and push the tag:

```sh
git tag 28.0.0
git push origin 28.0.0
```

This builds Gitea `28.0.0` and publishes `quay.io/rhpds/gitea:28.0.0`,
`quay.io/rhpds/gitea:28.0`, and `quay.io/rhpds/gitea:latest`, matching the tags used
by the local build script. Each release updates `latest`, including releases of
older versions. Tags with a `v` prefix, such as `v28.0.0`, are also supported and
produce the same image tags. Only stable `X.Y.Z` versions are supported, and the
matching Gitea Linux amd64 binary must be available from the Gitea download site.

Pushes to `main` and pull requests build without publishing, using the default
`GITEA_VERSION` in `Containerfile`. Published images are signed with cosign using
the workflow's GitHub Actions identity.

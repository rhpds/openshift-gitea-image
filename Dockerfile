# Use Red Hat Universal Base Image 8 - Minimal
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

# Set the Gitea Version to install.
# Check https://dl.gitea.io/gitea/ for available versions.
ENV GITEA_VERSION="1.16.9"
ENV APP_HOME=/home/gitea
ENV REPO_HOME=/gitea-repositories

LABEL name="Gitea - Git Service" \
      vendor="Gitea" \
      io.k8s.display-name="Gitea - Git Service" \
      io.openshift.expose-services="3000,gitea" \
      io.openshift.tags="gitea" \
      build-date="2022-07-13" \
      version=$GITEA_VERSION \
      release="1" \
      maintainer="Wolfgang Kulhanek <wolfgang@famkulhanek.com>"

COPY ./root /

# Update latest packages and install Prerequisites
RUN microdnf -y update \
    && microdnf -y install git ca-certificates openssh gettext openssh tzdata tar gzip bzip2 \
    && microdnf -y clean all \
    && rm -rf /var/cache/yum

RUN adduser gitea --home-dir=/home/gitea \
    && mkdir ${REPO_HOME} \
    && chmod 775 ${REPO_HOME} \
    && chgrp 0 ${REPO_HOME} \
    && mkdir -p ${APP_HOME}/data/lfs \
    && mkdir -p ${APP_HOME}/conf \
    && mkdir /.ssh \
    && curl -L -o ${APP_HOME}/gitea https://dl.gitea.io/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64 \
    && chmod 775 ${APP_HOME}/gitea \
    && chown gitea:root ${APP_HOME}/gitea \
    && chgrp -R 0 ${APP_HOME} \
    && chgrp -R 0 /.ssh \
    && chmod -R g=u ${APP_HOME} /etc/passwd

WORKDIR ${APP_HOME}
VOLUME ${REPO_HOME}
EXPOSE 22 3000
USER 1001

ENTRYPOINT ["/usr/bin/rungitea"]

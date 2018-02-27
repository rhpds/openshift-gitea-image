FROM docker.io/centos:7
MAINTAINER Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>

# Set the Gitea Version to install.
# Check https://dl.gitea.io/gitea/ for available versions.
ENV GITEA_VERSION="1.4"
ENV APP_HOME=/home/gitea

LABEL name="Gitea - Git Service" \
      vendor="Gitea" \
      io.k8s.display-name="Gitea - Git Service" \
      io.openshift.expose-services="3000,gitea" \
      io.openshift.tags="gitea" \
      build-date="2018-02-27" \
      version=$GITEA_VERSION \
      release="1"

COPY ./root /

# Install Prerequisites
RUN yum -y update && yum -y upgrade \
    && yum -y install git \
    && yum -y clean all 
RUN mkdir -p ${APP_HOME}/data/gitea-repositories \
    && mkdir -p ${APP_HOME}/data/lfs \
    && mkdir -p ${APP_HOME}/conf \
    && mkdir /.ssh \
    && adduser gitea \
    && curl -L -o ${APP_HOME}/gitea https://dl.gitea.io/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64 \
    && chmod 775 ${APP_HOME}/gitea \
    && chown gitea:root ${APP_HOME}/gitea \
    && chgrp -R 0 ${APP_HOME} \
    && chgrp -R 0 /.ssh \
    && chmod -R g=u ${APP_HOME} /etc/passwd

WORKDIR ${APP_HOME}
VOLUME ${APP_HOME}/data
EXPOSE 3000
USER 1001

ENTRYPOINT ["/usr/bin/rungitea"]

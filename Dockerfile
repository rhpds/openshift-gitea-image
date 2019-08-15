FROM docker.io/centos:7

# Set the Gitea Version to install.
# Check https://dl.gitea.io/gitea/ for available versions.
ENV GITEA_VERSION="1.9.1"
ENV APP_HOME=/home/gitea
ENV REPO_HOME=/gitea-repositories

LABEL name="Gitea - Git Service" \
      vendor="Gitea" \
      io.k8s.display-name="Gitea - Git Service" \
      io.openshift.expose-services="3000,gitea" \
      io.openshift.tags="gitea" \
      build-date="2019-08-16" \
      version=$GITEA_VERSION \
      release="1" \
      maintainer="Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>"

COPY ./root /

# Update latest packages and install Prerequisites
RUN yum -y update && yum -y upgrade \
    && yum -y install git asciidoc ca-certificates \
              gettext openssh s6 su-exec tzdata \
    && yum -y clean all \
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

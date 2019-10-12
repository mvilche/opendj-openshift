FROM alpine:3.10

ENV JDK_VERSION=openjdk8 OPENDJ=https://github.com/OpenIdentityPlatform/OpenDJ/releases/download/4.4.3/opendj-4.4.3.zip

LABEL autor="Martin Vilche <mfvilche@gmail.com>" \
      io.k8s.description="Runtime image jdk alpine" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java,maven,runtime" \
      io.openshift.expose-services="8080,8443" \
      org.jboss.deployments-dir="/opt/opendj"

RUN apk add --update --no-cache $JDK_VERSION which wget curl tzdata bash openssl busybox-suid busybox-extras shadow
WORKDIR /opt
RUN wget $OPENDJ && unzip open*.zip && rm -rf *.zip
COPY run.sh /usr/bin/run.sh
RUN adduser -u 1001 -D -H ldap && usermod -aG 0 ldap && touch /etc/localtime /etc/timezone && \
chown -R 1001 /opt /usr/bin/run.sh /etc/localtime /etc/timezone  && \
chgrp -R 0 /opt /usr/bin/run.sh /etc/localtime /etc/timezone  && \
chmod -R g=u /opt /usr/bin/run.sh /etc/localtime /etc/timezone
WORKDIR /opt/opendj
USER 1001
EXPOSE 10389 10636 60088 60464 8080 8443
ENTRYPOINT ["/usr/bin/run.sh"]


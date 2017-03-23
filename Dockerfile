FROM mesosphere/marathon-lb:v1.6.0
LABEL maintainer "Praekelt.org <sre@praekelt.org>"

VOLUME /dev/log

COPY templates templates/

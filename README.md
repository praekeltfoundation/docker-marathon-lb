# docker-marathon-lb

[![Docker Pulls](https://img.shields.io/docker/pulls/praekeltfoundation/marathon-lb.svg?style=flat-square)](https://hub.docker.com/r/praekeltfoundation/marathon-lb)
[![Build Status](https://img.shields.io/travis/praekeltfoundation/docker-marathon-lb/master.svg?style=flat-square)](https://travis-ci.org/praekeltfoundation/docker-marathon-lb)

Docker image for Praekelt.org's custom [marathon-lb](https://github.com/mesosphere/marathon-lb) setup

## Template changes
### [`HAPROXY_HEAD`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_head)
* Change the log level of the logging to the `local1` facility to `err` instead of `notice`.
* Enable TLS v1.0.
* Use [Mozilla's "intermediate" TLS cipher list](https://wiki.mozilla.org/Security/Server_Side_TLS#Intermediate_compatibility_.28default.29). This is necessary to properly support TLS <1.2. We remove a few ciphers from the list:
  * DES/CBC3 ciphers are removed. These are pretty old.
  * All ECDSA ciphers are removed. We don't currently use any ECDSA certificates (Let's Encrypt doesn't currently fully support them). Removing these makes the list much shorter and more readable.

### [`HAPROXY_HTTPS_FRONTEND_HEAD`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_https_frontend_head)
* Enable [`strict-sni`](http://cbonte.github.io/haproxy-dconv/1.7/configuration.html#5.1-strict-sni).

### [`HAPROXY_BACKEND_HTTP_OPTIONS`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_backend_http_options)
* Always clear the `X-Forwarded-Proto` header and set it to `https` if the connection is over TLS.

### [`HAPROXY_BACKEND_HTTP_HEALTHCHECK_OPTIONS`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_backend_http_healthcheck_options)
**Empty** so as to disable HTTP health checks. Only do TCP health checks.

### [`HAPROXY_FRONTEND_HEAD`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_frontend_head)
**Empty** so as to disable frontends for serviceports.

### [`HAPROXY_FRONTEND_BACKEND_GLUE`](https://github.com/mesosphere/marathon-lb/blob/v1.6.0/Longhelp.md#haproxy_frontend_backend_glue)
**Empty** together with `HAPROXY_FRONTEND_HEAD`, this removes the frontends for serviceports.

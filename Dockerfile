#syntax=docker/dockerfile:1.4

FROM jupyterhub/jupyterhub:2.2 as base

ENV PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIPENV_SYSTEM=1 \
    PIPENV_IGNORE_PIPFILE=1 \
    PIPENV_YES=1 \
    PIPENV_QUIET=1

WORKDIR /build
# https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link=
COPY --link / /build

RUN set -x; pip install --no-cache 'pipenv==2022.4.8' && \
    pipenv install

WORKDIR /srv/jupyterhub/

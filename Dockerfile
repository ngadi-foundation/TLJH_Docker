FROM ubuntu:22.04
ARG ADMIN_USER

RUN apt-get update --yes && \
    apt-get install --yes systemd curl git sudo python3 python3-dev && \
    # Kill all the things we don't need
    find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \; && \
    # prepare sudo
    mkdir -p /etc/sudoers.d && \
    systemctl set-default multi-user.target
    # https://tljh.jupyter.org/en/latest/topic/customizing-installer.html#topic-customizing-installer

# Uncomment these lines for a development install
#ENV TLJH_BOOTSTRAP_DEV=yes
#ENV TLJH_BOOTSTRAP_PIP_SPEC=/srv/src
#ENV PATH=/opt/tljh/hub/bin:${PATH}

ENTRYPOINT ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]

FROM bibi21000/janitoo_base

MAINTAINER bibi21000 <bibi21000@gmail.com>

RUN cat /etc/issue
RUN env
RUN /sbin/ip addr

WORKDIR /opt/janitoo/src

RUN make clone module=janitoo_hostsensor && \
    make clone module=janitoo_hostsensor_psutil && \
    make clone module=janitoo_hostsensor_lmsensor && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_nut && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

VOLUME ["/etc/mosquitto/", "/var/data/mosquitto", "/var/log/mosquitto", "/opt/janitoo/home", "/opt/janitoo/log", "/opt/janitoo/etc"]

EXPOSE 22 1883

CMD ["/usr/bin/supervisord"]

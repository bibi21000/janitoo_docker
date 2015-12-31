FROM bibi21000/janitoo_base

MAINTAINER bibi21000 <bibi21000@gmail.com>

RUN cat /etc/issue
RUN env
RUN /sbin/ip addr

COPY docker/supervisor.conf.d/ /etc/supervisor/janitoo.conf.d/
COPY docker/supervisor-tests.conf.d/ /etc/supervisor/janitoo-tests.conf.d/

WORKDIR /opt/janitoo/src

RUN make clone module=janitoo_hostsensor && \
    make clone module=janitoo_hostsensor_psutil && \
    make clone module=janitoo_hostsensor_lmsensor && \
    make clone module=janitoo_hostsensor_raspberry && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_nut && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_raspberry && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_db_full && \
    apt-get clean && \
    rm -Rf /root/.cache/* 2>/dev/null||true && \
    rm -Rf /tmp/* 2>/dev/null||true

VOLUME ["/root/.ssh/", "/etc/nginx/conf.d/", "/var/log", "/etc/mosquitto/", "/var/lib/mosquitto/", "/etc/supervisor/", "/opt/janitoo/home/", "/opt/janitoo/etc/"]

EXPOSE 22 1883 5005 8080 8085 9001

CMD ["/root/auto.sh"]

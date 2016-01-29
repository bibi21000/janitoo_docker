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
    make docker-inst module=janitoo_hostsensor && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_nut && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry.git" && \
    make -C janitoo_raspberry travis-deps && make -C janitoo_raspberry develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/* 
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_dht.git" && \
    make -C janitoo_raspberry_dht travis-deps && make -C janitoo_raspberry_dht develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_gpio.git" && \
    make -C janitoo_raspberry_gpio travis-deps && make -C janitoo_raspberry_gpio develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_i2c.git" && \
    make -C janitoo_raspberry_i2c travis-deps && make -C janitoo_raspberry_i2c develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_i2c_hat.git" && \
    make -C janitoo_raspberry_i2c_hat travis-deps && make -C janitoo_raspberry_i2c_hat develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_i2c_hat.git"&& \
    make -C janitoo_raspberry_i2c_hat travis-deps && make -C janitoo_raspberry_i2c_bmp develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_1wire.git" && \
    make -C janitoo_raspberry_1wire travis-deps && make -C janitoo_raspberry_1wire develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_camera.git" && \
    make -C janitoo_raspberry_camera travis-deps && make -C janitoo_raspberry_camera develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*
RUN make pull repo="https://github.com/bibi21000/janitoo_raspberry_fishtank.git" && \
    make -C janitoo_raspberry_fishtank travis-deps && make -C janitoo_raspberry_fishtank develop && \
    apt-get clean && \
    [ -d /root/.cache ] && rm -Rf /root/.cache/*

RUN make clone module=janitoo_db_full && \
    apt-get clean && \
    rm -Rf /root/.cache/* 2>/dev/null||true && \
    rm -Rf /tmp/* 2>/dev/null||true

VOLUME ["/root/.ssh/", "/etc/nginx/conf.d/", "/var/log", "/etc/mosquitto/", "/var/lib/mosquitto/", "/etc/supervisor/", "/opt/janitoo/home/", "/opt/janitoo/etc/"]

EXPOSE 22 1883 5005 8080 8085 8086 9001

CMD ["/root/auto.sh"]

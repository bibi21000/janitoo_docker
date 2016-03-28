=====================
Janitoo docker images
=====================

Actually
========

janitoo_base
------------

Build from https://github.com/bibi21000/janitoo

The core image

janitoo
-------

Build from https://github.com/bibi21000/janitoo_docker

The full image with third party modules


janitoo_stable
--------------

Build from https://github.com/bibi21000/janitoo_docker_tests

The stable image with coverage check


Future
======

janitoo_base
------------

Build from https://github.com/bibi21000/janitoo

The core image

 - mosquitto
 - nginx
 - mysql
 - gogs
 - + janitoo core modules


janitoo (janitoo_base)
----------------------

The full image of janitoo.

Build from https://github.com/bibi21000/janitoo_docker

The janitoo_base image + :

 - third party modules


janitoo_stable (janitoo)
----------------------

The image for docker hub.

Build from https://github.com/bibi21000/janitoo_docker_hub

The janitoo image + :

 - ...

janitoo_tests (janitoo)
-----------------------

Build from https://github.com/bibi21000/janitoo_docker_tests


The janitoo image + :

 - postgresql modules

Launch tests-all


Docker operations
=================

- create data volume

 - init git server

We also need to update the depency_links in all setup.py to set it to te docker IP (or name)

Scripts
=======

For each service, we must be abble to install

 - cron
 - supervisor
 - logrotate

#!/bin/bash
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
cd /root/glances
#git pull origin develop
#You must loop here
nice -n 19 python -m glances
/root/shutdown.sh

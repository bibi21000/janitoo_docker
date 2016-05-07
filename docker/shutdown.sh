#!/bin/bash
echo "Halting ..."
killall supervisord
echo "Waiting for shutdown for 10 seconds ..."
[ `ps aux|wc -l` -le 5 ] || sleep 10
ps aux
echo "Killing main process ..."
killall python 2>/dev/null
killall uwsgi 2>/dev/null
killall ssshd 2>/dev/null
echo "Waiting for shutdown for 10 seconds ..."
[ `ps aux|wc -l` -le 5 ] || sleep 10
ps aux
echo "Waiting for shutdown for 5 seconds ..."
[ `ps aux|wc -l` -le 5 ] || sleep 5
ps aux
echo "Waiting for shutdown for 5 seconds ..."
[ `ps aux|wc -l` -le 5 ] || sleep 5
ps aux

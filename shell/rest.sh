#!/usr/bin/sh
# Author: LastAvengers@outlook.com
# Date: 2015-9-12
# Dependency: libnotify (xfce4-notifyd)

while [ true ]; do
    sleep 40m
    notify-send '该休息了' \
                '你已经连续对着屏幕 40 分钟了... :(' \
                --icon=dialog-information
done

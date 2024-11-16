#!/bin/bash

cp -f Contents/E16-FanControl /usr/bin
cp -f Contents/E16-FanControl /usr/local/sbin/E16-FanControl
cp -f Contents/e16-fancontrol.service /etc/systemd/system/e16-fancontrol.service
systemctl daemon-reload


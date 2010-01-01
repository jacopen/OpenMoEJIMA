#!/bin/bash

NADOKA_DIR=/usr/local/nadoka

cp -R moejimabot.nb $NADOKA_DIR/plugins/
nadoka_pid=`ps aux | grep nadoka | egrep -v grep | awk '{print \$2}'`
kill -9 $nadoka_pid
cd $NADOKA_DIR
$NADOKA_DIR/moejima.sh

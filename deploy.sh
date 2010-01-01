#!/bin/bash

NADOKA_DIR=/usr/local/nadoka

cp -R moejimabot.nb $NADOKA_DIR/plugins/
nadoka_pid=`ps aux | grep nadoka | egrep -v grep | awk '{print \$2}'`
kill -9 $nadoka_pid
cd $NADOKA_DIR
ruby $NADOKA_DIR/nadoka.rb --r $NADOKA_DIR/nadoka_config_main & 
#$NADOKA_DIR/moejima.sh

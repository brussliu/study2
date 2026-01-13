#!/bin/sh
JDK=/opt/java/openjdk/bin
TOMCAT=/usr/local/tomcat
export WEBHOME=$TOMCAT/webapps/study2
export PROPERTIES=$WEBHOME/WEB-INF/classes/batch.properties
export CLASSPATH=$WEBHOME/WEB-INF/classes:$WEBHOME/WEB-INF/lib/*:$TOMCAT/lib/*

$JDK/java efw.efwBatch "{\"eventId\":\"aiBatch03\",\"params\":{}}" >> $TOMCAT/logs/study2/batchlog/aiBatch03_$(date +%Y%m%d).log 2>&1

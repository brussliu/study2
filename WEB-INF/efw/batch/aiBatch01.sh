#!/bin/sh
JDK=/opt/java/openjdk/bin
TOMCAT=/usr/local/tomcat
export WEBHOME=$TOMCAT/webapps/study2
export PROPERTIES=$WEBHOME/WEB-INF/classes/batch.properties
export CLASSPATH=$WEBHOME/WEB-INF/classes:$WEBHOME/WEB-INF/lib/*:$TOMCAT/lib/*

$JDK/java efw.efwBatch "{\"eventId\":\"aiBatch01\",\"params\":{}}" >> $TOMCAT/logs/batchlog/aiBatch01_$(date +%Y%m%d-%H%M).log 2>&1

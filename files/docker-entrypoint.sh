#!/bin/bash

if [ -n "${DEBUG}" ] && [ $DEBUG == "true" ]; then
  set -x
fi


cd /
##wget -P / "api.${HDFS_SERVICE_NAME}.marathon.l4lb.thisdcos.directory:80/v1/endpoints/core-site.xml" >>/configure-hdfs.log 2>&1
##wget -P / "api.${HDFS_SERVICE_NAME}.marathon.l4lb.thisdcos.directory:80/v1/endpoints/hdfs-site.xml" >>/configure-hdfs.log 2>&1
cp /core-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1
cp /hdfs-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1



### get secrets from vault, etc, etc...


### customize /etc/hosts in order to resolv hostnames

##############################  just for testing with vagrant in localhost 
hostip=$(ip route show | awk '/default/ {print $3}')
cp /etc/hosts ~/hosts.new
echo "$hostip  hdfs1.labs.stratio.com" >> /etc/hosts
echo "$hostip  hdfs2.labs.stratio.com" >> /etc/hosts

kinit -kt /hadoop/etc/hadoop/PERFORMANCE.STRATIO.COM.keytab hdfs/hdfs1.labs.stratio.com@PERFORMANCE.STRATIO.COM
##############################  just for testing with vagrant in localhost 

tail -f /dev/null
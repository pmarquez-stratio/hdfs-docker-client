#!/bin/bash

if [ -n "${DEBUG}" ] && [ $DEBUG == "true" ]; then
  set -x
fi

if [ -n "${DCOS_ENVIRONMENT}" ] && [ $DCOS_ENVIRONMENT == "true" ]; then

	cp /etc/hosts ~/hosts.new
	echo "$HOSTNAME_NAMENODE_0 name-0-node.hdfsstratio.mesos" >> /etc/hosts
	echo "$HOSTNAME_NAMENODE_1 name-1-node.hdfsstratio.mesos" >> /etc/hosts

	## get hdfs configuration via WEBHDFS
	curl name-0-node.hdfsstratio.mesos:$PORT_NAMENODE/conf >> /conf.xml

	egrep '<\?xml|<configuration>|</configuration>|<source>core-site.xml</source>|<source>programatically</source>' /conf.xml | sed 's/<source>core-site\.xml<\/source>//g;s/<source>programatically<\/source>//g' > /core-site.xml
	egrep '<\?xml|<configuration>|</configuration>|<source>hdfs-site.xml</source>|<source>programatically</source>' /conf.xml | sed 's/<source>hdfs-site\.xml<\/source>//g;s/<source>programatically<\/source>//g' > /hdfs-site.xml

    ## get myClusterHDFS name from hdfs-site.xml and configure fs.defaultFS for HA mode
	###myClusterHDFS=$(grep dfs.nameservices /hdfs-site.xml | sed 's/.*<value>//;s/<\/value>.*//')
	###sed -i "s/<name>fs.defaultFS<\/name><value>.*<\/value>/<name>fs.defaultFS<\/name><value>$myClusterHDFS<\/value>/" /hdfs-site.xml

	cp /core-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1
	cp /hdfs-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1

else

	cd /
	##wget -P / "api.${HDFS_SERVICE_NAME}.marathon.l4lb.thisdcos.directory:80/v1/endpoints/core-site.xml" >>/configure-hdfs.log 2>&1
	##wget -P / "api.${HDFS_SERVICE_NAME}.marathon.l4lb.thisdcos.directory:80/v1/endpoints/hdfs-site.xml" >>/configure-hdfs.log 2>&1

	## just copy hdfs-site.xml and core-site.xml from docker configuration
	cp /core-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1
	cp /hdfs-site.xml /hadoop-$HADOOP_VERSION/etc/hadoop >>/configure-hdfs.log 2>&1

	### get secrets from vault, etc, etc...

	### customize /etc/hosts in order to resolv hostnames

	##############################  
	##############################  just for testing with vagrant in localhost 
	##############################  
	hostip=$(ip route show | awk '/default/ {print $3}')
	cp /etc/hosts ~/hosts.new
	echo "$hostip  hdfs1.labs.stratio.com" >> /etc/hosts
	echo "$hostip  hdfs2.labs.stratio.com" >> /etc/hosts

	kinit -kt /hadoop/etc/hadoop/PERFORMANCE.STRATIO.COM.keytab hdfs/hdfs1.labs.stratio.com@PERFORMANCE.STRATIO.COM
	##############################  just for testing with vagrant in localhost 
fi

tail -f /dev/null
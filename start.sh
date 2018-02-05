#!/bin/bash

docker kill hdfs-client > /dev/null 2>&1
docker rm hdfs-client > /dev/null 2>&1

docker build -t stratio/hdfs-docker-client:0.1.0 .

##docker run --name hdfs-client --detach stratio/hdfs-docker-client:0.1.0

docker run -e DCOS_ENVIRONMENT='true' \
-e HOSTNAME_NAMENODE_0=10.200.0.58 \
-e HOSTNAME_NAMENODE_1=10.200.0.60 \
-e PORT_NAMENODE=9002 \
--name hdfs-client --detach stratio/hdfs-docker-client:0.1.0


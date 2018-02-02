#!/bin/bash

docker kill hdfs-client > /dev/null 2>&1
docker rm hdfs-client > /dev/null 2>&1

docker build -t stratio/hdfs-docker-client:0.1.0 .

docker run --name hdfs-client --detach stratio/hdfs-docker-client:0.1.0


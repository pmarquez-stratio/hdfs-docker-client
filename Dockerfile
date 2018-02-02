
# HDFS dockerfile

FROM qa.stratio.com/stratio/ubuntu-base:16.04

ENV HADOOP_VERSION 2.7.2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y default-jre && \    
    apt-get install -y dnsutils && \
    apt-get install -y krb5-user

RUN wget http://thirdparties.repository.stratio.com/hdfsstratio/hadoop-"$HADOOP_VERSION".tar.gz && \
    tar xf hadoop-"$HADOOP_VERSION".tar.gz && \
    rm hadoop-"$HADOOP_VERSION".tar.gz  && \
    ln -s /hadoop-$HADOOP_VERSION /hadoop

# Add entrypoint and make it executable
ENV JAVA_HOME /usr/lib/jvm/default-java
ADD files/docker-entrypoint.sh /docker-entrypoint.sh
ADD files/core-site.xml /core-site.xml
ADD files/hdfs-site.xml /hdfs-site.xml
ADD files/krb5.conf /etc/krb5.conf
ADD files/PERFORMANCE.STRATIO.COM.keytab /hadoop-$HADOOP_VERSION/etc/hadoop/PERFORMANCE.STRATIO.COM.keytab
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

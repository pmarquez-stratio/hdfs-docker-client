## HDFS client docker image

### What can I find in this repo?

In this repo you can find the sources to build a simple HDFS client docker image.

In future releases specific keytabs and krb5.conf could be configured in order to connect a hdfs cluster via hdfs binaries or webhdfs REST API

1. Connection via hadoop binaries:

  docker exec -ti hdfs-client /hadoop/bin/hdfs dfs -ls /
  Found 2 items
  drwxr-xr-x   - hdfs supergroup          0 2018-01-29 09:41 /tmp
  drwxr-xr-x   - hdfs supergroup          0 2018-01-29 09:40 /user


2. Connection to webhdfs via curl:
 
  docker exec -ti hdfs-client curl -k -i -u:hdfs/hdfs1.labs.stratio.com --negotiate "https://hdfs1.labs.stratio.com:50471/webhdfs/v1/user?op=LISTSTATUS"
  HTTP/1.1 401 Authentication required
  Cache-Control: must-revalidate,no-cache,no-store
  Date: Fri, 02 Feb 2018 14:03:22 GMT
  Pragma: no-cache
  Date: Fri, 02 Feb 2018 14:03:22 GMT
  Pragma: no-cache
  Content-Type: text/html; charset=iso-8859-1
  WWW-Authenticate: Negotiate
  Set-Cookie: hadoop.auth=; Path=/; Expires=Thu, 01-Jan-1970 00:00:00 GMT; Secure; HttpOnly
  Content-Length: 1408
  Server: Jetty(6.1.26)

  HTTP/1.1 200 OK
  Cache-Control: no-cache
  Expires: Fri, 02 Feb 2018 14:03:22 GMT
  Date: Fri, 02 Feb 2018 14:03:22 GMT
  Pragma: no-cache
  Expires: Fri, 02 Feb 2018 14:03:22 GMT
  Date: Fri, 02 Feb 2018 14:03:22 GMT
  Pragma: no-cache
  Content-Type: application/json
  WWW-Authenticate: Negotiate oYH1MIHyoAMKAQChCwYJKoZIhvcSAQICom4EbGBqBgkqhkiG9xIBAgICAG9bMFmgAwIBBaEDAgEPok0wS6ADAgESokQEQioiO9CVf2IQBpNWwXJ75kwnHpsZ3Kb/+ewkVgqnNFOEuaUfvlysfb4tl+fFHt/WcNFfFRZ5xCqYWHhIQdgRxlQN4qNuBGxgagYJKoZIhvcSAQICAgBvWzBZoAMCAQWhAwIBD6JNMEugAwIBEqJEBEIqIjvQlX9iEAaTVsFye+ZMJx6bGdym//nsJFYKpzRThLmlH75crH2+LZfnxR7f1nDRXxUWecQqmFh4SEHYEcZUDeI=
  Set-Cookie: hadoop.auth="u=hdfs&p=hdfs/hdfs1.labs.stratio.com@PERFORMANCE.STRATIO.COM&t=kerberos&e=1517616202298&s=8ufAfULHJek9UwswmB62hZin8dU="; Path=/; Expires=Sat, 03-Feb-2018 00:03:22 GMT; Secure; HttpOnly
  Transfer-Encoding: chunked
  Server: Jetty(6.1.26)

  {"FileStatuses":{"FileStatus":[
  {"accessTime":0,"blockSize":0,"childrenNum":0,"fileId":16388,"group":"supergroup","length":0,"modificationTime":1517218857625,"owner":"hdfs","pathSuffix":"datio","permission":"755","replication":0,"storagePolicy":0,"type":"DIRECTORY"},
  {"accessTime":0,"blockSize":0,"childrenNum":0,"fileId":16387,"group":"supergroup","length":0,"modificationTime":1517218853959,"owner":"hdfs","pathSuffix":"stratio","permission":"755","replication":0,"storagePolicy":0,"type":"DIRECTORY"}
]}}

### How can I build this Image?

To build the image execute this command:

       docker build -t <image_name> <parent_folder>/hdfs-docker-client/

       ex: docker build -t stratio:hdfs-docker-client:0.1.0 .
       
### How can I run this container?

To run the image execute "start.sh":

       docker run --name hdfs-client --detach stratio/hdfs-docker-client:0.1.0


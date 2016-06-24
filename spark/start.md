Spark起步
==============

Documentation
------------------------------------------

http://spark.apache.org

Install
----------------------------------------------

```shell
# 简单起见，下载一个已经编译过的版本，否则要用maven自己编译，不建议初学者这样
# For Mac OS: ftp http://ftp.cuhk.edu.hk/pub/packages/apache.org/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz

tar -xf spark-1.6.1-bin-hadoop2.6.tgz
cd spark-1.6.1-bin-hadoop2.6
```

map, reduce, filter, lambda
-------------------------------------------

http://blog.sina.com.cn/s/blog_6dbaeb9b0101dzle.html

sortByKey
-------------------------------------------
sortByKey(true) # ascending
sortByKey(true) # descending

examples
--------------------------------------------

```shell
# ./bin/run-example SparkPi 10

/Users/kun.liu/Documents/other_projects/spark-1.6.1-bin-hadoop2.6/bin/spark-submit \
  --master local[*] \
  --class org.apache.spark.examples.SparkPi /Users/kun.liu/Documents/other_projects/spark-1.6.1-bin-hadoop2.6/lib/spark-examples-1.6.1-hadoop2.6.0.jar 10

```

sbt--build scala
---------------------------------------------

https://github.com/CSUG/real_world_scala/blob/master/02_sbt.markdown

simple-start
--------------------------------------------------

```shell
# Use spark-submit to run your application
$ YOUR_SPARK_HOME/bin/spark-submit \
  --class "SimpleApp" \
    --master local[4] \
      target/scala-2.10/simple-project_2.10-1.0.jar
```

设置环境变量
--------------------------------------------

http://www.powerxing.com/linux-environment-variable/

Kafka系列-1-Kafka基本介绍
------------------------------------------

# Kafka是什么？
Kafka是一个分布式的流处理平台；用Scala和Java编写；是Apache的开源项目。

Kafka官网: https://kafka.apache.org/

主要特性：发布和订阅、处理、存储

# 设计目标
- 以时间复杂度为O(1)的方式提供消息持久化能力，即使对TB级以上数据也能保证常数时间复杂度的访问性能。
- 高吞吐率，即使在非常廉价的商用机器上也能做到单机支持每秒100K条以上消息的传输。
- 支持Kafka Server间的消息分区，及分布式消费，同时保证每个Partition内的消息顺序传输。
- 同时支持离线数据处理和实时数据处理。
- Scale out：支持在线水平扩展。

# 核心API
- The Producer API
- The Consumer API
- The Streams API
- The Connector API

# 哪些公司在用？
来自世界各地的数千家公司在使用 Kafka，包括三分之一的500强公司。

- LinkedIn
- Yahoo
- Twitter
- Netflix
- Square
- Spotify
- 更多: https://cwiki.apache.org/confluence/display/KAFKA/Powered+By

# 历史
- Kafka最初是由LinkedIn开发
- 2011年初由LinkedIn开源
- 2012年10月，由Apache Incubator孵化出站
- 2014年11月，几个曾在领英为Kafka工作的工程师，创建Confluent公司，并着眼于Kafka
- 2017年11月，Kafka 1.0.0 发布

# Confluent公司简介
Confluent 的产品叫作 Confluent Platform。这个产品的核心是 Kafka，分为三个版本：
- Confluent Open Source（Kafka增强版，Rest代理，语言支持，hadoop、AWS S3、JDBC等的连接的支持，Schema Registry）
- Confluent Enterprise （Confluent Control Center 非开源产品，对整个产品进行管理的控制中心，最主要的功能对这个 Kafka 里面各个生产者和消费者的性能监控）
- Confluent Cloud（Confluent Enterprise 的云端托管服务，它增加了一个叫作云端管理控制台的组件）


Confluent 的基本做法和 Cloudera 很像，主要的产品开源，但是控制中心这样的东西不开源，只有买了企业版才能够享受到。而两者不同的地方主要在于，Confluent 同时提供了云端服务的版本。加上 Confluent 有基于 S3 的连接，这使得从亚马逊 AWS 读写数据都非常方便。

和 Cloudera 是 Hadoop 的集成商不同，Confluent 主要还是围绕着不同数据源之间数据的交换这个任务而生的服务。Kafka 在整个开源产品里面是一个非常特殊的存在，它没有什么竞争对手，又是各大企业的刚需，它在脱离了整个 Hadoop 生态圈以后依然非常有价值。

# 参考资料
- https://kafka.apache.org/
- https://kafka.apache.org/intro
- http://www.10tiao.com/html/46/201711/2650998759/1.html
- https://cwiki.apache.org/confluence/display/KAFKA/Index
- http://www.infoq.com/cn/articles/kafka-analysis-part-1
- http://mp.weixin.qq.com/s/5WesHzHrtuMGkXKKqugc9Q
- https://www.confluent.io/

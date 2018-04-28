Kafka系列-2-常用消息系统简单对比
------------------------------------------

# 为什么需要使用消息系统？
- 解耦
- 冗余
- 扩展性
- 灵活性 & 峰值处理能力
- 可恢复性
- 顺序保证
- 缓冲
- 异步通信

### 冗余
有些情况下，处理数据的过程会失败。除非数据被持久化，否则将造成丢失。消息队列把数据进行持久化直到它们已经被完全处理，通过这一方式规避了数据丢失风险。许多消息队列所采用的”插入-获取-删除"范式中，在把一个消息从队列中删除之前，需要你的处理系统明确的指出该消息已经被处理完毕，从而确保你的数据被安全的保存直到你使用完毕。

### 扩展性
因为消息队列解耦了你的处理过程，所以增大消息入队和处理的频率是很容易的，只要另外增加处理过程即可。

# 常用Message Queue
- RabbitMQ
- Redis
- ZeroMQ
- ActiveMQ
- Kafka
- RocketMQ

### 分析
- Apache Kafka相对于ActiveMQ是一个非常轻量级的消息系统，除了性能非常好之外，还是一个工作良好的分布式系统。
- Redis 虽然它是一个Key-Value数据库存储系统，但它本身支持MQ功能，所以完全可以当做一个轻量级的队列服务来使用。对于RabbitMQ和Redis的入队和出队操作，各执行100万次，每10万次记录一次执行时间。测试数据分为128Bytes、512Bytes、1K和10K四个不同大小的数据。实验表明：入队时，当数据比较小时Redis的性能要高于RabbitMQ，而如果数据大小超过了10K，Redis则慢的无法忍受；出队时，无论数据大小，Redis都表现出非常好的性能，而RabbitMQ的出队性能则远低于Redis。
- ZeroMQ（用C语言写的）号称最快的消息队列系统，尤其针对大吞吐量的需求场景。ZeroMQ能够实现RabbitMQ不擅长的高级/复杂的队列，但是开发人员需要自己组合多种技术框架，技术上的复杂度是对这MQ能够应用成功的挑战。但是ZeroMQ仅提供非持久性的队列，也就是说如果宕机，数据将会丢失。其中，Twitter的Storm 0.9.0以前的版本中默认使用ZeroMQ作为数据流的传输（Storm从0.9版本开始同时支持ZeroMQ和Netty作为传输模块，默认用Netty，原因：ZMQ不易部署，无法限制内存，Storm无法从ZMQ获取信息）。


# Kafka、RabbitMQ、RocketMQ 消息发送性能对比
- Kafka的吞吐量高达17.3w/s，不愧是高吞吐量消息中间件的行业老大。这主要取决于它的队列模式保证了写磁盘的过程是线性IO。
- RocketMQ也表现不俗，吞吐量在11.6w/s，磁盘IO %util已接近100%。RocketMQ的消息写入内存后即返回ack，由单独的线程专门做刷盘的操作，所有的消息均是顺序写文件。
- RabbitMQ的吞吐量5.95w/s，CPU资源消耗较高。它支持AMQP协议，实现非常重量级，为了保证消息的可靠性在吞吐量上做了取舍。我们还做了RabbitMQ在消息持久化场景下的性能测试，吞吐量在2.6w/s左右。

# Kafka VS RabibitMQ

评测项	    | 评测结果        
----------- | ----------------
开源许可证	| Kafka > RabbitMQ
行业认可度	| Kafka = RabbitMQ
产品活跃度	| Kafka > RabbitMQ
服务支持	| Kafka = RabbitMQ
功能	    | Kafka < RabbitMQ
性能	    | Kafka > RabbitMQ
安全性	    | Kafka > RabbitMQ
可扩展性	| Kafka > RabbitMQ
可靠性	    | Kafka = RabbitMQ
其他特性	| Kafka = RabbitMQ


总体来说，分布式消息中间件Kafka和RabbitMQ在行业认可、服务支持、可靠性、可维护性、兼容性、易用性等方面各有特色。

Kafka在开源许可证、产品活跃度、性能、安全性、可扩展性等方面优于RabbitMQ，Kafka采用的许可证更宽松，活跃度更高，性能远高于RabbitMQ，在安全性和可扩展性方面能够提供更好的保障。

Kafka仅在功能上略少于RabbitMQ，但是已经具备了主要的功能。

综合上述所有评测结果，建议企业在应用过程中优先选择Kafka。

# Kafka VS RocketMQ

- 都支持：严格的消息顺序、消息回溯（RocketMQ支持按照时间回溯）
- 性能对比：Kafka > RocketMQ（单机TPS百万 VS 7万）
- 消息堆积能力：Kafka > RocketMQ
- Kafka不支持，RocketMQ支持：定时消息、消息查询（根据消息标识／内容）、消息轨迹、代理端消息过滤
- 消息并行度：顺序消费方式两者相同，并行度和分区数一致；RocketMQ还支持的乱序方式，并行度取决于Consumer的线程数，可以比前者更高
- 其他：单机支持的队列数，数据可靠性，消息投递实时性，消费失败重试，分布式事务消息，开源社区活跃度, 开发语言友好性(RocketMQ用Java编写)
- “理论上Kafka要比RocketMQ的堆积能力更强，不过RocketMQ单机也可以支持亿级的消息堆积能力，我们认为这个堆积能力已经完全可以满足业务需求。”

# Kafka VS 微信开源PhxQueue

未整理，可以参考： http://mp.weixin.qq.com/s/YFMFCijamQvz_O-MPv5yfA


# 参考资料
- http://www.infoq.com/cn/articles/kafka-analysis-part-1
- http://blog.csdn.net/gobravery/article/details/71123425
- http://jm.taobao.org/2016/04/01/kafka-vs-rabbitmq-vs-rocketmq-message-send-performance/
- http://www.infoq.com/cn/articles/evaluation-distributed-messaging-middleware?utm_source=articles_about_Kafka&utm_medium=link&utm_campaign=Kafka
- http://jm.taobao.org/2016/04/01/kafka-vs-rabbitmq-vs-rocketmq-message-send-performance/
- https://yq.aliyun.com/articles/73165
- http://jm.taobao.org/2016/03/24/rmq-vs-kafka/
- https://fdx321.github.io/2018/01/03/Kafka-Vs-RocketMQ/
- http://mp.weixin.qq.com/s/YFMFCijamQvz_O-MPv5yfA

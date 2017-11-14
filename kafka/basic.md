Kafka简介
------------------------------------------------


Consumer Group
消息状态，broker维护offset
消息持久化，消息有效期
批量发送机制
push and pull， producer和consumer两者对消息的生产和消费都是异步的，同步异步：异步push，以提高吞吐率

分区机制（partition），Producer可以决定把消息发送到哪个分区；同一个分区中的消息保序

partition数量应该大于consumer的数量，因为一个partition只能被一个消费者消费；
partition数量应该大于集群broker数量。

Batch的方式推送数据；将消息在内存中累积到一定数量后作为一个batch发送请求。

producer发送消息后响应，其中有个acks，设为0可以得到最大的吞吐量；
设为1可以得到1个broker确认；
设为－1则要求得到所有broker确认，可以得到最高的可靠性保证。

consumer可以重设offset

consumers用同一个组名，则kafka相当于队列消息服务；用不同组名，则kafka相当于广播服务。


OpenTracing介绍
------------------------------------------

# 为什么需要跟踪(Tracing)？
开发和工程组织因为系统组件独立水平扩展、开发团队保持小而敏捷、部署可以持续和解藕（持续集成和部署）等多种不可抗力因素，正在使用现代微服务架构替换老旧的单机系统。 也就是说，当一个生产系统面临真正的高并发，或者分解成大量微服务时，以前很容易实现的重点任务变得困难了：用户延时体验优化、后台错误根本原因分析、现在分布式系统内不同组件的通信情况等。当代分布式跟踪系统（例如，Zipkin, Dapper, HTrace, X-Trace，等等）旨在解决以上这些问题，但是他们通过在应用程序层面的植入，使用不兼容的API来达到该效果。尽管这些不同的分布式追踪系统有着非常相似的API语法，但是开发者们还是不容易将他们的不同语言的多个系统紧紧连接到任何一个特定的分布式跟踪检测系统。

# 为什么需要OpenTracing？
OpenTracing通过提供平台无关、厂商无关的API，使得开发人员能够方便的添加（或更换）追踪系统的实现。 OpenTracing提供了用于运营支撑系统的和针对特定平台的辅助程序库。程序库的具体信息请参考详细的规范。

# 什么是一个Trace?
在广义上，一个trace代表了一个事务或者流程在（分布式）系统中的执行过程。在OpenTracing标准中，trace是多个span组成的一个有向无环图（DAG），每一个span代表trace中被命名并计时的连续性的执行片段。

![trace](https://wu-sheng.gitbooks.io/opentracing-io/content/images/OTOV_0.png)

分布式追踪中的每个组件都包含自己的一个或者多个span。例如，在一个常规的RPC调用过程中，OpenTracing推荐在RPC的客户端和服务端，至少各有一个span，用于记录RPC调用的客户端和服务端信息。

![span](https://wu-sheng.gitbooks.io/opentracing-io/content/images/OTOV_1.png)

一个父级的span会显式的并行或者串行启动多个子span。在OpenTracing标准中，甚至允许一个子span有个多父span（例如：并行写入的缓存，可能通过一次刷新操作写入动作）。

# 一个典型的Trace案例
![](https://wu-sheng.gitbooks.io/opentracing-io/content/images/OTOV_2.png)

在一个分布式系统中，追踪一个事务或者调用流一般如上图所示。虽然这种图对于看清各组件的组合关系是很有用的，但是，它不能很好显示组件的调用时间，是串行调用还是并行调用，如果展现更复杂的调用关系，会更加复杂，甚至无法画出这样的图。另外，这种图也无法显示调用间的时间间隔以及是否通过定时调用来启动调用。一种更有效展现trace过程的方式如下图所示：

![ot](https://wu-sheng.gitbooks.io/opentracing-io/content/images/OTOV_3.png)

这种展现方式增加了执行时间的上下文，相关服务间的层次关系，进程或者任务的串行或并行调用关系。这样的视图有助于发现系统调用的关键路径。通过关注关键路径的执行过程，项目团队可以专注于优化路径中的关键位置，最大幅度的提升系统性能。例如：可以通过追踪一个资源定位的调用情况，明确底层的调用情况，发现哪些操作有阻塞的情况。

# 参考资料
http://opentracing.io/documentation/
https://github.com/opentracing/opentracing.io/blob/master/_docs/README.MD

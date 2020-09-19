Chapter 1.Container Orchestration 

# Introduction
容器运行时：runC，containerd，rkt

# Containers
利用容器镜像，我们可以打包应用极其运行时和依赖。
我们可以利用该镜像创建一个隔离的可执行环境，也叫做container。

# 什么是容器编排？
通过容器编排，达到生产环境的要求：
容错，按需伸缩，最优利用资源，自动发现服务和通信，外部访问，无缝升级/回滚

# 容器编排工具
Docker Swarm
Kubernetes
Mesos Marathon
Amazon ECS
Hashicorp Nomad

# 为什么要用Container Orchestrators?
容器编排工具可以：

聚合多个主机并让它们成为一个集群的一部分
调度容器让其运行在不同主机上
帮助同一个集群中的不同主机上的容器进行联系
绑定容器和存储
讲相似类型的容器绑定到一个高层次的结构上，比如services，这样我们就不必处理单个容器
保持资源使用处于被检查状态，并在必要时优化
允许安全的访问运行在容器内的应用

# 在哪里部署容器编排工具？
裸机，虚拟机或者云上都可以



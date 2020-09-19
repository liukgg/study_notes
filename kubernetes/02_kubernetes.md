Chapter 2.Kubernetes
------------------------------------------

# 什么是 Kubernetes?
"Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications."

也被称为 k8s

k8s受到谷歌 Borg 系统的启发

用Go语言编写，基于Apache证书2.0开源

k8s由谷歌发起，2015年6月发布v1.0，谷歌将其捐给CNCF

k8s一般每3个月发布一个新版本，当前最新版本1.11（2018.07）

# 从Borg到k8s
"Google's Borg system is a cluster manager that runs hundreds of thousands of jobs, from many thousands of different applications, across a number of clusters each with up to tens of thousands of machines."

# k8s功能特性
自动装箱
自愈
水平扩展（基于CPU、内存等，也可以给予自定义度量进行动态扩展）
服务发现和负载均衡（DNS，也叫做k8s service）

自动化滚动升级和回滚
秘钥和配置管理
存储编排（基于software-defined storage SDS，可以自动mount local，external and storage solutions）
批处理

RBAC（since 1.8）

# 为什么要用 k8s ？
高度可移植、可扩展，高度模块化、插件化的架构，非常活跃的社区



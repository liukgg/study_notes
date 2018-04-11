gRPC简介
--------------------------------------------

# gRPC是什么？
官方说法：A high performance, open-source universal RPC framework

解读：
gRPC是由Google提出的现代，开源，高效的RPC框架。

gRPC支持多种开发语言，采用http2通信协议，采用Protocol Buffers通信格式。

# 特点
- 简单的服务定义，基于Protobuf
- 支持跨语言、跨平台
- 快速启动，易于扩展
- 双向流式处理，并且集成了认证

# 官网
https://grpc.io/

https://github.com/grpc/grpc

# 目前支持的语言
C, C++, Ruby, Python, PHP, C#, Objective-C, Java, GO, NodeJS, Dart

# gRPC开发流程
![gRPC workflow](./images/workflow.png)

# Demo
## Ruby Server 和 Ruby Client
```bash
# 下载gRPC源码
$ git clone https://github.com/grpc/grpc.git

# 进入Ruby的示例目录
$ cd grpc/examples/ruby/

# 启动gRPC服务
$ ruby greeter_server.rb

# 访问服务
$ ruby greeter_client.rb
```

![ruby server](./images/ruby_server)

![ruby client](./images/ruby_client)


## Golang Server 和 Golang Client
```bash
$ go get -u google.golang.org/grpc

$ cd $GOPATH/src/google.golang.org/grpc/examples/helloworld/

$ go run greeter_server/main.go

$ go run greeter_client/main.go
```

![go server](./images/go_server)

![go client](./images/go_client)



# 快速开始
Ruby: https://grpc.io/docs/quickstart/ruby.html

Go: https://grpc.io/docs/quickstart/go.html

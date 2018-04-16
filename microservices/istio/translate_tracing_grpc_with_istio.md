基于Istio跟踪gRPC
--------------------------------------------

本文翻译自：https://aspenmesh.io/blog/2018/04/tracing-grpc-with-istio/

在Aapen Mesh我们热爱gRPC。我们面向公众的大部分API和许多内部的API是用gRPC构建的。为了给你一个简单的背景可能你还没有听说过gRPC（当然对于gRPC的声名远播而言很难没有听说过），它是一个新的、非常高效的、最优的远程过程调用（RPC）框架。它基于经过严格考验的protocol buffers序列化格式和HTTP/2网络协议。

使用HTTP/2xieyi，gRPC应用可以获益于多路请求，高效的连接利用以及相比其他协议如HTTP/1.1而言的很多增强功能，这里有详细的文档：https://http2.github.io/faq/。与此同时，protocol buffers对于序列化结构型数据而言是一种简单且可扩展的方式，它本身提供了相比基于文本的格式而言巨大的性能优化。组合HTTP2和protocol buffers这两者可以获得低延迟和高度可扩展的RPC框架，这是gRPC的本质。此外，增长中的gRPC生态让你可以用多种支持的语言（如C++，Java，Go等）来编写你的应用，并且也提供了一套可扩展的第三方库的集合。

除了以上我列出的好处之外，我最喜欢gRPC的一点是简洁性和直觉性，利用这两点你可以声明你的RPC接口（利用protobufs IDL）以及客户端应用可以如同一个本地函数调用一般来调用服务端应用的方法。大量的代码（服务描述和handlers，客户端方法等）都是自动生成的以让你使用gRPC变得非常方便。

既然我已经介绍了gRPC的一些背景，让我们回归正题。这里我打算介绍如何在基于gRPC的应用中添加tracing，特别是你在使用Istio或者Aspen Mesh。

Tracing对于调试和理解你的应用的行为来说非常棒。理解所有跟踪（tracing）数据的关键是能够关联来自不同微服务的跨度（spans），这些数据和某个客户端请求相关。

为了达成这一点，在你应用中的所有微服务应该传播tracing headers。如果你在使用一个服务网格比如Istio或者Aspen Mesh，ingress和sidecar 代理自动添加了合适的tracing headers并且将这些spans报告给Tracing收集后端服务比如Jeager或者Zipkin。留给应用要做的唯一的事情就是传播来自

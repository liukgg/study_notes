istio+golang实现tracing传递
--------------------------------------------

# 注意事项
gin.Context 和 context.Context 不完全等价，SpanFromContext无法正常获取span，需要用extract

```bash
carrier := opentracing.HTTPHeadersCarrier(c.Request.Header)
clientContext, err := global.Tracer.Extract(opentracing.HTTPHeaders, carrier)
```

关于Extract用法详见： https://godoc.org/github.com/opentracing/opentracing-go#Tracer

# 参考资料
https://aspenmesh.io/blog/2018/04/tracing-grpc-with-istio/
https://medium.com/opentracing/distributed-tracing-in-10-minutes-51b378ee40f1

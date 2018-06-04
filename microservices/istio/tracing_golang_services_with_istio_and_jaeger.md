Tracing Golang services with Istio and Jaeger
--------------------------------------------

# Introduction
I have a simple project, which is composed of two services: a web HTTP service named "A" and a gRPC
service named "B".The web servicd A can accept HTTP request from a browser, and then it calls the gRPC service B by grpc.So the workflow looks like this:

```
                         HTTP      gRPC
Browser(such as Chrome)-------->A-------->B
```

Since I deploy these two services A and B in kubernetes with istio, so the actual workflow is:

```
Browser---->istio-ingress---->istio-sidecar-for-A---->A---->istio-sidecar-for-A---->istio-sidecar-for-B---->B
```

And There will be 6 spans in Jaeger without your own custom spans when you propagate it properly.

![jaeger spans](./images/istio-jaeger-propagate)

# How to do it
You can have a look at the guides from istio, but there is no golang example.
https://istio.io/docs/tasks/telemetry/distributed-tracing.html

istio uses zipkin style B3 HTTP Header to propagate tracing data.

You can see sth like this in the HTTP Header passed from istio sidecar to your server:

```shell
Host: example.com
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: zh-cn
Content-Length: 0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15
X-Amzn-Trace-Id: Root=1-5ae98c41-51a404d4c40f4bcc2ff5a80c
[GIN] 2018/05/02 - 10:00:33 | 500 |     331.165µs |   14.18.248.138 |  GET     /su
X-B3-Sampled: 1
X-B3-Spanid: f50d3cd1cda25ca9
X-B3-Traceid: f50d3cd1cda25ca9
X-Consumer-Id: 2d441dda-ecff-48e1-9e96-5d564ed20bcf
X-Consumer-Username: jaeger
X-Credential-Username: jaeger-stag
X-Envoy-External-Address: 192.168.5.11
X-Forwarded-For: 14.18.248.138, 192.168.5.1, 192.168.5.11
X-Forwarded-Host: example.com
X-Forwarded-Port: 8000
X-Forwarded-Proto: http
X-Real-Ip: 192.168.5.1
X-Request-Id: 282de525-440a-96e3-a21f-c8eacab701f7
```


Use curl to mock a request with a tracing span:

```bash
curl http://localhost:8888/su?url=http://baidu.com -H "x-request-id:282de525-440a-96e3-a21f-c8eacab701f7" -H "x-b3-traceid:f50d3cd1cda25ca9" -H "x-b3-spanid:f50d3cd1cda25ca9" -H "x-b3-sampled:1"
```

# Code

```go
package main

import (
	"os"
)

import (
	"time"

	opentracing "github.com/opentracing/opentracing-go"
	"github.com/uber/jaeger-client-go"
	jaegerClientConfig "github.com/uber/jaeger-client-go/config"
	"github.com/uber/jaeger-client-go/zipkin"
)

const (
	serviceName       = "test-app"
	hostPort          = ":2018"
	defaultTracingURL = "localhost:6831"
)

func main() {
	tracingURL := os.Getenv("TRACING_SERVER_URL")
	if tracingURL == "" {
		tracingURL = defaultTracingURL
	}

	tracer = NewJaegerTracer(tracingURL, serviceName, hostPort)

    opentracing.SetGlobalTracer(tracer)
}

// A simple example with web framework gin
func sayHello(c *gin.Context) {
	var ctx context.Context

	if global.Tracer != nil {
		carrier := opentracing.HTTPHeadersCarrier(c.Request.Header)
		clientContext, err := global.Tracer.Extract(opentracing.HTTPHeaders, carrier)

		fmt.Println(carrier)

		var span opentracing.Span
		if err == nil {
			span = global.Tracer.StartSpan(
				"web span", ext.RPCServerOption(clientContext))
		} else {
			fmt.Println("Span Error!!!")
			span = global.Tracer.StartSpan("Web span as root")
		}

		//defer span.Finish()

		ctx = opentracing.ContextWithSpan(c, span)
	} else {
		ctx = context.Background()
	}

	longURL := c.Query("url")

    // gRPC call
	r, err := client.HelloworldClient.SayHello(ctx, &client.Request{name: "liukgg"})

	tmpURL := ""
	if err != nil {
		log.Printf("Say hello failed: %v", err)
	} else {
		log.Println("Success!)
	}

	c.HTML(http.StatusOK, "index.tmpl", gin.H{
		"title": "Hello, world!",
	})
}

func NewJaegerTracer(tracingURL string, serviceName string, hostPort string) opentracing.Tracer {
	cfg := jaegerClientConfig.Configuration{
		Sampler: &jaegerClientConfig.SamplerConfig{
			Type:  "const",
			Param: 1,
		},
		Reporter: &jaegerClientConfig.ReporterConfig{
			LogSpans:            true,
			BufferFlushInterval: 1 * time.Second,
			LocalAgentHostPort:  tracingURL,
		},
	}

	zipkinPropagator := zipkin.NewZipkinB3HTTPHeaderPropagator()

	tracer, _, _ := cfg.New(
		serviceName,
		jaegerClientConfig.Logger(jaeger.StdLogger),
		jaegerClientConfig.Injector(opentracing.HTTPHeaders, zipkinPropagator),
		jaegerClientConfig.Extractor(opentracing.HTTPHeaders, zipkinPropagator),
		jaegerClientConfig.ZipkinSharedRPCSpan(true),
	)

	opentracing.SetGlobalTracer(tracer)

	return tracer
}

// 由于jaeger和zipkin依赖的thrift版本冲突，导致无法同时支持两者
//import (
//	"fmt"
//	opentracing "github.com/opentracing/opentracing-go"
//	zipkin "github.com/openzipkin/zipkin-go-opentracing"
//)
//
//// 为Opentracing设置 tracer, Tracing 目前用zipkin
////
//// Example for parameters:
//// zipkinHTTPEndpoint = "http://localhost:9411/api/v1/spans"
//// serviceName        = "pango_utils_server"
//// hostPort           = ":2018"
//func NewTracer(zipkinHTTPEndpoint, serviceName string, hostPort string) opentracing.Tracer {
//	debug, sameSpan, traceID128Bit := false, true, true
//
//	collector, err := zipkin.NewHTTPCollector(zipkinHTTPEndpoint)
//	if err != nil {
//		fmt.Printf("unable to create Zipkin packageHTTP collector: %+v\n", err)
//		return nil
//	}
//
//	recorder := zipkin.NewRecorder(collector, debug, hostPort, serviceName)
//
//	tracer, err := zipkin.NewTracer(
//		recorder,
//		zipkin.ClientServerSameSpan(sameSpan),
//		zipkin.TraceID128Bit(traceID128Bit),
//	)
//	if err != nil {
//		fmt.Printf("unable to create Zipkin tracer: %+v\n", err)
//		return nil
//	} else {
//		fmt.Println("create Zipkin tracer successfully!")
//	}
//
//	// 设置tracer 为 opentracing 的默认tracer
//	opentracing.InitGlobalTracer(tracer)
//
//	return tracer
//}
```

# References
- Jaeger's zipkin B3 propagator: https://github.com/jaegertracing/jaeger-client-go/blob/master/zipkin/README.md
- Related Jaeger issue: https://github.com/jaegertracing/jaeger-client-go/issues/70
- Jaeger godoc for how to init a tracer: https://godoc.org/github.com/uber/jaeger-client-go/config#example-Configuration-InitGlobalTracer-Production
- jaeger started guide: https://www.jaegertracing.io/docs/getting-started/
- istio simple example: https://istio.io/docs/tasks/telemetry/distributed-tracing.html
- a blog:  https://medium.com/opentracing/tracing-http-request-latency-in-go-with-opentracing-7cc1282a100a
- opentracing doc: http://opentracing.io/documentation/pages/instrumentation/common-use-cases.html
- opentracing godoc: https://godoc.org/github.com/opentracing/opentracing-go#ChildOf
- Jaeger source code: https://github.com/dszakallas/jaeger-client-go-http-b3-propagation/blob/master/propagation.go

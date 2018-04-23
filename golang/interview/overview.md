
# 试题集
https://github.com/goquiz/goquiz.github.io

# goroutine & channel 基本应用考察
### 交替打印数字和字母
https://github.com/lifei6671/interview-go/blob/master/question/q001.md

使用两个 goroutine 交替打印序列，一个 goroutinue 打印数字， 另外一个 goroutine 打印字母， 最终效果如下 12AB34CD56EF78GH910IJ 。

解题思路：

问题很简单，使用 channel 来控制打印的进度。使用两个 channel ，来分别控制数字和字母的打印序列， 数字打印完成后通过 channel 通知字母打印, 字母打印完成后通知数字打印，然后周而复始的工作。

// sync.WaitGroup官方godoc示例
```go
var wg sync.WaitGroup
var urls = []string{
        "http://www.golang.org/",
        "http://www.google.com/",
        "http://www.somestupidname.com/",
}
for _, url := range urls {
        // Increment the WaitGroup counter.
        wg.Add(1)
        // Launch a goroutine to fetch the URL.
        go func(url string) {
                // Decrement the counter when the goroutine completes.
                defer wg.Done()
                // Fetch the URL.
                http.Get(url)
        }(url)
}
// Wait for all HTTP fetches to complete.
wg.Wait()
```

# goroutine并发设计模式
- https://segmentfault.com/a/1190000007111208
- concurrency vs parallelism




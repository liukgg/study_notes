The Go Programming Language
-------------------------------------------

Go程序设计语言

示例代码地址：　https://github.com/adonovan/gopl.io
一份学习笔记： https://notes.shichao.io/gopl/

# Tips
- ch1/lissajous 这个程序，运行时要将输出写到文件，即得到一个gif文件。直接输出到终端看到的是一堆乱码。

```bash
$ go build gopl.io/ch1/lissajous
$ ./lissajous >out.gif
```


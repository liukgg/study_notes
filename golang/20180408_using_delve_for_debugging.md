Golang调试工具：delve
-------------------------------------------

### 官网
https://github.com/derekparker/delve

### 安装
简单方便： go get -u github.com/derekparker/delve/cmd/dlv

也可以用别的方式安装： https://github.com/derekparker/delve/blob/master/Documentation/installation/osx/install.md

### 常见问题
在macOS 10.13.4 版本上，目前delve有bug，运行 dlv时会出现如下错误：

```bash
$ dlv debug main.go
could not launch process: EOF
```

解决方案：先删除mac的命令行工具，然后下载macOS 10.13的命令行工具。具体如下：

```bash
$ sudo rm -rf /Library/Developer/CommandLineTools
```

then go to page https://developer.apple.com/download/more/
download and install previous version

```bash
Command Line Tools (macOS 10.13) for Xcode 9.1 - Dec 6, 2017
```

该问题在github上有对应issue：https://github.com/derekparker/delve/issues/1015

### 用法
- dlv debug
- dlv test
- dlv help

详见：
https://github.com/derekparker/delve/blob/master/Documentation/usage/dlv.md

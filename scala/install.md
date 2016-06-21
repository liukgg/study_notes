
install
--------------------------------------------

https://gist.github.com/osipov/c2a34884a647c29765ed

```shell
sudo apt-get remove scala-library scala
sudo wget downloads.lightbend.com/scala/2.11.8/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb

sudo apt-get update
sudo apt-get install scala
```

### install sbt(A tool for comiling scala)

```shell
sudo apt-get install sbt

# 建议安装完 sbt之后执行一次 sbt, 因为将会获取一些包，需要较长时间(一般大于10分钟)
```

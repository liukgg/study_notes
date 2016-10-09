logrotate

注意事项！！！
长期未rotate的日志文件可能很大（比如100GB），这时如果用rotate命令，那么一定要检查硬盘空间是否够用！！！

为了使用它，主要有两个地方需要修改一下：一个是/etc/logrotate.conf，另一个是/etc/logrotate.d/下面的文件。

实例：

```ruby
/var/log/news/news.crit {
    monthly
    rotate 2
    olddir /var/log/news/old
    missingok
    postrotate
    kill -HUP ‘cat /var/run/inn.pid‘
    endscript
    nocompress
}
```

参考：

http://www.codeceo.com/article/linux-logrotate-usage.html

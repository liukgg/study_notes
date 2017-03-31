Passenger基础知识
===============================

### 参考资料
https://www.phusionpassenger.com/library/config/nginx/reference/

### 关于进程数量的配置
以下配置，和nginx配合使用时，即在nginx相关配置文件中配置，一般是 /etc/nginx/nginx.conf 和 /etc/nginx/sites-enabled/xxx.conf

```shell
passenger_max_pool_size
--该参数配置最大进程数量，优先级最高；默认值是6
--注意该参数应该在http语境下设置，不能倒server语境下去配置！

passenger_min_instances
－－该参数配置维持的最小进程数量；默认值是1

passenger_max_instances
－－默认值是0，代表不做限制

例如：
以上3个参数分别为：
不设置、20、不设置，则会一直维持6个进程（想要维持20个、但是受到第一个参数限制）；
30、20、25，则会最少维持20个进程，必要时会扩大到25个。
```

### 吞吐量优化建议
https://www.phusionpassenger.com/library/config/nginx/optimization/

计算公式；IO密集型应该尽量多进程／线程；CPU密集型不要用太多进程数量。

### 何时产生新的进程
https://www.phusionpassenger.com/library/indepth/ruby/dynamic_scaling_of_app_processes/nginx/

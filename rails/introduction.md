Rails介绍
-------------------------------------------

# 推荐学习材料
http://guides.rubyonrails.org

https://www.railstutorial.org/

https://www.amazon.cn/dp/B0791WXVBQ/ref=sr_1_1?s=books&ie=UTF8&qid=1523438492&sr=1-1&keywords=rails

# 简介
Rails是用Ruby编程语言编写的一个web应用开发框架。相比许多其他语言和框架而言，它让你可以用更少的代码实现更多的功能。

Rails的哲学包括两个主要指导原则：
- DRY：不要重复你自己
- COS：约定优于配置

# 安装Rails
```bash
# 先确认你安装了Ruby
$ ruby -v

# 确认安装了sqlite3, 这是为了后面能运行Rails的简单demo
$ sqlite3 --version

# 安装Rails
$ gem install rails

# 确认Rails安装成功了
$ rails --version
```
# 创建一个Blog应用
```bash
$ rails new log

# 启动web服务
$ bin/rails server
```
然后在浏览器打开：  http://localhost:3000

恭喜你！第一个应用已经成功运行了！

想要了解更多详情，请参考：http://guides.rubyonrails.org/getting_started.html

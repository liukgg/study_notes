Ruby面试核心问题：
1，自我介绍 ＋ 最近做过的项目以及自己在其中承担的工作
你在项目中负责哪些部分，是如何解决项目中的疑难杂症，用到了哪些技术

2，Ruby／Rails相关知识
 变量类型，一般用在哪些场景下？Ruby的命名风格？
class 和 module 的区别
Ruby的多线程
看过Ruby的源码，Ruby的代码执行过程具体会做些什么事情？
Ruby的GC机制
常用的Gem？用于解决什么问题？有看过源码吗？有没有印象深刻的代码？
知道方法名，如何判断当前对象内有该方法存在？
Rails创建测试数据库的命令？includes一般用于什么情况？
Rails的cache机制？
Rails的basics, migrations, validations, callbacks, associations, query interface，routes
Rails的启动过程
对单元测试怎么看？
用过Passenger和Puma吗？对比下优点缺点？
有给开源项目贡献过代码吗？
持续集成？

3，数据库
 熟悉什么数据库？索引机制？优缺点？
多大数据量？数据库压力如何？
慢查询优化经验？一般怎么优化？
消息队列？

4，案例分析／实际问题解决
画一个示意图（文章列表）。
1，有个功能模块，需要以天为单位，每天展示多篇文章，同一篇文章可以出现在不同的日期里，比如某篇文章在7月1日展示、同时在7月5日和7月6日也展示。
2，每篇文章包含以下内容： 标题、缩略图、简介、正文内容；进入功能模块是以天为单位展示文章，点击文章标题会进入文章详情页。
3，用户可以在每篇文章下发表观点
4，用户可以对文章下的观点点赞和取消点赞，观点要展示点赞数以及点过赞的用户。

要求：
1，针对以上功能需求设计数据库表结构，并给出关联关系。
2，对文章这个model进行代码实现（如果时间允许）

题2:算法？Ruby编程－第3方Api调用（网易易盾反垃圾？阿里云api？）－签名机制＋超时机制处理？大概会用到哪些东西？

5，其他
 离职原因？职业规划？退学原因方便说一下吗？（可以不回答）



备选题目：
Ruby面试基础：
0，面试者自我介绍，针对自我介绍及简历提问：

1，Ruby 和 Rails相关：
为何选择Ruby？而不是iOS或者别的？
怎么看待Ruby这门语言？和C、Java、Python、Golang等相比有什么优缺点？
Ruby里有哪些变量类型？对象模型？动态方法？
大致列举下用过哪些Ruby的Gem？
用过什么Ruby版本？Rails版本？
git，linux，编辑器？
单元测试？
调试工具pry／debugger？

each 和 map 有什么区别？

2，数据库相关
用过哪些数据库？
有多大数据量？
是否有慢查询优化经验？举例介绍？
对一个Rails系统的性能优化会从哪些角度着手？

3，架构相关
多大访问量？
监控报警？
安全性／防攻击？
持续集成？
消息队列用了什么？

4，其他
工作稳定性？家乡？职业规划？
以前的团队规模？领导管理经验？CodeReview经验？


99，写一段短代码（可选）
题1:

问题描述：
画一个示意图（文章列表）。
1，有个功能模块，需要以天为单位，每天展示多篇文章，同一篇文章可以出现在不同的日期里，比如某篇文章在7月1日展示、同时在7月5日和7月6日也展示。
2，每篇文章包含以下内容： 标题、缩略图、简介、正文内容；进入功能模块是以天为单位展示文章，点击文章标题会进入文章详情页。
3，用户可以在每篇文章下发表观点
4，用户可以对文章下的观点点赞和取消点赞，观点要展示点赞数以及点过赞的用户。

要求：
1，针对以上功能需求设计数据库表结构，并给出关联关系。
2，对文章这个model进行代码实现（如果时间允许）

题2:算法？Ruby编程－第3方Api调用（网易易盾反垃圾？阿里云api？）？



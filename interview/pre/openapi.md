OpenAPI
------------------------------------------

# ref
http://www.infoq.com/cn/articles/open-api-practice

https://github.com/OAI/OpenAPI-Specification

# REST
REST形态主要有这么几点特点：1.服务地址就是资源定位地址。2.服务操作就是Http请求中的方法类型（GET,POST,DELETE,PUT），这其实是抽象现实当中对于服务的增删改查操作。Google大部分的REST API就采用了标准的REST风格，服务请求地址URL如下：

http://www.google.com/calendar/feeds/wenchu.cenwc@alibaba-inc.com/allcalendars/full

这个服务请求地址是用来定位以我阿里巴巴邮箱注册的Google帐号的所有日程安排，通过在Http消息头中配置Get、Post、DELETE、PUT可以对我的日程进行操作，而无须登陆到Google上去操作。（后面部分的实践中会有部分介绍如何通过后台Java代码直接操作）



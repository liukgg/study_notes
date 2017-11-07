MySQL经典面试题
----------------------------------------------

http://www.jianshu.com/p/977a9e7d80b3

http://blog.csdn.net/DERRANTCM/article/details/51534411


# 初级
复合索引／组合索引
索引中不会包含有NULL值的列？(如果某列存在空值，即使对该列建索引也不会提高性能)
短索引
排序的索引问题
like语句&索引
explain

聚集索引

索引类型：B－TREE索引，haxisuoyin

# 进阶
MySQL的主从复制原理和流程（binlog线程，io线程，sql执行线程）

Innodb&myisam区别（事务，行级锁，MVCC，外键，全文索引）
select count 哪个更快？


varchar与char的区别，varchar（50）

innodb的事务与日志的实现方式
日志类型：错误日志，查询，满查询，二进制，事务
事务如何通过日志来实现？（redo和存储引擎日志缓冲）

binlog的集中几种日志录入格式
statement：每一条灰修改数据的sql都会记录在binlog中
row格式

explain出来的各种item的意义

innodb的读写参数优化

你们数据库是否支持emoji表情？



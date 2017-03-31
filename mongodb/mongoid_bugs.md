mongoid 常见bug与解决方案
===============================================================

生产环境偶发性报错 not authofized ...
----------------------------------------------

##### 错误
Mongo::Error::OperationFailure (not authorized on [db] to execute command....(13))

##### 解决方案
升级 mongo 这个gem到2.2.7以上版本

##### 参考资料

https://jira.mongodb.org/browse/RUBY-1100

https://github.com/mongodb/mongo-ruby-driver/releases?after=v2.4.0.rc0


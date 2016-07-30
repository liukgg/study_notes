MongoDb常见错误处理及解决方案
=================================

出列超时
-------------------------------------------
### 错误信息：
Timeout::Error: Timed out attempting to dequeue connection after 1 sec

### 解决方案：
http://stackoverflow.com/questions/36211295/how-do-i-deal-with-dequeue-connection-timeouts-in-rails-mongoid

not master 错误
--------------------------------------------

### 错误信息
Mongo::Error::OperationFailure: not master and slaveOk=false 

### 解决方案：
方式一：重启服务器，问题解决

方式二：?

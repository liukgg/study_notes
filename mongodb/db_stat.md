mongodb统计信息
======================

mongo命令行
-------------------------------------------------

```shell
> show dbs;
local                    0.000GB
xxx_development  0.003GB
> use xxx_development;
switched to db sns_backend_development
> db.stats();
{
"db" : "xxx_development",
"collections" : 20,
"objects" : 6831,
"avgObjSize" : 384.0323525106134,
"dataSize" : 2623325,
"storageSize" : 1228800,
"numExtents" : 0,
"indexes" : 49,
"indexSize" : 1703936,
"ok" : 1
}
```

用mongoid
-------------------------------------------------

```ruby
# 查看整个库
Mongoid.default_client.database.command :dbStats => 1

#查看某个表
Mongoid.default_client.command(collstats: 'user_relations')

https://docs.mongodb.com/manual/reference/command/dbStats/
```

参考：
----------------------------------------------

http://api.mongodb.com/ruby/2.2.4/Mongo/Database.html#command-instance_method

http://stackoverflow.com/questions/13465500/how-to-tell-db-size-with-mongoid-on-heroku

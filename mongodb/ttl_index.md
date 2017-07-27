TTL index
============================

### 用途
可以作为mongodb已删除的数据释放空间的方法。
MongoDB的表归档删除数据后，mongo磁盘空间不能方便的释放；但是用TTL index可以达到该目的。

### 参考文档
TTL index文档： https://docs.mongodb.com/manual/core/index-ttl/

### 注意事项
注意：索引加上expireAfterSeconds 字段之后，过期的历史数据会立刻被清理。

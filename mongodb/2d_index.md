2d索引的用法
======================

参考资料
--------------------------------------------
### 2d索引中距离，度数，弧度转换及示例（推荐）
http://stackoverflow.com/questions/7702244/mongodb-with-mongoid-in-rails-geospatial-indexing/7702456#7702456

### ruby-china关于2d索引和2d-sphere索引的测试，以及和其他数据库的对比（推荐）
https://ruby-china.org/topics/22059

### mongodb官方文档，介绍 $centerSphere
https://docs.mongodb.com/manual/reference/operator/query/centerSphere/

小结
---------------------------------------------
### MongoDB查询地理位置默认有3种距离单位：
- 米(meters)
- 平面单位(flat units，可以理解为经纬度的“一度”)
- 弧度(radians)

- 2d索引能同时支持$center和$centerSphere，
- 2dsphere索引支持$centerSphere。
- 关于距离单位，$center默认是度，$centerSphere默认距离是弧度。

- 关于$center的单位，mongodb官方文档有说明(https://docs.mongodb.com/manual/reference/operator/query/center/#op._S_center)：
  "The circle’s radius, as measured in the units used by the coordinate system."
  即$center传入半径参数时，单位是和经纬度系统相同的，即经纬度中的1度，所以1km转为1度要除以111.12

### 提示和示例
km转为度，需要除以 111.12; km转为弧度，需要除以6371

```ruby
distance = 10 #km
location = [80.24958300000003, 13.060422]
items = Item.where(:loc => {"$near" => location , '$maxDistance' => distance.fdiv(111.12)})

location = [80.24958300000003, 13.060422]
# 以下亲自验证过（在实际项目中用其他model验证的），使用2d索引，以下查询的查询出来的数据量是一样的，不过可能返回信息量有差别。
# 可以参考  https://ruby-china.org/topics/22059
items = Item.where(:loc => {"$within" => {"$centerSphere" => [location, (distance.fdiv(6371) )]}})
items = Item.where(:loc => {"$within" => {"$center" => [location, (distance.fdiv(111.12) )]}})
```

Questions
---------------------------------------------
1, 2d索引和2d-sphere 到底有什么区别？为什么要有2个不同的索引？

2，mongoid支持within_polygon但是不支持within_center 或者 within_circle, 不知道为什么？

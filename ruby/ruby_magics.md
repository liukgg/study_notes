Ruby奇技淫巧
=============

Ruby如何找到一个方法定义？
-------------------------------------------

http://railsguides.net/find-method-source-location/

```ruby
[].method(:+)

Method.instance_methods(false)
```

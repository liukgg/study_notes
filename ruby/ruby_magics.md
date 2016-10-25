Ruby奇技淫巧
=============

Ruby基础知识介绍（各种例子，不错的版本）
------------------------------------------
http://saito.im/slide/ruby-new.html#slide-69

Ruby如何找到一个方法定义？
-------------------------------------------

http://railsguides.net/find-method-source-location/

```ruby
[].method(:+)

[].method(:+).source_location

Method.instance_methods(false)
```

Ruby 的 ||=  深入剖析：
http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html

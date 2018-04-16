### 装饰者模式介绍
23种设计模式之一，英文叫Decorator Pattern，又叫装饰者模式。

装饰模式是在不必改变原类文件和使用继承的情况下，动态地扩展一个对象的功能。它是通过创建一个包装对象，也就是装饰来包裹真实的对象。

设计模式》一书对Decorator是这样描述的：

动态地给一个对象添加一些额外的职责。就增加功能来说，Decorator模式比生成子类更为灵活。也就是说：动态地给对象添加一些额外的功能。


The "Decorator Pattern" is used to extend the functionality of a single object without affecting any other instances of the same class. You can easily add functionality to an entire class via inheritance, but it is impossible to extend a single object using this approach. This pattern allows you to apply your extensions in either a static or dynamic fashion.


A decorator should be designed so that it wraps the original class it is going to extend. 
It either adds new operations or modifies the existing functionality of the contained object. 
It is important that the decorator maintains the original object's interface by delegating all other functioncalls down to it.

### 示例（Ruby语言）
```ruby
require 'delegate'

class Person
  def speak
    'hello'
  end

  def age
    30
  end
end

class LatinDecorator < SimpleDelegator
  # modifies existing functionality
  def speak
    "'hola' means '#{__getobj__.speak}'"
  end

  # adds new functionality
  def dance
    'cha-cha-cha'
  end
end

class ChineseDecorator < SimpleDelegator
  # modifies existing functionality
  def speak
    "'你好' means '#{__getobj__.speak}'"
  end

  # adds new functionality
  def eat
    "吃大餐"
  end
end

person  = Person.new
wrapper = LatinDecorator.new(person)

puts wrapper.speak # => "'hola' means 'hello'"
puts wrapper.age # => 30
puts wrapper.dance # => 'cha-cha-cha'

cn_wrapper = ChineseDecorator.new person
puts cn_wrapper.speak
puts cn_wrapper.age
puts cn_wrapper.eat
```

###  参考资料：
#  http://nithinbekal.com/posts/ruby-decorators/
#  http://ruby-doc.org/stdlib-2.3.1/libdoc/delegate/rdoc/SimpleDelegator.html
#  http://devblog.orgsync.com/2013/03/22/decorate-your-ruby-objects-like-a-boss/

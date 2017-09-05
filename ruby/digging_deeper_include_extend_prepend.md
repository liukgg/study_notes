Ruby模块： Include vs Prepend vs Extend
---------------------------------------

### 说明
本文主要内容来自翻译，关于extend部分有所补充。
原文链接：https://medium.com/@leo_hetsch/ruby-modules-include-vs-prepend-vs-extend-f09837a5b073


模块(Module)是Ruby最有趣的特性之一。你可以用模块来给你的类附加任何行为以及用组合而不是继承来组织你的代码。
这里有个示例：

```ruby
module Logging
  def log(level, message)
    File.open("log.txt", "a") do |f|
      f.write "#{level}: #{message}"
    end
  end
end

class Service
  include Logging

  def do_something
    begin
      # do something
    rescue StandardError => e
      log :error, e.message
    end
  end
end
```

同时，大量的gems使用模块来组织他们的代码和减少对于你的应用代码的集成。例如，Sidekiq这个gem提供了Sidekiq::Worker模块
来给自定义的类附加行为以及用他们作为异步的workers成分。

```ruby
class MyWorker
  include Sidekiq::Worker
  
  def perform(args)
    # do some work
  end
end

MyWorker.perform_async {something: "useful"}
```

尽管include是引入外部代码到class中的最常用方式，但是Ruby也提供了另外两种方式来达成同样的目的：extend和preprend。
然而，他们拥有着完全不同的表现，并且这些不同点经常被Ruby开发者们错误地理解。

为了弄明白怎么使用他们，我们首先必须深入地了解，通过利用某种叫做祖先链（ancestoers chain）的东西，
Ruby是如何在运行时解析需要执行的方法的。

### 祖先链（ancestors chain）
当一个Ruby类被创建的时候，它包含着组常量名称，它们是这个类的祖先（ancestors）。
他们是这个类继承自的所有类以及这个类所包含的所有模块。
比如，通过调用String类上的ancestors方法，我们得道它的祖先如下：

```ruby
> String.ancestors
=> [String, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
```

我们能看到在祖先链顶部的BasicObject，它是Ruby对象层级中的根结点，还有Object，所有类的超类，Object类还包含了Kernel模块。

```ruby
String -> Object -> Kernel -> BasicObject
```

当我们调用String类（或任何其他类）的实例上的方法object_id时，Ruby会遍历类的祖先来寻找object_id方法，
然后最重会在Object类中发现它被定义。

当调用一个没有在任何地方被定义的方法时，Ruby将在祖先链的任何类或模块中都找不到该方法，
然后最终会调用BasicObject类的method_missing方法，该方法给了开发者最后的机会来执行后备代码。

了解了Ruby类的祖先链相关的基础知识，我们现在可以看看引入模块的不同方式了。


### Include
'include' 是引入模块代码的最常用也是最简单的方式。
当在一个类定义中调用它的时候，Ruby将会把该模块插入到该类的祖先链中，就在它的超类之前（译者注：这里原文应该有误，原文写得是超类之后）。
回到我们的第一个例子：

```ruby
module Logging
  def log(level, message)
    File.open("log.txt", "a") do |f|
      f.write "#{level}: #{message}"
    end
  end
end

class Service
  include Logging
  
  def do_something
    begin
      # do something
    rescue StandardError => e
      log :error, e.message
    end
  end
end
```

如果我们查看Service类的祖先链，那么我们可以看到，Logging模块就存在于这个类本身和它的直接超类也就是Object类之间。

```ruby
> Service.ancestors
=> [Service, Logging, Object, ...]
```

那就是为什么我们可以在这个类的实例上调用在模块中定义的方法。
Ruby，在类中没有找到这些方法时，会在祖先链上往上走一步在模块上来寻找他们。

```ruby
Service                 Logging           Object
------------  ---->     -------   ---->   ------
do_something            log()
```

同时，值得注意的是，当包含两个或者更多模块时，最后被包含的那个模块总是会被再次插入到这个类和祖先链的其他部分之间：

```ruby
module Logging
  def log(message)
    # log in a file
  end
end

module Debug
  def log(message)
    # debug output
  end
end

class Service
  include Logging
  include Debug
end

p Service.ancestors # [Service, Debug, Logging, Object, ...]
```

所以，如果像这个例子中一样发生了某个方法冲突，那么在祖先链中第一个响应的模块将会是最后被包含的模块，也就是Debug模块。

### Extend
在另一端，在类中使用extend实际上会将模块方法引入为类方法。如果我们在示例中使用extend而不是include，
那么Logging模块将不会被插入到Service类的祖先链中。所以，我们无法在任何Service的实例上调用log方法。

相反地，Ruby将会在Service类的单例类（singleton class）的祖先链中插入模块。
这个单例类（叫做：#Service，译者注：可以通过 Service.singleton_class访问到）才是实际上Service的类方法被定义的地方。
模块Logging的方法可以作为Service的类方法而被调用。

|------------|       |------|
|Service     |       |Object|
-------------| ----> |------|
|do_something|       |      |
|------------|       |------|
      |
      v
|------------|       |-------|
|#Service    |       |Logging|
-------------| ----> |-------|
|            |       |log()  |
|------------|       |-------|

然后，我们可以像这样调用方法：

```ruby
Service.log :info, "Something happened"
```

经常地，你会想要在一个类上使用模块来引入实例方法，但是同时也要定义类方法。
正常情况下，你将不得不使用两个不同的模块，一个用include来引入实例方法，
而另一个用extend来定义类方法。

用单个模块达到这一点的通常惯例是利用Module的included钩子方法，以同时在运行时引入类方法：

```ruby
module Logging
  module ClassMethods
    def logging_enabled?
      true
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def log(level, message)
    # ...
  end
end
```

现在，当我们在Service类中包涵模块的时候，模块方法将被引入为类的实例方法。
included方法也会被调用，它会将正在发生include的类作为参数。
然后我们可以在这个类上调用extend来引入ClassMethods子模块的方法作为类方法。
这样就达成了闭环。


译者注：

通过singleton_class可以访问到一个类的单例类，从而可以看到extend的模块到了单例类的祖先链中。

```ruby
module M
end

class A
  extend M
end

A.singleton_class #=> #<Class:A>
A.singleton_class.ancestoers
#=> [#<Class:A>, M, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject]
```

### Prepend
prepend 从Ruby 2开始提供，对于Ruby开发者来说它没有它的另外两个小伙伴那么出名。
它实际上和include的工作机制相似，不同点在于，include是在祖先链中将模块插入到类和它的超类之间，
而prepend是会把模块插入到祖先链的底部，甚至还在类本身之前。

这意味着当调用一个类实例上的方法时，Ruby在查看类本身之前会先查看模块方法。
这个行为上的不同点让你可以用模块来装饰已有的类以及实现“around”逻辑：

```ruby
module ServiceDebugger
  def run(args)
    puts "Service run start: #{args.inspect}"
    result = super
    puts "Service run finished: #{result}" 
  end
end

class Service
  prepend ServiceDebugger
  
  # perform some real work
  def run(args)
    args.each do |arg|
      sleep 1
    end
    {result: "ok"}
  end
end
```

使用prepend时，模块 ServiceDebugger 现在被插入到了祖先链的最底端。

```ruby
ServiceDebugger       Service       Object
--------------- ----> ------- ----> ------
run()                 run()
```

你自己可以通过调用 Service.ancestors 来再次确认这一点：

```ruby
> Service.ancestors
=> [ServiceDebugger, Service, Object, ...]
```

在Service的实例上调用run方法首先会执行定义在ServiceDebugger中的方法。
我们可以用super来调用在祖先链之上的直接祖先上的同名方法，也就是Service类本身。
我们利用该行为的优势实现了用一种非常简单优雅的方式来装饰Service的实现。

感谢你的阅读，祝你愉快地用Ruby编码！

### 附录
另外有一篇关于Ruby中的singleton_class的说明，有空再研究和分享。

https://www.devalot.com/articles/2008/09/ruby-singleton

Ruby模块： Include vs Prepend vs Extend
------------------------------

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
当在一个类定义中调用它的时候，Ruby将会把该模块插入到该类的祖先链中，就在它的超类之前（译者注：这里原文英国有误）。

### Extend
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


### 附录
另外有一篇关于Ruby中的singleton_class的说明，有空再研究和分享。

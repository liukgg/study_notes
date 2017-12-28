如何从零开始创建你的第一个gem
--------------------------------------------

[README-English](https://github.com/liukgg/example_gem/blob/master/README.md)

详细案例可以参考：https://github.com/liukgg/example_gem

该gem旨在说明如何从零开始创建一个gem，并且提供了一个示例，手把手教你写出自己的第一个gem。

### How to create a gem
### 如何创建一个gem

你可以通过这个命令来创建一个gem：

```ruby
bundle gem example_gem
```

按照约定，summary（概述）一般是和description（描述）类似，但是会更加简短。summary正常来说大概是一行，
而description可能有4道5行。

确保把描述中的“FIXME” 和 “TODO”替换掉－－gem build 命令会不喜欢它们，且对用户来说它们看起来不友好。

你需要在底部声明依赖关系，类似这样：

```ruby
  gem.add_development_dependency "rspec"
  gem.add_runtime_dependency "rest-client"
  gem.add_runtime_dependency "some_gem", "1.3.0"
  gem.add_runtime_dependency "other_gem", ">0.8.2"
```

这些每一个会增加一个运行时依赖（需要用于运行该gem）或者开发依赖（需要用于开发或测试该gem）。

接下来让我们构建你的gem并且安装：

```ruby
 gem build example_gem.gemspec
 gem install example_gem-0.0.1.gem
```

最后一步是引入该gem并且使用它：

```ruby
% irb
2.1.1 :001 > require 'example_gem'
true
2.1.1 :002 > ExampleGem::Hello.say_hi
Hello, world!
nil
2.1.1 :003 > ExampleGem::Hello.say_hi("liukgg")
Hello, liukgg!
nil
2.1.1 :004 >
```

### 如何在你改变gem的代码时重新构建和重新安装
再次构建gem并安装它：

``` ruby
gem build example_gem.gemspec
gem install example_gem-0.0.1.gem
```

### 想要知道如何将你的gem发布道rubygems.org的话，你可以参考这里：
 http://guides.rubygems.org/make-your-own-gem/

### 参考资料
 《RebuildingRailsCurrent》

 http://guides.rubygems.org/make-your-own-gem/



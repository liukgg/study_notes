Ruby基础知识分享(By kun.liu)
------------------------------

### 一切皆对象

```ruby
1 + 2 #=> 1.+(2)
1.class
'abc'.class

class A
end
A.class

nil.class

false.class

nil.class.superclass
```

### Hello World
```ruby
print "hello world!"
puts  "hello world!"
p     "hello world!" # 和puts有点区别
```

### 注释
```ruby
# hi

=begin
 long comment
=end
```

### 变量
```ruby
local: time or _time
instance: @time
class: @@time
global $time

class A
  def self.hi
    @hi = 'hi' # 类方法中的实例变量，属于当前类，本质上是个类变量
  end
end
```

### 常用类（数据类型）

```ruby
# Numeric
1
1.1

# String
'abc'

name = "Jim"
"hello #{name}"

# 常用方法举例
'abcd'.size
'abcd'.length
'abcd'.reverse
'abcd'.sub(/a/, 'H')

# Symbol
:abc

# Boolean
false, true

# Array
arr = [1, 2, 3, 4, 5]
arr[0]
arr[5]
arr[-1]
arr[0, 5]
arr[0..2]

# Hash
{ a: 1, b: 2 }
{ :a => 1, :b => 2 }
{ 'a' => 1, 'b' => 2 }
```

提倡优先用Symbol 而不是 String，因为Symbol在内存中只有1份，而string会有多份，用object_id可以看出。

### Ruby 小技巧

```ruby
"hello #{name}" # 单引号和双引号的区别

# 交换2个变量的值
# 并行赋值；不是线程安全的，多线程情况下慎用！《Working with ruby threads》
a, b = b, a

3.times { puts "hello" }

"hello" + "world"

"hello" * 3

undefined_variable rescue puts "catch it!"
```

### 条件语句以及ruby特色

```ruby
# ok
if a > 5
  puts a
end

# NOT recommended
if a > 5 then puts a end

# Good
puts a if a > 5

puts "it is true" if !name
puts "it is true" unless name

a > 5 ? puts(a) : "oh no"

# Ruby中为假的值： false, nil
if nil
  raise "Never executed!"
end

# 逻辑运算符， 并不是一定返回布尔值，而是取决于参与运算的对象
1 && 2 # => 2
nil || 'abc' # => 'abc'
false || nil # => nil
```

```ruby
# if..else, case .. when
if name == "jack"
  "i am rose"
elsif name == "rose"
  "jack i miss u"
else
  "get out from here"
end

case name
when "jack" then "i am rose"
when "rose" then "jack i miss u"
else "get out from here"
end
```

### 循环

```ruby
# Recommended
3.times{ puts "hello world" }

# Recommended
[1, 2, 3].each do |x|
  puts x
end

# NOT Recommended
for x in [1,2,3]
  puts x
end

while i > 5 do
  i -= 1
end
i -= 1 while i > 5

until i <= 5 do
  i -= 1
end
i -= 1 until i<= 5

loop { puts "good" }
loop do
  puts "good"
end

# break, next, redo, retry
```

### 方法

```ruby
# 普通版
def plus(x,y)
  z = x + y
  return z
end
plus(3, 4)

# 升级版
def plus x,y
  x + y
end
plus 3,4

# block
def hello
  yield # 这是个关键字
end
hello { puts "hello, block" }

# 常用block举例
[1,2,3,4,5].each{ |i| puts i }
[1,2,3,4,5].each_with_index{ |i, index| puts i, index }
[1,2,3,4,5].map{ |i| i**2 }
[1,2,3,4,5].select{ |i| i%2==0 }
[1,2,3,4,5].reject{ |i| i%2==0 }
[1,2,3,4,5].inject{ |sum, i| sum += i }
[1,2,3,4,5].reduce{ |sum, i| sum += i }

# 精简版
[1,2,3,4,5].reduce(:+) #=> 15
['abc', 'abcde'].map(&:length) #=>[3, 5]

```

### class(类)

```ruby
# 一般的class实现
class Bird
  attr_accessor :name, :sex

  def initialize name
    @name = name
  end

  def self.fly
    puts "bird can fly"
  end

  def say
    puts "i am #{@name}"
  end
end

bird = Bird.new("didi")
bird.sex = "male"
Bird.fly

# attr_accessor 解析
这是个方法：attr_accessor(:name, :sex), Class#attr_accessor

# attr_accessor(:name, :sex) 实际上相当于：
class Bird
  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def sex
    @sex
  end

  def sex=(sex)
    @sex = sex
  end
end

# 类似的： attr_reader, attr_writer

# class的另一种定义方式
Bird = Class.new do
  attr_accessor :name, :sex

  def initialize name
    @name = name
  end

  def self.fly
    puts "bird can fly"
  end

  def say
    puts "i am #{@name}"
  end
end

Bird.new("Bugu").say

# 一切皆对象！Ruby中的class本身也是一个对象，是Class类的一个实例。
```

# module(模块)

```ruby
# ruby 中有强大的module和minxin机制
module Eat
  def eat
    p "i can eat"
  end
end

module Sleep
  def sleep
    p "i can sleep"
  end
end

class Pig
  include Eat
  include Sleep
end

class Person
  include Eat
  include Sleep
end

Pig.new.eat
Pig.new.sleep

Person.new.eat
Person.new.sleep

# 方法查找链：
Person.ancestors

# module 常量
module Math
  PI = 3.14
end

Math::PI

# module namespace
module Foo
  module Bar
    def self.say
      p "Hi"
    end
  end
end

Foo::Bar.say

# another example
module Foo
  class Bar
    def say
      p "Hi"
    end
  end
end

Foo::Bar.new.say
```

### 查看方法定义

```ruby
class A
  def m
  end
end

m = A.new.method(:m) #=> #<Method: A#m>

m.source_location #=> ["(irb)", 8] 
```

```ruby
require 'pry'

lk-mac:study_notes kun.liu$ irb
2.3.0 :001 > require 'require "pry";binding.pry'
 => true 
 2.3.0 :002 > require "pry";binding.pry
 [1] require "pry";binding.pry(main)> show-method puts

 From: io.c (C Method):
 Owner: Kernel
 Visibility: private
 Number of lines: 8

 static VALUE
 rb_f_puts(int argc, VALUE *argv, VALUE recv)
 {
     if (recv == rb_stdout) {
         return rb_io_puts(argc, argv, recv);
     }
     return rb_f_putsuncall2(rb_stdout, rb_intern("puts"), argc, argv);
 }
```

本质上 'Pry' 用的是 source_location:
但是ruby原始的source_location 不支持 c 语言定义的ruby方法，而pry则可以。

Ruby元编程
-------------------------------

```ruby
1，对象模型:继承关系；
2，方法:    方法查找链，method_missing,define_method, send,alias, alias_method;
3，代码块： 绑定的概念，binding,block,lamda,proc;
4，类定义： Class.new,Eigenclass,included,instance_eval, class_eval;
5，编写代码的代码：Kernel#eval;
6，安全元编程；
7，研读Rails源码；
8，适当使用元编程技巧，编写自己的gem包；。
```
==考虑代码可读性，不要滥用元编程。==
==学习元编程有利于读懂rails、rack等gem的源码，加深对ruby和rails的理解。==

### 参考资料
- 《Programming Ruby》
- 《Metaprogramming Ruby》
- http://saito.im/slide/ruby-new.html#slide-69
- http://ruby-doc.org/

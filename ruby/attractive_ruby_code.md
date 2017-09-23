Ruby魅力之旅
=============


### 迷路的“Hello World”

```ruby
#!/usr/bin/env ruby
$methods = []

def method_missing m, *args, &block
  $methods.unshift  m.to_s
end

at_exit do
  puts $methods.map(&:capitalize).join(' ')
end

hello world
```

### 密码生成器

```ruby
# 大小写数字混合的密码
(('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).sample(15).join

# 带特殊字符
((48..122).to_a).sample(15).map(&:chr).join
```

### 强大的赋值

```ruby
# 动态类型
a = "123"

# 并行赋值；交换
a, b, c, d = [1, 2, 3, 4]

a, b = b, a
```

### 奇妙的数组

```ruby
arr1 = %w(red green yellow)
arr2 = [1, 2, 3] * 3
arr3 = [1, 2, 3, 4] - [1, 3]

['China', 'America', 'Japan'][-1]
```

### 无比简洁

```ruby
puts "hello world"
```

```ruby
# 找出20以内的偶数

# ruby版本
(1..20).select(&:even?)

# c语言版本
#include<stdio.h>

int main(void) {
    int arr[10];

    for(int i = 1; i <= 20; i++){
      if((i % 2) == 0) arr[(i / 2 - 1)] = i;
    }

    for(int n = 0;n < 10; n++)
      printf("%d ",arr[n]);

    printf("\n");
}
```

### 函数式编程
```ruby
# Lambda
sum  = ->(x, y) { x + y }
diff = ->(x, y) { x - y }

def double(x, y, function)
  2 * function.call(x, y)
end

double(5, 10, sum)  #=> Output : 2 * (5+10) = 30
double(2, 1, diff)  #=> Output:  2 * (2-1) = 2
```

强大的Ruby On Rails
-------------------------------------------

### 准备工作

```ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

brew install git sqlite
rvm install 2.3.0
rvm use 2.3.0 --global
ruby -v
gem install rails
rails -v
```

### 轻松开始项目

```shell
rails new sample_app

rails server
# localhost:3000

rails g controller static

rails g scaffold user name:string email:string
rails g scaffold blog user:references content:text

rake db:migrate

rails console
```

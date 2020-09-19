ruby生成安全密码：

```ruby
arr = (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a)
arr.sample(25).join # 也可以用 shuffle

(('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).sample(15).join
```


```ruby
arr = (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a)
syms = %w(! @ # $ % ^ & * ( ))

(arr + syms).sample(15).join
```

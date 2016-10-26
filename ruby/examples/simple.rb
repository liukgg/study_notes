#!/usr/bin/env ruby

puts "hello world"

a = "123"

a, b = 1, 2
a, b = b, a

"hello" * 3

[1, 2, 3, 4] - [1, 3]

['China', 'America', 'Japan'][-1]

[1, 2, 3, 4].reduce(:+)

1.upto(10).each{ |x| puts x }
3.times { puts "hello" }

puts "hello" if 2 > 1

%w(red green yellow)

def plus(x, y)
  x + y
end
plus x, y

class Bird
  attr_accessor :name, :sex
end

def fib(n, t = n < 2 ? n : fib(n-1) + fib(n-2)) t; end
fibs = Hash.new { |h, k| h[k] = k <= 2 ? 1 : h[k-1] + h[k-2] }

(1..20).select{ |x| x % 2 == 0 }
(1..20).select{ |x| x.even? }
(1..20).select(&:even?)

=begin
# C
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
=end

# Lambda
sum  = ->(x, y) { x + y }
diff = ->(x, y) { x - y }
def double(x, y, function)
  2 * function.call(x, y)
end
double(5, 10, sum)  #=> Output : 2 * (5+10) = 30
double(2, 1, diff)  #=> Output:  2 * (2-1) = 2

# 生成一个大小写数字混合的密码
(('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).sample(15).join

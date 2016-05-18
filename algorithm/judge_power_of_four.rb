# 每周题目
# Power of Four
# Given an integer (signed 32 bits), write a function to check whether it is a power of 4.
#   Example:
#   Given num = 16, return true. Given num = 5, return false.
#   Follow up: Could you solve it without loops/recursion?
#

require 'test/unit'

# @V1
# with recursion
def v1_power_of_four?(num)
  return false if num <= 0.0
  return true  if num == 1

  if num % 4 == 0
    rest_num = num / 4
    if rest_num == 1
      true
    else
      power_of_four? rest_num
    end
  else
    false
  end
end

# @V2
# without recursion
# 4^x = y
# => x = log4(y) = lg(y) / lg(4)
# Math.log(4, 4) => 1.0
# Math.log(4.000000000001, 4) => 1.0
# => 不准确！
def v2_power_of_four?(num)
  return false if num <= 0.0
  Math.log(num, 4) # => Float
end

# @V3
# Given an integer (signed 32 bits), write a function to check whether it is a power of 4.
# 有符号32位最大位 2 ** 31
# 穷举数量不多： 4 ^ n => (2 ^ 2) ^ m => 2 ^ (2m) => 0 <= 2m <= 31
# =>  0 <= m <= 15
@matched_nums = (0..15).inject([]){ |result, x| result << 4 ** x }
def v3_power_of_four?(num)
  return false if num <= 0.0

  @matched_nums.include? num
end

# @V4
# 规律：4的乘方转为2进制后都是1后面跟偶数个0:
# 1  => 1
# 4  => 100
# 16 => 10000
# 64 => 1000000
# ......
#
# e.g:
#  64.to_s 2
#  => "1000000"
def v4_power_of_four?(num)
  !!num.to_s(2).match(/\A1(00)*\Z/)
end

# unit test
# benchmark

require 'benchmark'
Benchmark.bm do |x|
  x.report { 100_000.times { v1_power_of_four?(4 ** 15)} }
  x.report { 100_000.times { v3_power_of_four?(4 ** 15)} }
end

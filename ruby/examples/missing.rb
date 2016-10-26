#!/usr/bin/env ruby
$methods = []

def method_missing m, *args, &block
  $methods.unshift  m.to_s
end

at_exit do
  puts $methods.map(&:capitalize).join(' ')
end

hello world

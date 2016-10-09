# coding: utf-8
if ENV['RUBY_CHINA_GEM']
  source 'https://gems.ruby-china.org'
else
  source 'http://rubygems.org'
end

ruby '2.3.0'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'rake'

gem 'jquery-rails'
gem 'turbolinks', '~> 2.5', '>= 2.5.3'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rails-i18n', '~> 4.0.0'

# mysql驱动
gem 'mysql2'

# mongodb驱动
gem 'mongoid', '~> 5.1.1'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# API库
gem 'grape'

# gem 'tilt-jbuilder', require: 'tilt/jbuilder'
gem 'grape-jbuilder'

gem 'grape_logging',       github: 'aserafin/grape_logging'

# 全局变量
gem 'request_store'

# 系统配置
gem 'config'

# 分页
gem 'kaminari'

# http client
gem 'rest-client', github: 'rest-client/rest-client'

# 根据ip查询国家信息
gem 'maxminddb'

# 日志
gem 'lograge'

# json数据解析
gem 'multi_json'

# 异步任务处理
# gem 'sidekiq'
gem 'sidekiq'

gem 'sinatra'

# 定时任务处理
gem 'whenever',  require: false

# 跨域
gem 'rack-cors', require: 'rack/cors'

# 超时处理
gem 'rack-timeout'

# 请求频率限制
gem 'rack-attack'

# 使用 redis 作为rails的cache机制
gem 'redis-rails'

gem 'mongoid-locker'
gem 'hiredis'
gem 'redis', '~>3.2', require: %w(redis redis/connection/hiredis)

# 异常邮件通知
gem 'exception_notification'

# 上传插件
gem 'carrierwave'
gem 'carrierwave-aliyun'

#redis type gem
gem 'redis-objects'

gem 'geokit'

#gem 'maxminddb'
#gem 'geoip'

group :development, :staging do
  # API文档
  gem 'grape-swagger'
  gem 'grape-swagger-rails', github: 'ruby-grape/grape-swagger-rails'

  # 调试工具
  gem 'pry'
end


group :development do
  gem 'awesome_print'

  gem 'mina', require: false
  gem 'mina-multistage', require: false
  gem 'mina-sidekiq', require: false

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener_web', '~> 1.2.0'
  gem 'web-console', '~> 2.0'


  gem 'guard-rails',     require: false
  gem 'guard-rspec',     require: false
  gem 'guard-bundler',   require: false
  gem 'guard-sidekiq',   github: 'uken/guard-sidekiq',   require: false

end

# 测试工具
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'libxml-ruby'
  gem 'byebug'
  gem 'faker'

  # gem 'test-queue'
end

group :test do
  gem 'rspec-sidekiq'

  gem 'test_after_commit'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'as-duration'

  gem 'simplecov', :require => false
  gem 'simplecov-json', :require => false
end

group :production, :staging do
  # 应用服务器
  # gem 'puma'

  # APM统计
  gem 'newrelic_rpm'

end

#产生logstash 相适应日志
gem 'logstasher'
gem 'logstash-logger', github: 'ltnwgl/logstash-logger'

#微信公众号处理
gem 'wechat'

#读取excel
gem 'roo', '~> 2.4.0'

gem 'activerecord-import'
gem 'jpush', git: 'https://github.com/jpush/jpush-api-ruby-client.git'

#处理User－Agent
gem 'browser'

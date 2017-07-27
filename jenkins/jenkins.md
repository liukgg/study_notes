Jenkins及其插件简介
=================

### 参考材料

http://www.tutorialspoint.com/jenkins/jenkins_git_setup.htm

### 安装 java 8

```shell

# 安装 apt-add-repository 命令

sudo apt-get install software-properties-common

# 安装java

sudo apt-add-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java8-installer

# 确认java安装成功

java -version

```

### 下载 jenkins, tomcat

```shell

wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war

wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/tomcat/tomcat-8/v8.0.35/bin/apache-tomcat-8.0.35.tar.gz

```

### 解压tomcat文件

```shell

tar -xf apache-tomcat-8.0.35.tar.gz

```

### 清理tomcat的webapps目录

```shell

rm -r apache-tomcat-8.0.35/webapps/*

```

### 将jenkins.war 放到tomcat的webapps目录下

```ruby

mv jenkins.war apache-tomcat-8.0.35/webapps/

```

### 启动 tomcat

```ruby

cd apache-tomcat-8.0.35/bin/

./startup.sh

```

### 安装插件－－看参考资料

```

git plugin

```

### 重启

```ruby

http://127.0.0.1:8080/jenkins/restart

```

### 项目配置

```ruby

#!/bin/bash --login -e

#rvm install 2.3.0
rvm use 2.3.0 --default

ruby -v

## 安装插件
#gem install bundler -v '1.12.5'

bundle install

echo "----> Copy config files..."
# 避免不同环境mysql，redis等的数据相互干扰导致rspec失败
cp config/database.yml.example.ci.development config/database.yml
cp config/mongoid.yml.example.ci.development config/mongoid.yml
cp config/wechat.yml.example config/wechat.yml
cp config/settings/test.local.yml.example.ci.development config/settings/test.local.yml

echo "----> Reset Database..."
RAILS_ENV=test bundle exec rake db:drop
RAILS_ENV=test bundle exec rake db:create
RAILS_ENV=test bundle exec rake db:migrate

echo "----> Reset Mongodb..."
RAILS_ENV=test bundle exec rake db:mongoid:drop
RAILS_ENV=test bundle exec rake db:mongoid:create_indexes

pwd

## Rubocop检测代码，Error及Fatal错误就终止部署
echo "----> Check code by Rubocop..."
rubocop app/ -l --fail-level E --format html --out result.html
echo $?

## Brakeman检测代码安全性，有问题就终止部署
echo "----> Check security by Brakeman..."
#brakeman -o output.html -z
brakeman --format html -o brakeman_output.html
echo $?

echo "----> Run Rspec..."
## 运行单元测试
bundle exec rspec spec/ --color --tty

echo "----> deploy..."
##  执行部署步骤（需要和运维确认，允许jenkins机器ssh到你的项目服务器）
bundle exec mina staging-hz-web01 deploy
```

jenkins FAQ
-------------------------------------------

### 设置管理员时，没有选择权限，导致无法登录

```

# 找到jenkins的配置文件

sudo find / -name "config.xml"

# 把启用登录设为false

false

# 重启tomcat，打开jenkins管理页面，重新添加用户和选择权限

```

### 配置jenkins

- 安装git plugin

- git分支设为 develop

- 项目目录下添加 config/database.yml.example.ci 和 config/mongoid.yml.example.ci

### 环境配置

```shell

# 参考对应项目的部署

sudo apt-get install -y software-properties-common

sudo apt-get -y --force-yes dist-upgrade

sudo apt-get install -y curl gnupg build-essential

sudo apt-get install -y git

sudo apt-get install -y libcurl4-openssl-dev

sudo apt-get install -y libmysqld-pic

sudo apt-get install -y nodejs

sudo apt-get install -y libgmp-dev

sudo apt-get install -y imagemagick

echo '192.168.6.28 gitlab.aasky.net' | sudo tee -a /etc/hosts

ssh-keyscan -H gitlab.aasky.net >> ~/.ssh/known_hosts

# rvm 安装之后需要新开窗口才会加载rvm

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -L https://get.rvm.io | bash -s stable --auto-dotfiles

export PATH="$PATH:$HOME/.rvm/bin"

rvm install 2.3.0

rvm alias create default 2.3.0

rvm use 2.3.0 --default --ignore-gemsets

gem install bundler

# 安装完之后这些都会自动启动

sudo apt-get install mysql-server

sudo apt-get install redis-server

sudo apt-get install mongodb

# 安装这些后需要重启tomcat

# 配置

bundle install

cp config/database.yml.example.ci config/database.yml

cp config/mongoid.yml.example.ci config/mongoid.yml

RAILS_ENV=test bundle exec rake db:drop

RAILS_ENV=test bundle exec rake db:create

RAILS_ENV=test bundle exec rake db:migrate

RAILS_ENV=test bundle exec rake db:mongoid:create_indexes

bundle exec rspec spec/ --color--tty

pwd

cd /data/home/jenkins/projects/sns-backend

pwd

# 加上这个部署才能通过, 部署时 git pull 才成功

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

git checkout develop

git pull

bundle exec mina staging-hz-web01 deploy

```

### 测试覆盖率结果报告接入

http://www.cakesolutions.net/teamblogs/brief-introduction-to-rspec-and-simplecov-for-ruby

### 测试覆盖率低于门槛则测试失败

```ruby

SimpleCov.minimum_coverage 80

```

### jenkins版本查看

java -jar /usr/lib/jenkins/jenkins.war --version

### jenkins升级

wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war

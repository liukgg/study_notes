mongodb升级

### Ubuntu

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

sudo apt-get update

安装最新稳定版的MongoDB
sudo apt-get install -y mongodb-org

参考自：

http://www.xiaoboy.com/detail/2015040809.html

Docker入门介绍
---------------------------------------------

https://docs.docker.com/get-started/

备注：该文中示例均为Mac电脑为例

# Part 1: 方向和安装
### 容器的特点：
- 弹性
- 轻量级
- 易于变更
- 可移植性
- 可扩展性
- 可堆叠


### 镜像和容器
镜像是一个可执行的包，它包含了用于运行一个应用所需要的一切：代码，运行时，环境变量和配置文件。

容器是镜像的一个运行时实例，即镜像再被执行时在内存中的存在形式。

在Linux上，你可以通过命令 docker ps 来查看你在运行中的容器列表。

### 容器和虚拟机
容器在Linux机器上原生地运行，且和其他容器共享宿主机器的内核。它运行一个单独的进程，并不会比任何其他可执行程序
多占用内存，这使得它很轻量级。

相反，虚拟机（VM）运行一个完整的“访客”操作系统，通过一个超级管理器拥有对于主机资源的虚拟权限。
通常，相比大多数应用程序需要的资源来说，虚拟机提供了一个占用更多资源的环境。

### 准备你的Docker环境
参考该链接进行安装： https://docs.docker.com/install/

### 测试Docker版本

```shell
docker --version

# 更详细的版本信息
docker info
```

### 测试Docker安装

```shell
docker run hello-world

docker image ls
```

### 回顾和命令清单

```shell
## List Docker CLI commands
docker
docker container --help

## Display Docker version and info
docker --version
docker version
docker info

## Excecute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -a -q
```

### 第一部分总结
容器化让CI/CD变得无缝衔接。例如：
- 应用无系统依赖
- 更新可以被推送给分布式应用的任何部分
- 资源密度可以被优化

# part 2: 容器

### 介绍
一个app的层级的最底端是容器（container），我们在这部分讨论。这一层之上是服务（service），
它定义了容器在生产环境如何表现，在第3部分讨论。最终，最顶层的是堆叠（stack），定义了所有服务的交互，
在第5部分讨论。

- Stack
- Services
- Container(you are here)

### 使用Dockerfile定义一个容器

```shell
# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```

### app 本身

requirements.txt文件

```shell
Flask
Redis
```

app.py

```shell
from flask import Flask
from redis import Redis, RedisError
import os
import socket

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

app = Flask(__name__)

@app.route("/")
def hello():
    try:
        visits = redis.incr("counter")
    except RedisError:
        visits = "<i>cannot connect to Redis, counter disabled</i>"

    html = "<h3>Hello {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>" \
           "<b>Visits:</b> {visits}"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
```

### 构建app

```shell
ls

docker build -t friendlyhelo .

# 查看
docker image ls
```

### 运行app

```shell
docker run -p 4000:80 friendlyhello
```

你可以在浏览器通过这个地址访问： http://localhost:4000.

从命令行输出你看到Python应用在服务 http:0.0.0.0:80，但是实际上这个消息来自容器内部，
它并不知道你把80端口映射给了4000端口，所以实际上在宿主机上访问应该用4000端口。


也可以在后台运行该app：
```shell
docker run -d -p 4000:80 friendlyhello

docker container ls

# 停止进程
docker container stop <CONTAINER ID>
```

### 分享你的镜像

首先注册一个Docker账号：loud.docker.com

登录： docker login

### 给镜像打标签

```shell
# 注意要用你自己的用户名，仓库名和tag名任意，tag名不是必须的，但是强烈推荐加tag
docker tag image <username>/<repository>:<tag>

# 例如：
docker tag friendlyhello liukgg/get-started:part2

# 查看
docker image ls
```

### 发布镜像
```shell
docker push username/repository:tag
```

### 拉取和从远程仓库运行镜像
从此，你可以在任意机器上运行你的app：

```shell
docker run -p 4000:80 username/repository:tag

# 例如：
docker run -p 4000:80 liukgg/get-started:part2
```

### 总结和命令清单

```shell
docker build -t friendlyhello .  # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello  # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello         # Same thing, but in detached mode
docker container ls                                # List all running containers
docker container ls -a             # List all containers, even those not running
docker container stop <hash>           # Gracefully stop the specified container
docker container kill <hash>         # Force shutdown of the specified container
docker container rm <hash>        # Remove specified container from this machine
docker container rm $(docker container ls -a -q)         # Remove all containers
docker image ls -a                             # List all images on this machine
docker image rm <image id>            # Remove specified image from this machine
docker image rm $(docker image ls -a -q)   # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry
```

# Part 3: 服务

### 介绍
- Stack
- Services(you are here)
- Container

### 关于服务
服务实际上只是“生产环境的容器”。一个服务只运行一个镜像，但是它指定了镜像运行的方式－－
使用哪个端口，容器运行多少个副本等等。

幸运的是，通过 docker-compose.yml 文件很容易定义，运行和扩展服务。

### 你的第一个 docker-compose.yml 文件

```shell
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
      restart_policy:
        condition: on-failure
    ports:
      - "80:80"
    networks:
      - webnet
networks:
  webnet:
```

### 运行新的负载均衡的app

```shell
docker swarm init

docker stack deploy -c docker-compose.yml getstartedlab

docker service ls
docker service ps getstartedlab_web

docker container ls -q
```

查看浏览器： http://localhost, 可以看到Hostname在变化，刚好和Container ID对应。


# 扩展app
修改docker-compose.yml文件中的relicas参数，然后再次deploy：

```shell
docker stack deploy -c docker-compose.yml getstartedlab

docker container ls -q
```

# 停掉app和swarm

```shell
docker stack rm getstartedlab

docker swarm leave --force
```

### 总结和命令清单
```shell
docker stack ls                                            # List stacks or apps
docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
docker service ls                 # List running services associated with an app
docker service ps <service>                  # List tasks associated with an app
docker inspect <task or container>                   # Inspect task or container
docker container ls -q                                      # List container IDs
docker stack rm <appname>                             # Tear down an application
docker swarm leave --force      # Take down a single node swarm from the manager
```

# Part 4: 集群（Swarms）

### 介绍
多容器，多机器的应用程序可以通过加入多个机器到docker化集群中得以实现，docker化集群称为swarm。

docker集群（swarm）是一组运行Docker和加入到了一个集群中的机器。

### 设置你的swarm

```shell
docker-machine create --driver virtualbox myvm1
docker-machine create --driver virtualbox myvm2

docker-machine ls

docker-machine ssh myvm1 "docker swarm init --advertise-addr <myvm1 ip>"
```

把myvm2作为一个worker加入到swarm中：

```shell
docker-machine ssh myvm2 "docker swarm join \
--token <token> \
<ip>:2377"
```

```shell
docker-machine ssh myvm1 "docker node ls"
```

### 在swarm集群上部署你的app

配置一个到swarm manager的docker-machine命令行

```shell
docker-machine env myvm1

eval $(docker-machine env myvm1)

docker-machine ls
```

在swarm manager上部署app：

```shell
docker stack deploy -c docker-compose.yml getstartedlab

docker stack ps getstartedlab

```


### 访问你的集群
你可以通过 myvm1 或者 myvm2 的IP地址来访问你的app，都可以。
通过 docker-machine ls 命令可以查看到你的虚拟机的IP地址。

例如： http://192.168.99.101

两个IP地址都可以访问的原因是swarm中的节点加入了一个入口路由网格（ingress routing mesh）。
架构参考下图：

https://docs.docker.com/engine/swarm/images/ingress-routing-mesh.png

### 迭代和扩展你的app
修改 docker-compose.yml文件，并重新发布。

### 清理和重启

建议先不要清理，下一部分还要用到

```shell
# 建议先不要清理，下一部分还要用到
docker stack rm getstartedlab

eval $(docker-machine env -u)

docker-machine ls

# 如果你的机器关机过，可以通过以下命令来重启Docker机器：
docker-machine start myvm1
docker-machine start myvm2
```

### 总结和命令清单

```shell
docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)
docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1 # Win10
docker-machine env myvm1                # View basic information about your node
docker-machine ssh myvm1 "docker node ls"         # List the nodes in your swarm
docker-machine ssh myvm1 "docker node inspect <node ID>"        # Inspect a node
docker-machine ssh myvm1 "docker swarm join-token -q worker"   # View join token
docker-machine ssh myvm1   # Open an SSH session with the VM; type "exit" to end
docker node ls                # View nodes in swarm (while logged on to manager)
docker-machine ssh myvm2 "docker swarm leave"  # Make the worker leave the swarm
docker-machine ssh myvm1 "docker swarm leave -f" # Make master leave, kill swarm
docker-machine ls # list VMs, asterisk shows which VM this shell is talking to
docker-machine start myvm1            # Start a VM that is currently not running
docker-machine env myvm1      # show environment variables and command for myvm1
eval $(docker-machine env myvm1)         # Mac command to connect shell to myvm1
& "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env myvm1 | Invoke-Expression   # Windows command to connect shell to myvm1
docker stack deploy -c <file> <app>  # Deploy an app; command shell must be set to talk to manager (myvm1), uses local Compose file
docker-machine scp docker-compose.yml myvm1:~ # Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"   # Deploy an app using ssh (you must have first copied the Compose file to myvm1)
eval $(docker-machine env -u)     # Disconnect shell from VMs, use native docker
docker-machine stop $(docker-machine ls -q)               # Stop all running VMs
docker-machine rm $(docker-machine ls -q) # Delete all VMs and their disk images
```

# Part 5: 堆叠（Stacks）

### 介绍
这章接近尾声了。堆叠（stack）是分布式应用层级中的顶层。

堆叠（stack）是一组共享依赖并且可以一起被编排和扩展的相关联的服务。

事实上，之前已经接触了堆叠，即：docker stack deploy.

### 添加一个服务并且重新部署

修改 docker-compose.yml文件：

注意： username/repo:tag 改成你自己的。

```shell
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      restart_policy:
        condition: on-failure
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
    ports:
      - "80:80"
    networks:
      - webnet
  visualizer:
    image: dockersamples/visualizer:stable
    ports:
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints: [node.role == manager]
    networks:
      - webnet
networks:
  webnet:
```

确认你的shell已经被配置为和myvm1通信（完整示例参考这里：https://docs.docker.com/get-started/part4/#configure-a-docker-machine-shell-to-the-swarm-manager）


再次部署：

```shell
docker stack deploy -c docker-compose.yml getstartedlab

docker-machine ls
```

通过以上命令 docker-machine ls 得到IP地址， 在浏览器查看你的visualizer服务： http://192.168.99.101:8080

可以通过以下命令确认浏览器中展示的对应的是你的服务：

```shell
docker stack ps getstartedlab
```

### 持久化数据

再次修改 docker-compose.yml 文件：

```shell
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      restart_policy:
        condition: on-failure
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
    ports:
      - "80:80"
    networks:
      - webnet
  visualizer:
    image: dockersamples/visualizer:stable
    ports:
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints: [node.role == manager]
    networks:
      - webnet
  redis:
    image: redis
    ports:
      - "6379:6379"
    volumes:
      - "/home/docker/data:/data"
    deploy:
      placement:
        constraints: [node.role == manager]
    command: redis-server --appendonly yes
    networks:
      - webnet
networks:
  webnet:
```

在manager上创建一个目录：

```shell
docker-machine ssh myvm1 "mkdir ./data"
```

确认你的shell已经被配置为和myvm1通信（完整示例参考这里：https://docs.docker.com/get-started/part4/#configure-a-docker-machine-shell-to-the-swarm-manager）


再次重新部署：

```shell
docker stack deploy -c docker-compose.yml getstartedlab
```

确认3个服务按照预期运行：

```shell
docker service ls
```

浏览器上查看： http://192.168.99.101， 可以看到visits成功增加了。

同时，可以查看IP地址对应的8080端口来查看redis，web和visualizer服务： http://192.168.99.100:8080.


### 总结和命令清单
略

# Part 6: 部署你的app

你可以部署你的app到aws或者其他云服务上。

该部分更多地和实际开发以及部署上线相关，略。

详见: https://docs.docker.com/get-started/part6/


# 至此，你对Docker已经有个基本的认识了。祝你学习愉快～

















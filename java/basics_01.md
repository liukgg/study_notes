第1章 JAVA语言与面向对象的程序设计
-------------------------------------------

参考资料：
https://www.coursera.org/learn/java-chengxu-sheji/home/welcome

# Java语言简介
- Java是最热门的语言之一
- 发展历程
 * 1990年 SUN “Green”
 * 1994 Oka 语言
 * 1995 Java语言，JDK 1.0
- James Gosling

### Java三大平台
- Java SE标准版
- Java EE企业版
- Java ME微型版

Java的开发工具包 JDK（Java Development Kit）

### Java8最重要的新特性
Lambda表达式

### What is Java
- 面向对象的编程语言 OOP
- 语法简单，类似C和C++

### Java语言特点
- 简单易学
- 面向对象
- 平台无关性
- 安全稳定
- 支持多线程

### 丰富的类库
Java提供了大量的类以满足网络化、多线程、面向对象系统的需要

### Java是C++--
- 无直接指针操作
- 自动内存管理
- 数据类型长度固定
- 不用头文件
- 不包含结构和联合
- 不支持宏
- 不用多重继承
- 无类外全局变量
- 无GOTO

### Java运行机制
- Java虚拟机 Java Virtual Machine
- 代码安全性检测 Code Security
- 垃圾回收机制 Garbage Collection

### Java程序的编译和运行
源程序－编译 javac － 字节码（bytecode），平台无关 － 运行Java － JVM

### JVM
JVM读取并处理经便已过的字节码class文件。
Java虚拟机规范定义了：
- 指令集
- 寄存器集
- 类文件结构
- 堆栈
- 垃圾收集堆
- 内存区域

### Java运行环境JRE(The Java Runtime Environment)
JRE = JVM + API(Lib)

JRE运行程序时的三项主要功能：
- 加载代码：由class loader完成
- 校验代码：由bytecode verifier完成
- 执行代码：由runtime interpreter完成

理解
- 为何Java是平台无关的
- 为何Java是安全的
参考：
http://www.cygnet-infotech.com/blog/key-features-that-make-java-more-secure-than-other-languages
https://stackoverflow.com/questions/14209887/why-java-is-secure-compared-with-other-programming-languages

### Java自动垃圾回收技术
- 系统级线程跟踪存储空间的分配情况
- 在JVM的空闲时，检查并释放那些可被释放的存储器空间
- 程序员无须也无法精确控制和干预该回收过程

### JDK
JDK = JRE + Tools
JRE = JVM + API

JDK提供的工具：
- java编译器 javac
- java执行器 java
- 文档生成器javadoc
- 打包器 jar
- java调试器 jdb

# 面向对象程序设计
### 对象,类（类时对象的抽象／模板，对象是类的实例）

### 面向对象的三大特征
封装性（模块化，信息隐蔽）
继承性（抽象&分类，代码重用，可维护性）
多态性

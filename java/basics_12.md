第12章 怎样写好程序
-------------------------------------------

参考资料：
https://www.coursera.org/learn/java-chengxu-sheji/home/welcome

# 写好程序的一些经验
- 写好单词、语句、函数、类
- 写简单函数： 卫语句降低层次，语句不要太多，层次不要太多，改变算法

# 重构
- 重命名，提取方法
- 代码的坏味道
名字不清楚
代码重复
代码过长
代码层次过多
- 如何保证代码正确性
使用JUnit测试
TDD

# 设计模式
## 分类
Creational Patterns
Structural Patterns
Behavioral Patterns

## 经典的23种模式
### 创建型
工厂方法 Factory Method
抽象工厂 Abstract Factory
生成器 Builder
原型 Prototype
单态 Singleton

### 结构型
适配器 Adapter
桥接 Bridge
组成 Composite
装饰 Decorator
外观 Facade
享元 Flyweight
代理 Proxy

### 行为型
解释器 Interpreter
模板方法 Temlate Method
责任链 Chain of Responsibility
命令 Command
迭代器 Iterator
中介者 Mediator
备忘录 Memento
观察者 Observer
状态 State
策略 Strategy
访问者 Visitor

### 设计模式的原则
SOLID

单一职责原则
开放封闭原则
替换原则
依赖倒置原则
接口隔离原则

### JDK中的设计模式
https://stackoverflow.com/questions/1673841/examples-of-gof-design-patterns-in-javas-core-libraries

#### 创建模式（Creational）
- SingleTon
 * 保证类只有1个实例；提供1个全局访问点
 * 只允许一个实例。这比Static要好（？）
 * java.lang.Runtime#getRuntime()
 * java.awt.Toolkit#getDefaultToolkit()
 * java.awt.Desktop#getDesktop()

- Factory(静态工厂)
 * 作用：1，代替构造函数创建对象；2，方法名比构造函数清晰。
 * 简单来说，按照需求返回一个类型的实例。
 * java.lang.Class#newInstance()
 * java.lang.Class#forName()
 * java.lang.reflect.Array#newInstance()
 * java.lang.reflect.Constructor#newInstance()

- Abstract factory
 * 作用：创建一组有关联的对象实例
 * java.sql.DriverManager#getConnection()
 * java.sql.Connection#createStatement()

#### 结构型（Structural）
- Adapter
 * 适配器作用：使不兼容的借口相容
 * java.io.InputStreadmReader(InputStream)
 * java.io.OutputStreamWriter(OutputStream)

- Composite

- Decorator

#### 行为型
- Observer
 * 通知对象状态改变
 * java.util.EventListener
 * btn.addActionListener(...)

# 反射
在运行状态中,对于任意一个类,都能够知道这个类的所有属性和方法;
对于任意一个对象,都能够调用它的任意一个方法和属性。

java.lang.reflect.*


# Annotation（注记，注解）
## JDK内置
- @Override
- @Deprecated
- @SuppressWarnings({"unchecked", "deprecation"})

## 自定义注记
- @interface来定义一个类型，表示它是一个注记

## 用反射来读取注记
- method.getAnnotation(注记.class)
- method.getAnnotaions()

Spark-Basics
==============

references
-------------------------------------------

http://www.hubwiz.com/class/5449c691e564e50960f1b7a9

Spark的核心抽象是一个分布式数据集，被称为弹性分布数据集（RDD） ，代表一个不可变的、可分区、可被并行处理 的成员集合。

RDD: resilient distributed dataset

basics
------------------------------------------

```shell
# spark-Shell后，就自动获得一个SparkContext对象实例，这个对象被存入变量sc。
sc

# 使用SparkContext对象（在Shell里，就是sc变量）的master方法，可以查看当前连接的集群管理器：
sc.master
```

### top，排序机制

```scala
scala> var textFile = sc.textFile("README.md")
textFile: org.apache.spark.rdd.RDD[String] = README.md MapPartitionsRDD[22] at textFile at <console>:38

scala> var rdd = textFile.map(_.split(" ").size)
rdd: org.apache.spark.rdd.RDD[Int] = MapPartitionsRDD[23] at map at <console>:40

scala> implicit val myOrd = implicitly[Ordering[Int]]
myOrd: Ordering[Int] = scala.math.Ordering$Int$@6f3b07ed

scala> rdd.top(5)
res20: Array[Int] = Array(14, 14, 13, 13, 13)

scala> implicit val myOrd = implicitly[Ordering[Int]].reverse
myOrd: scala.math.Ordering[Int] = scala.math.Ordering$$anon$4@4088f5f3

scala> rdd.top(5)
res21: Array[Int] = Array(1, 1, 1, 1, 1)
```

### 神奇的 _ 符号
http://stackoverflow.com/questions/26886275/how-to-find-max-value-in-pair-rdd

https://www.zhihu.com/question/32366168

map(_._2) 等价于 map(t => t._2) //t是个2项以上的元组
map(_._2, _) 等价与 map(t => t._2, t) //这会返回第二项为首后面项为旧元组的新元组
._n 为获取元组第n项
_ 则为eta-conversion (lambda表达式支持的一种变换 )的入参缩写形式，scala里 a => foo(a) 经过eta-conversion后，直接就是右边的函数名foo，缩写为foo(_)，这里t => t._2 (lambda表达式 ) 可直接写成 _._2

作者：夏梓耀
链接：https://www.zhihu.com/question/32366168/answer/55606609
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

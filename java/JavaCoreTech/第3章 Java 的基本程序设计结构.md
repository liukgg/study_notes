Java的基本程序设计结构（1）——示例、注释、数据类型、变量
-----------------
> Java学习笔记系列-02

>《Java核心技术卷I——基础知识》 第3章 Java的基本程序设计结构

>略去：第2章 Java程序设计环境（主要介绍了Java的下载、安装、启动等） 

> 《Core Java Volume I-Fundamentals(10th Edition) 》 Cay S.Horstmann

### 1 一个简单的Java应用程序
```java
public class FirstSample
{
    public static void main(String[] args)
    {
        System.out.println("We will not use 'Hello, World!'");
    }
}
```

- Java区分大小写。
- 关键字 public 称为访问修饰符(access modifier)，控制程序其他部分对这段代码的访问级別。
- 关键字 class 表明 Java 程序中的全部内容都包含在类中。
    - Java 应用程序中的全部内容都必须放置在类中。
- Java中定义类名必须以字母开头，后面可以跟字母和数字的任意组合。例：FirstSample
    - 标准的命名规范为: 类名是以大写字母开头的名词。多个单词的第一个字母都应该大写。
    - 骆驼命名法（CamelCase）。
- 源代码的文件名必须与公共类的名字相同，并用.java作为扩展名。例：FirstSample.java 
    - 再次提醒大家注意，大小写是非常重要的，千万不能写成firstsample.java
- 建议：把匹配的大括号上下对齐。
- Java 中的所有函數都属于某个类的方法(标准 术语将其称为方法， 而不是成员函数)。 
    - 因此， Java 中的 main 方法必须有一个外壳类。
- 在 Java 中， 每个句子必须用分号结束。
- Java 使用的通用语法是：object.method(parameters)
    - 这等价于函数调用。

### 2 注释
- 在 Java 中， 有 3 种标 记注释的方式。
- (1)最常用的方式是使用 //, 其注释内容从 // 开始到本行结尾。
- (2)当需要长篇的注释时，既可以在每行的注释前面标记/，/ 也可以使用/*和*/将一段比较长的注释括起来。
- (3)最后，第3种注释可以用来自动地生成文档。这种注释以 /**开始，以 */ 结束。
    ```java
      /**
       * This is the first sample program in Core Java Chapter 3
       * Aversion 1.01 1997-03-22
       * @author Gary Cornell
       */
      public class FirstSample
      {
          public static void main()
          {
              System.out.println("We will not use 'Hello, World!'");
          }
      }
    ```
  - 警告: 在 Java 中， /* */ 注释不能嵌套。也就是说，不能简单地把代码用 /* 和 */ 括起来
    作为注释， 因为这段代码本身可能也包含一个 */ ,
    
### 3 数据类型
  - Java是一种强类型语言。这就意味着必须为每一个变量声明一种类型。
  - 在Java中，一共共有 8 种基本类型 (primitive type)
    - 其中有 4 种整型
    - 2 种浮点类型
    - 1 种用于表示 Unicode 编码的字符单元的字符类型char
    - 1 种用于表示真值的 boolean 类型
 - 注意：大数值 big number 并不是一种新的Java类型，而是一个Java对象。
 
##### 整型
- 整型用于表示没有小数部分的数值，它允许是负数。Java 提供了 4 种整型。
    - 字节数从少到多依次是：byte，short，int，long

     类型|存储需求|取值范围
     |----|----|----|
     int|4字节|-2 147 483 648 ～ 2 147 483 647 ( 正好超过 20 亿 )
     short|2字节|-32 768 ～ 32 767
     long|8字节|-9223372036854775B08 ～ 9223372036854775807
     byte|1字节|-128 ～ 127
 
 - 在通常情况下，int类型最常用。
 - byte 和 short 类型主要用于特定的应用场合。
    - 例如，底层的文件处理或者需要控制占用存储空间量的大数组。
 - 在 Java 中，整型的范围与运行Java代码的机器无关。
    - 移植性：这就解决了跨平台/跨操作系统移植带来的诸多问题。
    - 与此相反， C 和 C++ 程序需要针对不同的处理器选择最为高效的整型
        - 这样就有可能造成一个在32位处理器上运行很好的C程序在16位系统上运行却发生整数溢出。
    - Java 程序必须保证 在所有机器上都能够得到相同的运行结果。
 - 长整型数值有一个后缀 L 或 l (如4000000000L) 。
    - 建议用：大写L，因为小写 l 和 1容易混淆。
 - 十六进制数值有一个前缀 Ox 或 0X；如 OxCAFEL 。
 - 八进制有一个前缀 0 , 例如，010 对应八进制中的 8。 
    - 显然，八进制表示法比较容易混淆，所以建议最好不要使用八进制常数。
 - 从Java 7开始，加上前缀 0b 或 0B 就可以写二进制数。例如，OblOO丨就是 9。 
 - 另外，同样是从Java 7开始，还可以为数字字面量加下划线
    - 如用1_000_000(或册1丨丨丨_0100_0丨0 0_丨0 00_0000) 表示一百万。 
    - 这些下划线只是为丫让人更易读。Java 编译器会去除这些下划线。
 - **注意，Java 没有任何无符号(unsigned) 形式的 int、long、short 或 byte 类型。**
 
 
##### 浮点类型
- 浮点类型用于表示有小数部分的数值。在 Java 中有两种浮点类型。

    类型|存储需求|取值范围
    |----|----|----|
    float|4字节|大约 ± 3.402 823 47E+38F (有效位数为 6 ~ 7 位)
    double|8字节|大约 ± 1.797 693 134 862 315 70E+308 (有效位数为 15 位>

- double 表示这种类型的数值精度是 float 类型的两倍(有人称之为双精度数值)。 
- **绝大部分应用程序都采用 double 类型。**
    - 在很多情况下， float 类型的精度很难满足需求。
    - 实际上，只有很少的情况适合使用 float 类型。例如，需要单精度数据的库，或者需要存储大量数据。
- float类型的数值有一个后缀F或f (例如，3.14F) 
    - **没有后缀F的浮点数值(如3.14) 默 认为 double 类型。**
    - 当然，也可以在浮点数值后面添加后缀 D 或 d (例如，3.14D)。
- 下面是用于表示溢出和出错情况的3个特殊的浮点数值。例如，一个正整数处以0的结果为正无穷大。计算0/0或者负数的平方根结果为NaN。
    - 正无穷大；常量Double_POSITIVE_INFINITY
    - 负无穷大；Double.NEGATIVEJNFINITY
    - NaN（不是一个数字）；Double.NaN ( 以及相应的 Float 类型的常量)
- 特别说明：
    - 不能这样检测一个特定值是否等于Double.NaN：
    ```java
      if (x = Double.NaN) // is never true
    ```
    - 所有“ 非数值” 的值都认为是不相同的。 然而， 可以使用 Double.isNaN 方法: 
      ```java
         if (Double.isNaN(x)) // check whether x is "not a number"  
      ```
- 警告:浮点数值不适用于无法接受舍入误差的金融计算中。
    - 例如，命令System.out.println ( 2.0-1.1 ) 将打印出 0.8999999999999999, 而不是人们想象的 0.9。
    - 这种舍入误差的主要 原因是浮点数值采用二进制系统表示， 而在二进制系统中无法精确地表示分数 1/10。
    - 这就好像十进制无法精确地表示分数 1/3 —样。
    - 如果在数值计算中不允许有任何舍入误差，就应该使用 BigDecimal 类。
    
##### char 类型
- **警告： 我们强烈建议不要在程序中使用 char 类型， 除非确实需要处理 UTF-16 代码单元。最好 将字符串作为抽象数据类型处理。**
- 在 Java 中， char 类型描述了 UTF-16 编码中的一个代码单元。
- char 类型原本用于表示单个字符。
    - 不过， 现在情况已经有所变化。
    - 如今， 有些 Unicode 字符可以用一个 char 值描述， 另外一些 Unicode 字符则需要两个 char 值。
- char 类型的字面量值要用单引号括起来。 
    - 例如: W 是编码值为 65 所对应的字符常量。
    - 它与"A"不同，"A"是包含一个字符A的字符串。
    - char类型的值可以表示为十六进制值，其范围从 \u0000 到 \Uffff 例如 W2122 表示注册符号 (TM), \u03C0 表示希腊字母pai。

##### Unicode和char类型
- 从 Java SE 5.0 开 始。 码 点 ( code point ) 是指与一个编码表中的某个字符对应的代码值。
- 在 Unicode 标准中， 码点采用十六进制书写，并加上前缀U+, 例如U+0041就是拉丁字母A的码点。
- Unicode的 码点可以分成 17 个代码级别(codeplane)。
- 第一个代码级别称为基本的多语言级别(basic multilingual plane ), 码点从 U+0000 到 U+FFFF , 其中包括经典的 Unicode 代码; 
- 其余的 16 个级别码点从U+10000到U+10FFFF, 其中包括一些辅助字符(supplementary character)。
- UTF-16 编码采用不同长度的编码表示所有 Unicode 码点。
- 在基本的多语言级别中， 每个字符用16位表示，通常被称为代码单元(codeunit); 
- 而辅助字符采用一对连续的代码单元进行编码。 
- 这样构成的编码值落人基本的多语言级别中空闲的 2048 字节内， 通常被称为替代区域(surrogate area) [U+D800 ~ U+DBFF 用于第一个代码单兀，U+DC00 ~ U+DFFF 用 于第二个代码单元]。
- 这样设计十分巧妙，我们可以从中迅速地知道一个代码单元是一个字 符的编码，还是一个辅助字符的第一或第二部分。

##### boolean 类型
- boolean ( 布尔)类型有两个值: false 和 true , 用来判定逻辑条件。
- 整型值和布尔值之间不能进行相互转换。
- C++注释：在C++中，数值甚至指针可以代替boolean值。值0相当于布尔值false, 非 0 值相当于布尔值 true , 在 Java 中则不是这样，因此， Java 程序员不会遇到下述麻烦:
    ```java
        if (x = 0) // oops... meant x = 0
        // 在 C++ 中这个测试可以编译运行， 其结果总是 false:。
        // 而在 Java 中， 这个测试将不 能通过编译， 其原因是整数表达式 x = 0 不能转换为布尔值。
    ```
  
  
### 变量
- 在Java中， 每个变量都有一个类型(type)。
- 在声明变量时，变量的类型位于变量名之前。 这里列举一些声明变量的示例:
    ```java
    double salary;
    int vacationDays; 
    long earthPopulation; 
    boolean done;
    ```
- 可以看到， 每个声明以分号结束。 由于声明是一条完整的 Java 语句， 所以必须以分号结束。
- 变量名必须是一个以字母开头并由字母或数字构成的序列。
- 需要注意，与大多数程序设计语言相比，Java中“字母”和“数字”的范围更大。
- 字母包括'A'~'Z'、'a1' ~'z'、'_'、'$'' 或在某种语言中表示字母的任何 Unicode 字符。
- 例如，希腊人可以用 pai。同样，数字包括 0 ~ 9 和在某种语言中表示数字的任何 Unicode 自字符。
- 但是 '+'这样的富豪不能出现在变量名中，空格也不行。
- 变量名中所有的字符都是有意义的，并且大小写敏感。
- 变量名的长度基本上没有限制。
- 提示: 如果想要知道哪些 Unicode 字符属于 Java 中的“ 字母”， 可以使用 Character 类的 isJavaldentifierStart 和 isJavaldentifierPart 方法来检查。
- 不能使用 Java 保留字作为变量名。
- 可以在一行中声明多个变量。不过，不提倡使用这种风格。逐一声明每一个变量可以提高程序的可读性。
  ```java
    int i, •]; // both are integers
  ```
##### 变量初始化
- 声明一个变量之后，必须用赋值语句对变量进行显式初始化，千万不要使用未初始化的变量。
- 例如， Java 编译器认为下面的语句序列是错误的:
```java
int vacationDays;
System.out.println(vacationDays): // ERROR variable not initialized
```
- 要想对一个已经声明过的变量进行赋值， 就需要将变量名放在等号(=) 左侧， 相应取值 的 Java 表达式放在等号的右侧。
  ```java 
  int vacationDays; 
  vacationDays = 12;
  ```
- 也可以将变量的声明和初始化放在同一行中。 例如:
```java
  int vacationDays = 12;
```
- 在 Java 中可以将声明放在代码中的任何地方。
- 在 Java 中， 变量的声明尽可能地靠近变量第一次使用的地方， 这是一种良好的程序编写 风格。

##### 常量
- 在 Java 中， 利用关键字 final 指示常量。例如：
```java
public class Constants
{
    public static void main(String[] args)
    {
        final double CM_PER_INCH = 2.54;
        double paperWidth = 8.5;
        double paperHeight = 11;
        //System.out.println("hello");
        System.out.println("Paper size in centimeters:"
                + paperWidth * CM_PER_INCH + " by " + paperHeight * CM_PER_INCH);
    }
}
```
- 关键字 final 表示这个变量只能被赋值一次。一旦被赋值之后， 就不能够再更改了。
- 习惯上, 常量名使用全大写。

- 在 Java 中， 经常希望某个常量可以在一个类中的多个方法中使用， 通常将这些常量称为类常量。
- 可以使用关键字 static final 设置一个类常量。 下面是使用类常量的示例:

```java
public class Constants2
{
    public static final double CM_PER_INCH = 2.54;

    public static void main(String[] args)
    {
        double paperWidth = 8.5;
        double paperHeight = 11; 
        System,out.println("Paper size in centimeters: "
            + paperWidth * CM_PER_INCH + " by " + paperHeight * CM_PER_INCH);
    }
}
```
- 需要注意， 类常量的定义位于 main方法的外部。 因此， 在同一个类的其他方法中也可 以使用这个常量。 
- 而且， 如果一个常量被声明为 public，那么其他类的方法也可以使用这个常量。 在这个示例中，Constants2.CM_PER-INCH 就是这样一个常童。
- C++ 注释: const 是 Java 保留的关键字， 但目前并没有使用。 在 Java 中， 必须使用 final 定义常量。





  
 
 
 
 
 
 
 
 
    
    

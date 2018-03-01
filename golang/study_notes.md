Go语言学习笔记
------------------------------------------

https://tour.golang.org

# 包，变量和函数
- Packages 包
 * 程序从main包开始执行

- Imports 导入

- Exported names 对外输出的名字
 * Go语言中以大写字母开头的名字被对外输出
 * import一个包的时候，只能引用其对外输出的名字

- Functions 函数
 * 注意，参数类型在参数变量名称之后
 * 关于这么设计的原因说明：https://blog.golang.org/gos-declaration-syntax
 * 类型相同的多个连续变量，可以只需要保留最后一个变量的类型
 * 函数返回值数量可以是任意多个
 * 具名返回值，裸返回

- Variables 变量
 * 初始化，有初始值时可以省略类型
 * 简短变量声明， :=
 * 在函数外面，所有声明必须以var和func等关键字开头，所以:=不可用


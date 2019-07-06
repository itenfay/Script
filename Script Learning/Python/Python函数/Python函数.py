#!/usr/bin/python
#coding=utf-8

#函数是组织好的，可重复使用的，用来实现单一，或相关联功能的代码段。
#函数能提高应用的模块性，和代码的重复利用率。你已经知道Python提供了许多内建函数，比如print()。
#但你也可以自己创建函数，这被叫做用户自定义函数。

#定义一个函数
#你可以定义一个由自己想要功能的函数，以下是简单的规则：
#函数代码块以def关键词开头，后接函数标识符名称和圆括号()。
#任何传入参数和自变量必须放在圆括号中间。圆括号之间可以用于定义参数。
#函数的第一行语句可以选择性地使用文档字符串—用于存放函数说明。
#函数内容以冒号起始，并且缩进。
#Return[expression]结束函数，选择性地返回一个值给调用方。不带表达式的return相当于返回 None。
#语法
#def functionname( parameters ):
#    "函数_文档字符串"
#    function_suite
#    return [expression]
#默认情况下，参数值和参数名称是按函数声明中定义的的顺序匹配起来的。

import math

#打印传入的字符串到标准显示设备上
def printme( str ):
    print str
    return

printme("Hello World!")
printme("调用printme()");

#修改传入的列表
def changeme( list ):
    list.append([1, 2, 3, 4])
    print "函数内取值: ", list
    return

mylist = [10, 20, 30]
changeme(mylist)
print "函数外取值: ", mylist
#传入函数的和在末尾添加新内容的对象用的是同一个引用。故输出结果如下：
#函数内取值:  [10, 20, 30, [1, 2, 3, 4]]
#函数外取值:  [10, 20, 30, [1, 2, 3, 4]]

#参数
#以下是调用函数时可使用的正式参数类型：
#必备参数
#命名参数
#缺省参数
#不定长参数

#必备参数
#必备参数须以正确的顺序传入函数。调用时的数量必须和声明时的一样。
#调用printme()函数，你必须传入一个参数，不然会出现语法错误：

#命名参数
#命名参数和函数调用关系紧密，调用方用参数的命名确定传入的参数值。
#你可以跳过不传的参数或者乱序传参，因为Python解释器能够用参数名匹配参数值。
#用命名参数调用printme()函数：
printme(str = "My string")

def printinfo(name, age = 20):
    print "Name: ", name
    print "Age: ", age
    return

printinfo(age = 45, name = "miki")

#缺省参数
#调用函数时，缺省参数的值如果没有传入，则被认为是默认值。
#下例会打印默认的age，如果age没有被传入：
printinfo(name = "miki")

#定长参数
#你可能需要一个函数能处理比当初声明时更多的参数。
#这些参数叫做不定长参数，和上述2种参数不同，声明时不会命名。基本语法如下：
#def functionname([formal_args,] *var_args_tuple ):
#    "函数_文档字符串"
#    function_suite
#    return [expression]

#打印任何传入的参数
def printinfo2(arg, *vartuple):
    print "输出："
    print arg
    for var in vartuple:
        print var
    return True

ret = printinfo2(20, 60, 50, "miki")

if ret:
    print "Result: %d" % ret

def outputToConsole(*args):
    for arg in args:
        print arg
    return

print outputToConsole("Hello", "miki", "How are you?")

#匿名函数
#python 使用 lambda 来创建匿名函数。
#lambda只是一个表达式，函数体比def简单很多。
#lambda的主体是一个表达式，而不是一个代码块。仅仅能在lambda表达式中封装有限的逻辑进去。
#lambda函数拥有自己的名字空间，且不能访问自有参数列表之外或全局名字空间里的参数。
#虽然lambda函数看起来只能写一行，却不等同于C或C++的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率。

#加法
sum = lambda arg1, arg2: arg1 + arg2

#调用sum函数
print "相加后的值为: ", sum(10, 20)

#return语句
#return语句[表达式]退出函数，选择性地向调用方返回一个表达式。不带参数值的return语句返回None。

#变量作用域
#一个程序的所有的变量并不是在哪个位置都可以访问的。访问权限决定于这个变量是在哪里赋值的。
#变量的作用域决定了在哪一部分程序你可以访问哪个特定的变量名称。两种最基本的变量作用域如下：
#全局变量
#局部变量
#变量和局部变量
#定义在函数内部的变量拥有一个局部作用域，定义在函数外的拥有全局作用域。
#局部变量只能在其被声明的函数内部访问，而全局变量可以在整个程序范围内访问。
#调用函数时，所有在函数内声明的变量名称都将被加入到作用域中。如下实例：

total = 0 #全局变量
def sum2(arg1, arg2):
    total = arg1 + arg2 # total在这里是局部变量.
    print "函数内部局部变量：", total
    return total

sum2(2, 10)

print "函数外全局变量：", total


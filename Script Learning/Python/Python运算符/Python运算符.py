#!/usr/bin/python
# _*_ coding: UTF-8 _*_

#Python算术运算符
#运算符	描述                                           实例
#+      加 - 两个对象相加                                a + b 输出结果 30
#-      减 - 得到负数或是一个数减去另一个数                 a - b 输出结果 -10
#*      乘 - 两个数相乘或是返回一个被重复若干次的字符串       a * b 输出结果 200
#/      除 - x除以y                                     b / a 输出结果 2
#%      取模 - 返回除法的余数                             b % a 输出结果 0
#**     幂 - 返回x的y次幂                                a**b 为10的20次方， 输出结果 100000000000000000000
#//     取整除 - 返回商的整数部分                          9//2 输出结果 4 , 9.0//2.0 输出结果 4.0

a = 21
b = 10
c = 0

c = a + b
print "a + b = ", c

c = a - b
print "a - b = ", c

c = a * b
print "a * b = ", c

c= a / b
print "a / b = ", c

c = a % b
print "a % b = ", c

c = b**2
print "b^2 = ", c

c = a//b
print "a//b = ", c

#Python比较运算符
#以下假设变量a为10，变量b为20：
#运算符	描述                               实例
#==     等于 - 比较对象是否相等              (a == b) 返回 False。
#!=     不等于 - 比较两个对象是否不相等       (a != b) 返回 true.
#<>     不等于 - 比较两个对象是否不相等       (a <> b) 返回 true。这个运算符类似 != 。
#>      大于 - 返回x是否大于y               (a > b) 返回 False。
#<      小于 - 返回x是否小于y。
#       所有比较运算符返回1表示真，返回0表示假。
#       这分别与特殊的变量True和False等价。
#       注意，这些变量名的大写。               (a < b) 返回 true。
#>=     大于等于	- 返回x是否大于等于y。        (a >= b) 返回 False。
#<=     小于等于 -	返回x是否小于等于y。      (a <= b) 返回 true。

if a == b :
    print "a is equal to b"

if a != b :
    print "a is not equal to b"

if a >= b :
    print "a is greater than or equal to b"

#Python赋值运算符
#以下假设变量a为10，变量b为20：
#运算符	描述              实例
#=       简单的赋值运算符	 c = a + b 将 a + b 的运算结果赋值为 c
#+=      加法赋值运算符     c += a 等效于 c = c + a
#-=      减法赋值运算符     c -= a 等效于 c = c - a
#*=      乘法赋值运算符     c *= a 等效于 c = c * a
#/=      除法赋值运算符     c /= a 等效于 c = c / a
#%=      取模赋值运算符     c %= a 等效于 c = c % a
#**=     幂赋值运算符       c **= a 等效于 c = c ** a
#//=     取整除赋值运算符	 c //= a 等效于 c = c // a

b *= a
print "b *= a -> ", b

#Python逻辑运算符
#Python语言支持逻辑运算符，以下假设变量a为10，变量b为20：
#运算符	描述                                                          实例
#and     布尔"与" - 如果x为False，x and y返回False，否则它返回y的计算值。	(a and b) 返回 true。
#or      布尔"或"	- 如果x是True，它返回True，否则它返回y的计算值。          (a or b) 返回 true。
#not     布尔"非" - 如果x为True，返回False。如果x为False，它返回True。     not(a and b) 返回 false。

a = True
b = False
if a and b :
    print "and -> true"
else :
    print "and -> false"

if a or b :
    print "or -> true"

if not b :
    print "not -> true"

#Python位运算符
#按位运算符是把数字看作二进制来进行计算的。Python中的按位运算法则如下：
#下表中变量 a 为 60，b 为 13。
#运算符	描述      实例
#&	按位与运算符：参与运算的两个值,如果两个相应位都为1,则该位的结果为1,否则为0	(a & b) 输出结果 12 ，二进制解释： 0000 1100
#|	按位或运算符：只要对应的二个二进位有一个为1时，结果位就为1。	(a | b) 输出结果 61 ，二进制解释： 0011 1101
#^	按位异或运算符：当两对应的二进位相异时，结果为1	(a ^ b) 输出结果 49 ，二进制解释： 0011 0001
#~	按位取反运算符：对数据的每个二进制位取反,即把1变为0,把0变为1	(~a ) 输出结果 -61 ，二进制解释： 1100 0011， 在一个有符号二进制数的补码形式。
#<<	左移动运算符：运算数的各二进位全部左移若干位，由"<<"右边的数指定移动的位数，高位丢弃，低位补0。	a << 2 输出结果 240 ，二进制解释： 1111 0000
#>>	右移动运算符：把">>"左边的运算数的各二进位全部右移若干位，">>"右边的数指定移动的位数	a >> 2 输出结果 15 ，二进制解释： 0000 1111

#python成员运算符
#除了以上的一些运算符之外，Python还支持成员运算符，测试实例中包含了一系列的成员，包括字符串，列表或元组。
#运算符	描述                                             实例
#in      如果在指定的序列中找到值返回True，否则返回False。      x 在 y序列中 , 如果x在y序列中返回True。
#not in	如果在指定的序列中没有找到值返回True，否则返回False。	x 不在 y序列中 , 如果x不在y序列中返回True。

list = [10, 2, 20, "Joe"]
print "list -> ", list

if a in list :
    print "a is in list"
else :
    print "a is not in list"

if b not in list:
    print "b is in list"

#Python身份运算符
#身份运算符用于比较两个对象的存储单元
#运算符	描述                                     实例
#is      is是判断两个标识符是不是引用自一个对象        x is y, 如果 id(x) 等于 id(y) , is 返回结果 1
#is not	is not是判断两个标识符是不是引用自不同对象    x is not y, 如果 id(x) 不等于 id(y). is not 返回结果 1

e = 20
f = 20

if e is f:
    print e, " is ", f

if e is not f:
    print e, " is not ", f

#Python运算符优先级
#以下表格列出了从最高到最低优先级的所有运算符：
#运算符                       描述
#**                          指数 (最高优先级)
#~ + -                       按位翻转, 一元加号和减号 (最后两个的方法名为 +@ 和 -@)
#* / % //                    乘，除，取模和取整除
#+ -                         加法减法
#>> <<                       右移，左移运算符
#&                           位 'AND'
#^ |                         位运算符
#<= < > >=                   比较运算符
#<> == !=                    等于运算符
#= %= /= //= -= += *= **=	赋值运算符
#is is not                   身份运算符
#in not in                   成员运算符
#not or and                  逻辑运算符



#!/usr/bin/python
#coding=utf-8

#Python 条件语句
#Python条件语句是通过一条或多条语句的执行结果（True或者False）来决定执行的代码块。

#Python 编程中 if 语句用于控制程序的执行，基本形式为：
#if 判断条件：
#    执行语句……
#else：
#    执行语句……

#当判断条件为多个值是，可以使用以下形式：
#if 判断条件1:
#    执行语句1……
#elif 判断条件2:
#    执行语句2……
#elif 判断条件3:
#    执行语句3……
#else:
#    执行语句4……

#简单的语句组
#你也可以在同一行的位置上使用if条件判断语句，如下实例：
#if 判断条件：执行语句……

num = 3

if num: print "num is ", num

if num < 5:
    print "T"
elif num < 2:
    print "B"
elif num < 1:
    print "G"
else:
    print "O"

#Python 循环语句
#Python提供了for循环和while循环（在Python中没有do..while循环）:
#循环类型        描述
#while 循环	   在给定的判断条件为 true 时执行循环体，否则退出循环体。
#for 循环       重复执行语句
#嵌套循环       你可以在while循环体中嵌套for循环
#
#循环控制语句
#循环控制语句可以更改语句执行的顺序。Python支持以下循环控制语句：
#控制语句          描述
#break 语句       在语句块执行过程中终止循环，并且跳出整个循环
#continue 语句	 在语句块执行过程中终止当前循环，跳出该次循环，执行下一次循环。
#pass 语句        pass是空语句，是为了保持程序结构的完整性。

#Python While循环语句
#Python 编程中 while 语句用于循环执行程序，即在某条件下，循环执行某段程序，以处理需要重复处理的相同任务。
#其基本形式为：
#while 判断条件：
#    执行语句……
#执行语句可以是单个语句或语句块。判断条件可以是任何表达式，任何非零、或非空（null）的值均为true。
#当判断条件假false时，循环结束。

count = 0
while count < 9:
    print "The count is: ", count
    count += 1

print "End counting!"

#无限循环
#while True:
#    count += 1
#    print "The count is: ", count

#简单语句组
#类似if语句的语法，如果你的while循环体中只有一条语句，你可以将该语句与while写在同一行中， 如下所示：
##!/usr/bin/python
#
#flag = 1
#
#while (flag): print 'Given flag is really true!'
#
#print "Good bye!"

#循环使用 else 语句
#在 python 中，for … else 表示这样的意思，for 中的语句和普通的没有区别，
#else 中的语句会在循环正常执行完（即 for 不是通过 break 跳出而中断的）的情况下执行，while … else 也是一样。

loop = 20
while loop >= 10:
    print "loopIdx is :", loop
    loop -= 1
else:
    print "The loop end"

#Python for 循环语句
#Python for循环可以遍历任何序列的项目，如一个列表或者一个字符串。
#语法：
#for循环的语法格式如下：
#for iterating_var in sequence:
#    statements(s)

for letter in 'python':
    print '当前字母：', letter

#通过序列索引迭代
#另外一种执行循环的遍历方式是通过索引，如下实例：
fruits = ['banana', 'apple', 'mango']

for fruit in fruits:
    print '当前水果：', fruit

for idx in range(len(fruits)):
    print '当前水果：', fruits[idx]

#循环使用 else 语句
#在 python 中，for … else 表示这样的意思，for 中的语句和普通的没有区别，
#else 中的语句会在循环正常执行完（即 for 不是通过 break 跳出而中断的）的情况下执行，while … else 也是一样

#Python 循环嵌套
#Python 语言允许在一个循环体里面嵌入另一个循环。

for num in range(10, 20):
    for i in range(2, num):
        if num % i == 0:
            j = num / i
            print '%d 等于 %d * %d' % (num,i,j)
            #print num, '等于', i * j
            break
    else:
        print num, "是一个质数"

#Python break 语句
#Python break语句，就像在C语言中，打破了最小封闭for或while循环。
#break语句用来终止循环语句，即循环条件没有False条件或者序列还没被完全递归完，也会停止执行循环语句。
#break语句用在while和for循环中。
#如果您使用嵌套循环，break语句将停止执行最深层的循环，并开始执行下一行代码。
#Python语言 break 语句语法：break

for letter in 'Python':     # First Example
    if letter == 't':
        print '\n'
        break
    print 'Current Letter :', letter

#Python continue 语句
#Python continue 语句跳出本次循环，而break跳出整个循环。
#continue 语句用来告诉Python跳过当前循环的剩余语句，然后继续进行下一轮循环。
#continue语句用在while和for循环中。
#Python 语言 continue 语句语法格式如下：continue

for letter in 'Python':     # First Example
    if letter == 't':
        continue
    print 'Current Letter :', letter

print '\n'

#Python pass 语句
#Python pass是空语句，是为了保持程序结构的完整性。
#passass 不做任何事情，一般用做占位语句。
#Python 语言 pass 语句语法格式如下：pass

for letter in 'Python':     # First Example
    if letter == 't':
        pass
        print "pass块，占位语句"
    print 'Current Letter :', letter



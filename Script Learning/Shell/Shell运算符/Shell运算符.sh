#!/bin/sh

#Bash 支持很多运算符，包括算数运算符、关系运算符、布尔运算符、字符串运算符和文件测试运算符。
#原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。
#expr 是一款表达式计算工具，使用它能完成表达式的求值操作。

#乘号(*)前边必须加反斜杠(\)才能实现乘法运算；
#if...then...fi 是条件语句，后续将会讲解。

#算术运算符列表
#运算符	说明	举例
#+	加法	`expr $a + $b` 结果为 30。
#-	减法	`expr $a - $b` 结果为 10。
#*	乘法	`expr $a \* $b` 结果为  200。
#/	除法	`expr $b / $a` 结果为 2。
#%	取余	`expr $b % $a` 结果为 0。
#=	赋值	a=$b 将把变量 b 的值赋给 a。
#==	相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。
#!=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。
#注意：条件表达式要放在方括号之间，并且要有空格，例如 [$a==$b] 是错误的，必须写成 [ $a == $b ]。

a=10

b=20

c=`expr $a \* $b`

echo "a * b is $c"


#关系运算符列表
#运算符	说明	举例
#-eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 true。
#-ne	检测两个数是否相等，不相等返回 true。	[ $a -ne $b ] 返回 true。
#-gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。
#-lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。
#-ge	检测左边的数是否大等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。
#-le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。

if [ $a -ne $b ]
then
	echo "a != b"
else
	echo " a == b"
fi


#布尔运算符列表
#运算符	说明	举例
#!	非运算，表达式为 true 则返回 false，否则返回 true。	[ ! false ] 返回 true。
#-o	或运算，有一个表达式为 true 则返回 true。	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
#-a	与运算，两个表达式都为 true 才返回 true。	[ $a -lt 20 -a $b -gt 100 ] 返回 false。


if [ $a != 0 -a $b -ge 30 ]
then
	echo "a != 0 且 b <= 30"
else
	echo "a == 0 或 b > 30"
fi


#字符串运算符列表
#运算符	说明	举例
#=	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。
#!=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。
#-z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。
#-n	检测字符串长度是否为0，不为0返回 true。	[ -z $a ] 返回 true。
#str	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true

str=""
echo $str

if [ "a" == "a" ]
then
	echo "==: 两个字符串相等."
fi

if [ "a" = "a" ]
then
echo "=: 两个字符串相等."
fi

#文件测试运算符列表
#操作符	说明	举例
#-b file	检测文件是否是块设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
#-c file	检测文件是否是字符设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
#-d file	检测文件是否是目录，如果是，则返回 true。	[ -d $file ] 返回 false。
#-f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。	[ -f $file ] 返回 true。
#-g file	检测文件是否设置了 SGID 位，如果是，则返回 true。	[ -g $file ] 返回 false。
#-k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。	[ -k $file ] 返回 false。
#-p file	检测文件是否是具名管道，如果是，则返回 true。	[ -p $file ] 返回 false。
#-u file	检测文件是否设置了 SUID 位，如果是，则返回 true。	[ -u $file ] 返回 false。
#-r file	检测文件是否可读，如果是，则返回 true。	[ -r $file ] 返回 true。
#-w file	检测文件是否可写，如果是，则返回 true。	[ -w $file ] 返回 true。
#-x file	检测文件是否可执行，如果是，则返回 true。	[ -x $file ] 返回 true。
#-s file	检测文件是否为空（文件大小是否大于0），不为空返回 true。	[ -s $file ] 返回 true。
#-e file	检测文件（包括目录）是否存在，如果是，则返回 true。	[ -e $file ] 返回 true。

path=`pwd`
file_path="${path}/tesh.sh"
echo "file_path : "$file_path

if [ -e $file_path ]
then
	echo "文件存在！"
else
	echo "文件不存在！"
fi



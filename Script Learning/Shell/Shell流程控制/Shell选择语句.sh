#!/bin/sh

#if 语句通过关系运算符判断表达式的真假来决定执行哪个分支。Shell 有三种 if ... else 语句：
#if ... fi 语句；
#if ... else ... fi 语句；
#if ... elif ... else ... fi 语句。

a=10
b=20

#1) if ... else 语句
#if ... else 语句的语法：
#if [ expression ]
#then
#Statement(s) to be executed if expression is true
#fi
#如果 expression 返回 true，then 后边的语句将会被执行；如果返回 false，不会执行任何语句。
#最后必须以 fi 来结尾闭合 if，fi 就是 if 倒过来拼写，后面也会遇见。
#注意：expression 和方括号([ ])之间必须有空格，否则会有语法错误。

if [ $a == $b ]
then
	echo "a is equal to b"
fi

if [ $a != $b ]
then
	echo "a is not equal to b"
fi


#2) if ... else ... fi 语句
#if ... else ... fi 语句的语法：
#if [ expression ]
#then
#Statement(s) to be executed if expression is true
#else
#Statement(s) to be executed if expression is not true
#fi
#如果 expression 返回 true，那么 then 后边的语句将会被执行；否则，执行 else 后边的语句。

if [ $a == $b ]
then
	echo "a is equal to b"
else
	echo "a is not equal to b"
fi


#3) if ... elif ... fi 语句
#if ... elif ... fi 语句可以对多个条件进行判断，语法为：
#if [ expression 1 ]
#then
#Statement(s) to be executed if expression 1 is true
#elif [ expression 2 ]
#then
#Statement(s) to be executed if expression 2 is true
#elif [ expression 3 ]
#then
#Statement(s) to be executed if expression 3 is true
#else
#Statement(s) to be executed if no expression is true
#fi
#哪一个 expression 的值为 true，就执行哪个 expression 后面的语句；如果都为 false，那么不执行任何语句。

if [ $a == $b ]
then
	echo "a is equal to b"
elif [ $a -gt $b ]
then
	echo "a is greater than b"
elif [ $a -lt $b ]
then
	echo "a is less than b"
else
	echo "None of the condition met"
fi

#if ... else 语句也可以写成一行，以命令的方式来运行，像这样：
if test $[2*3] -eq $[1+5]; then echo "The two numbers are equal!"; fi;

#if ... else 语句也经常与 test 命令结合使用，如下所示：
num1=$[2*3]
num2=$[1+5]
#test 命令用于检查某个条件是否成立，与方括号([ ])类似。
if test $[num1] -eq $[num2]
then
	echo "The two numbers are equal!"
else
	echo "The two numbers are not equal!"
fi

#case ... esac 与其他语言中的 switch ... case 语句类似，是一种多分枝选择结构。
#case 语句匹配一个值或一个模式，如果匹配成功，执行相匹配的命令。case语句格式如下：
#case 值 in
#模式1)
#command1
#command2
#command3
#;;
#模式2）
#command1
#command2
#command3
#;;
#*)
#command1
#command2
#command3
#;;
#esac
#case工作方式如上所示。取值后面必须为关键字 in，每一模式必须以右括号结束。取值可以为变量或常数。
#匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;。;; 与其他语言中的 break 类似，意思是跳到整个 case 语句的最后。
#
#取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。
#如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。

echo 'Input a number between 1 to 4'
echo 'Your number is: \c'
read num
case $num in
	1)  echo "You select 1"
	;;
	2)  echo "You select 2"
	;;
	3)  echo "You select 3"
	;;
	4)  echo "You select 4"
	;;
	*)  echo "You do not select a number between 1 to 4"
	;;
esac

option="${1}"
case ${option} in
	-f) FILE="${2}"
		echo "File name is $FILE"
		;;
	-d) DIR="${2}"
		echo "Dir name is $DIR"
		;;
	*)
		echo "`basename ${0}`:usage: [-f file] | [-d directory]"
		exit 1 # Command to come out of the program with status 1
esac





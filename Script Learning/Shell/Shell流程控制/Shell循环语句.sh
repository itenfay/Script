#!/bin/sh

#与其他编程语言类似，Shell支持for循环。
#for循环一般格式为：
#for 变量 in 列表
#do
#command1
#command2
#...
#commandN
#done
#列表是一组值（数字、字符串等）组成的序列，每个值通过空格分隔。每循环一次，就将列表中的下一个值赋给变量。
#in 列表是可选的，如果不用它，for 循环使用命令行的位置参数。

#例如，顺序输出当前列表中的数字：

for loop in 1 2 3 4 5
do
	echo "The value is $loop"
done

#顺序输出字符串中的字符：

for str in 'This is a string'
do
	echo "$str"
done

#显示主目录下以 .bash 开头的文件：
for file in $HOME/.bash*
do
	echo $file
done


#while循环用于不断执行一系列命令，也用于从输入文件中读取数据；命令通常为测试条件。其格式为：
#while command
#do
#Statement(s) to be executed if command is true
#done
#命令执行完毕，控制返回循环顶部，从头开始直至测试条件为假。


#以下是一个基本的while循环，测试条件是：如果COUNTER小于5，那么返回 true。
#COUNTER从0开始，每次循环处理时，COUNTER加1。运行上述脚本，返回数字1到5，然后终止。

counter=0
while [ $counter -lt 5 ]
do
	counter=`expr $counter + 1`
	echo $counter
done

#while循环可用于读取键盘信息。
#下面的例子中，输入信息被设置为变量FILM，按<Ctrl-D>结束循环。
echo 'type <CTRL-D> to terminate'
echo -n 'enter your most liked film: '
while read FILM
do
	echo "Yeah! great film is $FILM"
	break
done

#until 循环执行一系列命令直至条件为 true 时停止。until 循环与 while 循环在处理方式上刚好相反。
#一般while循环优于until循环，但在某些时候，也只是极少数情况下，until 循环更加有用。
#until 循环格式为：
#until command
#do
#Statement(s) to be executed until command is true
#done
#command 一般为条件表达式，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环。

#例如，使用 until 命令输出 0 ~ 9 的数字：
a=0
until [ ! $a -lt 10 ]
do
	echo $a
	a=`expr $a + 1`
done

#在循环过程中，有时候需要在未达到循环结束条件时强制跳出循环，像大多数编程语言一样，
#Shell也使用 break 和 continue 来跳出循环。

#break命令
#break命令允许跳出所有循环（终止执行后面的所有循环）。

#下面的例子中，脚本进入死循环直至用户输入数字大于5。要跳出这个循环，返回到shell提示符下，就要使用break命令。

while :
do
	echo -n "Input a number between 1 to 5: "
	read num
	case $num in
	1|2|3|4|5) echo "Your number is $num!"
	;;
	*) echo "You do not select a number between 1 to 5, game is over!"
		break
	;;
	esac
done

#continue命令
#continue命令与break命令类似，只有一点差别，它不会跳出所有循环，仅仅跳出当前循环。

NUMS="1 2 3 4 5 6 7"
for NUM in $NUMS
do
	Q=`expr $NUM % 2`
	if [ $Q -eq 0 ]
	then
		echo "Number is an even number!!"
		continue
	fi
	echo "Found odd number"
done


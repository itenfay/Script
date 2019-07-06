#!/bin/sh

#字符串是shell编程中最常用最有用的数据类型（除了数字和字符串，也没啥其它类型好用了），
#字符串可以用单引号，也可以用双引号，也可以不用引号。单双引号的区别跟PHP类似。

#单引号
str='this is a string'
#单引号字符串的限制：
#单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
#单引号字串中不能出现单引号（对单引号使用转义符后也不行）。

#双引号
#双引号的优点：
#双引号里可以有变量
#双引号里可以出现转义字符

your_name="qinjx"
str="Hello, I know your are \"${your_name}\" \n"

echo $str

#拼接字符串
greeting="hello, $your_name !"

echo $greeting

#获取字符串长度
echo ${#greeting}

#提取子字符串
echo ${greeting: 1:8}

#查找子字符串
string="alibaba is a great company"
#echo `expr index $string is`
#echo `expr match "$stringZ" is`

ret=`echo $string | grep -e "com" -o`
echo "ret : "$ret
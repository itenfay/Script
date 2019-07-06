#!/bin/sh

#如果表达式中包含特殊字符，Shell 将会进行替换。例如，在双引号中使用变量就是一种替换，转义字符也是一种替换。

a=10

echo -e "Value of a is $a \n"

#这里 -e 表示对转义字符进行替换。如果不使用 -e 选项，将会原样输出：

#下面的转义字符都可以用在 echo 中：
#转义字符	含义
#\\	反斜杠
#\a	警报，响铃
#\b	退格（删除键）
#\f	换页(FF)，将当前位置移到下页开头
#\n	换行
#\r	回车
#\t	水平制表符（tab键）
#\v	垂直制表符
#可以使用 echo 命令的 -E 选项禁止转义，默认也是不转义的；使用 -n 选项可以禁止插入换行符。

#命令替换
#命令替换是指Shell可以先执行命令，将输出结果暂时保存，在适当的地方输出。
#命令替换的语法：
#`command`
#注意是反引号，不是单引号，这个键位于 Esc 键下方。

DATE=`date`
echo "Date is $DATE"

USERS=`who | wc -l`
echo "Logged in user are $USERS"

UP=`date ; uptime`
echo "Uptime is $UP"

#变量替换
#变量替换可以根据变量的状态（是否为空、是否定义等）来改变它的值
#可以使用的变量替换形式：
#形式	说明
#${var}	变量本来的值
#${var:-word}	如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值。
#${var:=word}	如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word。
#${var:?message}	如果变量 var 为空或已被删除(unset)，那么将消息 message 送到标准错误输出，可以用来检测变量 var 是否可以被正常赋值。
#若此替换出现在Shell脚本中，那么脚本将停止运行。
#${var:+word}	如果变量 var 被定义，那么返回 word，但不改变 var 的值。

echo ${var:-"Variable is not set"}
echo "1 - Value of var is ${var}"

echo ${var:="Variable is not set"}
echo "2 - Value of var is ${var}"

unset var
echo ${var:+"This is default value"}
echo "3 - Value of var is $var"

var="Prefix"
echo ${var:+"This is default value"}
echo "4 - Value of var is $var"

echo ${var:?"Print this message"}
echo "5 - Value of var is ${var}"






#!/bin/sh

#echo是Shell的一个内部指令，用于在屏幕上打印出指定的字符串。命令格式：
#echo arg
#您可以使用echo实现更复杂的输出格式控制。

#显示转义字符
echo "\"It is a test\""
#结果："It is a test"

#显示变量
name="Ajax"
echo "$name, it is a test"

#如果变量与其它字符相连的话，需要使用大括号（{ }）：
mouth=3
echo "${mouth}-7-2016"

#显示换行
echo "OK!\n"

#显示结果重定向至文件
echo "It is a test" > file

#原样输出字符串
#若需要原样输出字符串（不进行转义），请使用单引号。例如
echo '$name\"'

#显示命令执行结果
echo `date`
#结果将显示当前日期

#双引号可有可无，单引号主要用在原样输出中


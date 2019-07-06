#!/usr/bin/Python
#coding=utf-8

#或 # _*_ coding: UTF-8 _*_

print "你好，世界！"

#Python 文件中如果未指定编码，在执行过程会出现报错：
#SyntaxError: Non-ASCII character '\xe4' in file ./Python中文编码.py on line 3, but no encoding declared; see http://python.org/dev/peps/pep-0263/ for details

#python中默认的编码格式是 ASCII 格式，在没修改编码格式时无法正确打印汉字，所以在读取中文时会报错。
#解决方法为只要在文件开头加入 # -*- coding: UTF-8 -*- 或者 #coding=utf-8 就行了。

#所以如果大家再学习过程中，代码中包含中文，就需要在头部指定编码。
#注意：Python3.X 源码文件默认使用utf-8编码，所以可以正常解析中文，无需指定 UTF-8 编码。


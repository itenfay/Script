#!/usr/bin/python
#_*_ coding:UTF-8 _*_

#-------------------------------------------------------
# 功能：生成entitlements.plist文件
# 1）参数为源plist文件路径
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/31
#-------------------------------------------------------

import os
import sys

from biplist import *

def generateEntitlementsPlist(path):
	'''生成entitlements.plist文件
	'''
	try:
		root_dic = readPlist(path)
	except (InvalidPlistException, NotBinaryPlistException), e:
		print "XProjGenEntitlementsPlist: Not a plist:", e

	entitlements = root_dic['Entitlements']

	try:
		writePlist(entitlements, path)
	except (InvalidPlistException, NotBinaryPlistException), e:
		print "XProjGenEntitlementsPlist: Something bad happened:", e

def execute():
	'''执行生成文件操作
	'''
	length = len(sys.argv)
	
	if length > 1:
		path = sys.argv[1];
		if 'plist' in path:
			if os.path.exists(path):
				generateEntitlementsPlist(path)
			else:
				print "XProjGenEntitlementsPlist: 传入的源plist文件路径不存在."
		else:
			print "XProjGenEntitlementsPlist: 传入的源文件不是plist文件格式."
	else:
		print "XProjGenEntitlementsPlist: 没有传入plist文件路径."

if __name__ == "__main__":
	execute()

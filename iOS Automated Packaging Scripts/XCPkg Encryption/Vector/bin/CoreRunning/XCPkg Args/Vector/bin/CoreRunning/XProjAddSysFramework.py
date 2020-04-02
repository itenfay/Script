#!/usr/bin/python
#coding=utf-8

#-------------------------------------------------------
# 功能：添加系统framework
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个参数及以后参数为系统framework名称
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

import sys

from mod_pbxproj import XcodeProject

def addSysFramework():
	le = len(sys.argv)
	if le > 1:
		if "xcodeproj" not in sys.argv[1]:
			print "XProjAddSysFramework: 无效的*.xcodeproj文件路径."
		else:
			if le > 2:
				pbx_path = sys.argv[1] + "/" + "project.pbxproj"
				project = XcodeProject.Load(pbx_path)
				root_path = 'System/Library/Frameworks/'
				frameworks = project.get_or_create_group('Frameworks')
				for idx in range(2, le):
					project.add_file_if_doesnt_exist(root_path + sys.argv[idx], parent=frameworks)
				project.save()
			else:
				print "XProjAddSysFramework: 没有传入系统framework."
	else:
		print "XProjAddSysFramework: 没有传入*.xcodeproj文件路径."

if __name__ == "__main__":
	addSysFramework()

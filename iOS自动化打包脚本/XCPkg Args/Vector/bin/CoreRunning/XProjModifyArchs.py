#!/usr/bin/python
# -*- coding=utf-8 -*-

#-------------------------------------------------------
# 功能：修改Architectures
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个及后面的参数为armv7, arm64, armv7s
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/22
#-------------------------------------------------------

import sys

from mod_pbxproj import XcodeProject

def modifyArchs(path, archs):
	project = XcodeProject.Load(path)
	project.remove_flags({'ARCHS': ['armv7', 'arm64', 'armv7s']})
	project.add_flags({'ARCHS': archs})
	project.save()

def execute(xargv):
	length = len(xargv)
	if length > 1:
		if "xcodeproj" in xargv[1]:
			pbx_path = xargv[1] + "/" + "project.pbxproj"
			if length > 2:
				list = []
				for idx in range(2, length):
					list.append(xargv[idx])
				modifyArchs(pbx_path, list)
			else:
				print "XProjModifyArchs: 没有传入Architectures的参数."
		else:
			print "XProjModifyArchs: 无效的*.xcodeproj文件路径."
	else:
		print "XProjModifyArchs: 没有传入*.xcodeproj文件路径."

if __name__ == "__main__":
	execute(sys.argv)

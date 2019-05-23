#!/usr/bin/python
#coding=utf-8

#-------------------------------------------------------
# 功能：移除文件
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个参数为删除文件名称
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

import sys

from mod_pbxproj import XcodeProject

def removeFile():
	le = len(sys.argv)
	if le > 1:
		if "xcodeproj" not in sys.argv[1]:
			print "XProjRemoveFile: 无效的*.xcodeproj文件路径."
		else:
			if le > 2:
				pbx_path = sys.argv[1] + "/" + "project.pbxproj"
				project = XcodeProject.Load(pbx_path)
				for idx in range(2, le):
					project.remove_file_by_path(sys.argv[idx])
				project.save()
			else:
				print "XProjRemoveFile: 没有传入需要移除的文件名称."
	else:
		print "XProjRemoveFile: 没有传入*.xcodeproj文件路径."

if __name__ == "__main__":
	removeFile()

#!/usr/bin/python
#coding=utf-8

#-------------------------------------------------------
# 功能：添加bundle资源
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个参数为分组Group名称
# 3）第三个参数及以后参数为bundle文件路径
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

import sys

from mod_pbxproj import XcodeProject

def addBundle():
	le = len(sys.argv)
	if le > 1:
		if "xcodeproj" not in sys.argv[1]:
			print "XProjAddBundle: 无效的*.xcodeproj文件路径."
		else:
			if le > 2:
				pbx_path = sys.argv[1] + "/" + "project.pbxproj"
				project = XcodeProject.Load(pbx_path)
				bundle_group = project.get_or_create_group(sys.argv[2])
				for idx in range(3, le):
					project.add_file_if_doesnt_exist(sys.argv[idx], parent=bundle_group)
				project.save()
			else:
				print "XProjAddBundle: 没有传入Bundle路径."
	else:
		print "XProjAddBundle: 没有传入*.xcodeproj文件路径."

if __name__ == "__main__":
	addBundle()

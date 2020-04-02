#!/usr/bin/python
# -*- coding=utf-8 -*-

#-------------------------------------------------------
# 功能：修改bitcode
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个参数为YES or NO, 默认为NO，即默认关闭
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

import sys

from mod_pbxproj import XcodeProject

def modifyBitcode(path, enable='NO'):
	project = XcodeProject.Load(path)
	project.add_single_valued_flag('ENABLE_BITCODE', enable)
	project.save()

if __name__ == "__main__":
	le = len(sys.argv)
	if le > 1:
		if "xcodeproj" in sys.argv[1]:
			pbx_path = sys.argv[1] + "/" + "project.pbxproj"
			if le > 2:
				modifyBitcode(pbx_path, sys.argv[2])
			else:
				modifyBitcode(pbx_path)
		else:
			print "XProjModifyBitcode: 无效的*.xcodeproj文件路径."
	else:
		print "XProjModifyBitcode: 没有传入*.xcodeproj文件路径."

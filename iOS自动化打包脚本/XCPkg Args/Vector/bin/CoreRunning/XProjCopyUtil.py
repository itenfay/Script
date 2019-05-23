#!/usr/bin/python
#_*_ coding: UTF-8 _*_

#-------------------------------------------------------
# 功能：拷贝文件
# 说明：
# 1）第一个参数为源文件路径
# 2）第二个参数为目标文件路径
# 3）第三个参数为True，表示替换
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/2/26
#-------------------------------------------------------

import sys
import os
import shutil

def path_exists(path):
	if os.path.exists(path):
		return True
	return False

def execute_copy(sp, dp):
	co = CopyFiles(sp, dp)
	co.replace()

def execute_replace(sp, dp, re):
	co = CopyFiles(sp, dp)
	co.replace(re)

class CopyFiles:
	'''
	拷贝文件或目录
	'''
	def __init__(self, src_path, dst_path):
		if path_exists(src_path):
			self.src_path = src_path
			self.dst_path = dst_path
		else:
			print "XProjCopyUtil: 无效的文件路径 : %s" % src_path
	
	def getDstPath(self):
		return self.dst_path
	
	def __copy(self, path):
		'''
		拷贝文件或目录方法
		'''
		if os.path.isdir(self.src_path):
			try:
				shutil.copytree(self.src_path, path)
			except:
				print "XProjCopyUtil: 目录已经存在."
		else:
			try:
				shutil.copy(self.src_path, path)
			except:
				print "XProjCopyUtil: 文件已经存在."

	def replace(self, rep=False):
		'''
		替换文件或目录方法
		'''
		target_path = self.getDstPath()
				
		if path_exists(target_path):
			if rep:
				if os.path.isfile(target_path):
					os.remove(target_path)
				else:
					shutil.rmtree(target_path)

		self.__copy(target_path)


if __name__ == "__main__":
	le = len(sys.argv)
	if le > 1:
		if le > 2:
			srcPath = sys.argv[1]
			dstPath = sys.argv[2]
			updir_path = os.path.dirname(dstPath)
			if path_exists(srcPath) and path_exists(updir_path):
				if le > 3:
					va = sys.argv[3]
					if va == "True":
						execute_replace(srcPath, dstPath, va)
					else:
						print "XProjCopyUtil: 第三个参数请传入True, 默认为False, 不执行替换."
				else:
					execute_copy(srcPath, dstPath)
			else:
				print "XProjCopyUtil: 源文件路径和拷贝目标目录至少有一个不存在."
		else:
			print "XProjCopyUtil: 没有传入目标文件拷贝路径."
	else:
		print "XProjCopyUtil: 没有传入源文件路径."

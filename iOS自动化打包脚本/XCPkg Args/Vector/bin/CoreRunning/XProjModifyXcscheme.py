#!/usr/bin/python
# -*- coding=utf-8 -*-

#-------------------------------------------------------
# 功能：修改xcscheme文件下节点ReferencedContainer的值
# 说明：
# 1）第一个参数为xcodeproj文件路径
# 2）第二个参数为xcodeproj文件名称
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

import sys

from XProjModifyXml import *

def modifyXcscheme(path, referencedContainer):
	'''修改xcscheme文件下节点ReferencedContainer的值
		path: 文件路径
		referencedContainer: container名称'''
	
	container = "container:" + referencedContainer
	
	#读取xml文件
	tree = read_xml(path)
	
	#找出BuildAction下的BuildableReference
	build_action_node = find_nodes(tree, 'BuildAction/BuildActionEntries/BuildActionEntry/BuildableReference')
	change_node_properties(build_action_node, {"ReferencedContainer" : container})
	
	#找出TestAction下的BuildableReference
	test_action_node = find_nodes(tree, 'TestAction/Testables/TestableReference/BuildableReference')
	change_node_properties(test_action_node, {"ReferencedContainer" : container})
	
	#找出TestAction下的BuildableReference
	test_action_node2 = find_nodes(tree, 'TestAction/MacroExpansion/BuildableReference')
	change_node_properties(test_action_node2, {"ReferencedContainer" : container})
	
	#找出LaunchAction下的BuildableReference
	launch_action_node = find_nodes(tree, 'LaunchAction/BuildableProductRunnable/BuildableReference')
	change_node_properties(launch_action_node, {"ReferencedContainer" : container})
	
	#找出ProfileAction下的BuildableReference
	profile_action_node = find_nodes(tree, 'ProfileAction/BuildableProductRunnable/BuildableReference')
	change_node_properties(profile_action_node, {"ReferencedContainer" : container})
	
	#输出到结果文件
	write_xml(tree, path)


if __name__ == "__main__":
	le = len(sys.argv)
	if le > 1:
		if "xcscheme" in sys.argv[1]:
			if le > 2:
				xcscheme_path = sys.argv[1]
				modifyXcscheme(xcscheme_path, sys.argv[2])
			else:
				print "XProjModifyXcscheme: 没有传入*.xcodeproj文件名称."
		else:
			print "XProjModifyXcscheme: 无效的*.xcscheme文件路径."
	else:
		print "XProjModifyXcscheme: 没有传入*.xcscheme文件路径."

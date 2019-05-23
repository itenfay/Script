#!/bin/sh

#-------------------------------------------------------
# 功能：添加动态库(framework)
# 1）参数一为project工程路径
# 2）参数二为target名称
# 3）参数三为分组名称
# 4）参数四为framework路径，多个路径以","分隔符连接
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/5/31
#-------------------------------------------------------

if [ $# -lt 5 ];then
	echo 'XProjAddDynamicFramework: Error! Should enter the dirpath of script, the path of project, the name of target, group, the path of dynamic frameworks.'
	exit 2
fi

#脚本所在目录路径
scr_dirpath=$1

#打包工程project路径
pkg_proj_path=$2

#打包target名称
pkg_target_name=$3

#打包渠道分组名称
pkg_group_name=$4

#依赖库路径
dep_framework_path=$5

#ruby命令
ruby_cmd='/usr/bin/ruby'

#脚本绝对路径
scr_abspath=${scr_dirpath}/rb_modproj/interface/addDynamicFrameworks.rb

#添加Dynamic Frameworks
${ruby_cmd} ${scr_abspath} ${pkg_proj_path} ${pkg_target_name} ${pkg_group_name} ${dep_framework_path}

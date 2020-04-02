#!/bin/sh

#-------------------------------------------------------
# 功能：获取指定目录下的所有同类型文件绝对路径
# 1）参数为指定目录路径
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/16
#-------------------------------------------------------

xc_bundles=""
xc_frameworks=""
xc_libraries=""
xc_files=""

function exec_process()
{
	dst_path=$1

	paths=`ls ${dst_path}`

	for path in ${paths}
	do
		extension=${path##*.}
		if [ $extension = "bundle" ];then
			xc_bundles=$xc_bundles''${dst_path}/${path}' '
		elif [ $extension = "framework" ];then
			xc_frameworks=$xc_frameworks''${dst_path}/${path}' '
		elif [ $extension = "a" ];then
			xc_libraries=$xc_libraries''${dst_path}/${path}' '
		elif [ $extension = "h" -o $extension = "m" ];then
			xc_files=$xc_files''${dst_path}/${path}' '
		else
			continue
		fi
	done
}

if [ $# -lt 1 ];then
	echo "XProjGainSDKRes: Error! Please enter the path of directory after thd command."
else
	if [ ! -d $1 ];then
		echo "XProjGainSDKRes: Error! The first parameter must be directory."
	else
		exec_process $1
	fi
fi

#echo "xc_bundles: "${xc_bundles}
#echo "xc_frameworks: "${xc_frameworks}
#echo "xc_libraries: "${xc_libraries}
#echo "xc_files: "${xc_files}

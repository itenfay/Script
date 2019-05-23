#!/bin/sh

#-------------------------------------------------------
# 功能：在指定目录下搜索文件, 返回文件路径
# 说明：
# 1）第一个参数为目录
# 2）第二个参数为文件扩展名
# 3）第三个参数为查找最大深度, 填写一个数字即可
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

#搜索文件路径
search_file_path=""

function searchFilePath()
{
	root_dir=$1
	name=$2
	option=$3
	if [ ! $option ];then
		search_file_path=$(find ${root_dir} -name "*.${name}")
	else
		search_file_path=$(find ${root_dir} -name "*.${name}" -maxdepth ${option})
	fi
}

if [ $# -lt 1 ];then
	echo "XProjSearchFile: Error! Should enter the directory after the XProjSearchFile command."
fi

if [ ! -d $1 ];then
	echo "XProjSearchFile: Error! The first parameter must be directory."
fi

if [ $2 ];then
	searchFilePath $1 $2 $3
else
	echo "XProjSearchFile: Error! Please enter file's extension."
fi

echo "search_file_path: "$search_file_path

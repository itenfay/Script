#!/bin/sh

#-------------------------------------------------------
# 功能：解压ipa文件
# 说明：
# 1）参数为ipa文件路径
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/17
#-------------------------------------------------------

if [ $# -lt 1 ];then
	echo 'XProjUnzip: Error! Should enter the path of ipa after the command.'
	exit 2
fi

unzip_file_path=$1

if [ ! -e $unzip_file_path ];then
	echo 'XProjUnzip: Error! The ipa file do not exist.'
	exit 2
fi

#${unzip_file_path%/*} <=> dirname ${unzip_file_path}
ipa_dir=${unzip_file_path%/*}

#解压文件, 要求覆盖
unzip -q -o ${unzip_file_path} -d ${ipa_dir}

if [ $? -eq 0 ];then
	#找到app目录
	app_dir=$(find ${ipa_dir} -name "*.app")
fi

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
	echo 'XProjZip: Error! Should enter the path of Payload after the command.'
	exit 2
fi

payload_path=$1

if [ ! -d $payload_path ];then
	echo 'XProjZip: Error! The first parameter must be directory.'
	exit 2
fi

ipa_name=$2

if [ ! $ipa_name ];then
	echo 'XProjZip: 没有传入ipa名称'
	exit 2
fi

#echo "payload_path: "$payload_path

cd ${payload_path}

#获得压缩目录名称
zip_dir=`pwd | rev | awk -F \/ '{print $1}' | rev`
#echo "zip_dir: "$zip_dir

#获取ipa输出目录
ipa_out=`dirname ${payload_path}`

cd ${ipa_out}

zip_cmd='/usr/bin/zip'

#压缩${zip_dir}目录下所有文件
${zip_cmd} -qry ${ipa_name} ${zip_dir}

#判断是否执行成功
if [ $? -eq 0 ];then
	rm -rf ${payload_path}
fi

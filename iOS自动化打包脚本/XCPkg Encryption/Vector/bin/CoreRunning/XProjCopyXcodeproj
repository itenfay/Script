#!/bin/sh

#-------------------------------------------------------
# 功能：拷贝Xcodeproj文件添加渠道标识作为新名称
# 说明：
# 拷贝Xcodeproj文件, 第一个参数为Xcodeproj路径, 第二个参数为渠道标识
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/10
#-------------------------------------------------------

if [ $# -lt 1 ];then
	echo "XProjCopyXcodeproj: Error! Please enter the path of xcodeproj after the XProjCopyXcodeproj command."
	exit 2
fi

if [ ! -d $1 ];then
	echo "XProjCopyXcodeproj: Error! The first parameter must be directory."
	exit 2
fi

if [ ! $2 ];then
	echo "XProjCopyXcodeproj: Error, The first parameter can't None."
	exit 2
fi

# xcproj_srcpath
xcproj_srcpath=$1
echo "xcproj_srcpath: "${xcproj_srcpath}

#xcproj_cflags
xcproj_cflags=$2
echo "xcproj_cflags: "${xcproj_cflags}

# xcproj
xcproj_dirpath=${xcproj_srcpath%/*}
xcproj_ext=${xcproj_srcpath##*.}
xcproj_tmp=${xcproj_srcpath##*/}
xcproj_name=${xcproj_tmp%.*}

# xcproj_dstpath
xcproj_dstpath=${xcproj_dirpath}/${xcproj_name}
xcproj_dstpath=${xcproj_dstpath}'-'${xcproj_cflags}'.'${xcproj_ext}
echo "xcproj_dstpath: "${xcproj_dstpath}

# copy
copy() {
	if [ -d ${xcproj_dstpath} ];then
		rm -rf ${xcproj_dstpath}
	fi
	copy_cmd="cp -R ${xcproj_srcpath} ${xcproj_dstpath}"
	$copy_cmd
}

copy

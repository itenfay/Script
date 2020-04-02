#!/bin/sh

#-------------------------------------------------------
# 功能:读取配置参数, 分发参数到各个命令
# 说明:
#     PkgController <-h help>
#	  第1个参数为xcodeproj路径.
#     第2个参数为Project's target.
#	  第3个参数为ipa文件输出目录路径.
#	  第4个参数为Pkgcfg.plist文件路径.
#	  第5个参数为Sdks目录路径.
#	  第6个参数为Icon目录路径.
#	  第7～16个参数为打包参数.
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/15
#-------------------------------------------------------

help()
{
	echo "1）第1个参数为xcodeproj路径."
	echo "2）第2个参数为Project's target."
	echo "3）第3个参数为ipa文件输出目录路径."
	echo "4）第4个参数为Pkgcfg.plist文件路径."
	echo "5）第5个参数为Sdks目录路径."
	echo "6）第6个参数为Icon目录路径."
	echo "7）第7～16个参数为打包参数."
	exit
}

guide()
{
	echo 'PkgController <-h help>, usage with "cmd -h".'
	exit
}

remove()
{
	rm_path=$1
	rm -rf ${rm_path}
}

option=':h'
while getopts $option optname
do
	case "$optname" in
	"h")
		help
		;;
	"?")
		help
		;;
	  *)
		help
		;;
	esac
done

if [ $# -lt 6 ];then
	guide
fi

#xcproj_basepath
xcproj_basepath=$1
if [ ! -d ${xcproj_basepath} ];then
	echo "PkgController: xcodeproj工程地址不存在."
	exit
else
	[[ ${xcproj_basepath} =~ '.xcodeproj' ]]
	if [ $? -ne 0 ];then
		echo "PkgController: xcodeproj工程地址不正确."
		exit
	fi
fi

#xcproj_target
xcproj_target=$2
if [ ! ${xcproj_target} ];then
	guide
fi

#ipa_output_path
ipa_output_path=$3
if [ ! -d ${ipa_output_path} ];then
	guide
fi

#pkg_cfg_path
pkg_cfg_path=$4
if [ ! -e ${pkg_cfg_path} ];then
	echo "PkgController: 配置文件不存在."
	exit
else
	[[ ${pkg_cfg_path} =~ '.plist' ]]
	if [ $? -ne 0 ];then
		echo "PkgController: 配置文件不是plist文件格式."
		exit
	fi
fi

#sdks_path
sdks_path=$5
if [ ! -d ${sdks_path} ];then
	echo "PkgController: Sdks目录不存在."
	exit
fi

#icon_folder_path
icon_folder_path=$6
if [ ! -d ${icon_folder_path} ];then
	echo "PkgController: Icon目录不存在."
	exit
fi

#Args
xc_channel_name=$7
xc_archs=$8
xc_min_deployment=$9
xc_certificate_name=${10}
xc_mobileprovision_path=${11}
xc_initsdk_args=${12}
xc_sys_dylibs=${13}
xc_sys_frameworks=${14}
xc_infoplist_args=${15}
xc_complete_flag=${16}

sdks_folder=${sdks_path##*/}
echo "sdks_folder: "${sdks_folder}

PACKAGE_CMD=$0
PARENT_DIR=$(dirname ${PACKAGE_CMD})
cd ${PARENT_DIR}
BIN_DIRPATH=$(pwd)
echo "BIN_DIRPATH: "${BIN_DIRPATH}

core_cmd_folder="CoreRunning"

framework_group="Frameworks"

xcscheme_extension="xcscheme"

xc_rmsdk_cmpt="libUQSDK.a UQSDKTestKit.framework AlipaySDK.framework"
xc_rmsdk_cmpt="${xc_rmsdk_cmpt} UQSDKTestKit.bundle AlipaySDK.bundle"
echo "xc_rmsdk_cmpt: "${xc_rmsdk_cmpt}

cd ${xcproj_basepath}
cd ..
project_path=$(pwd)
echo "project_path: "${project_path}

sdks_dst_path=${project_path}/${sdks_folder}

cd ${BIN_DIRPATH}

shell_cmd=sh
python_cmd=python

#Copy Sdks
if [ ! -d ${sdks_dst_path} ];then
	${python_cmd} ./${core_cmd_folder}/XProjCopyUtil.py ${sdks_path} ${sdks_dst_path} True
fi

#Copy xcodeproj, add channelName
. ./${core_cmd_folder}/XProjCopyXcodeproj.sh $xcproj_basepath $xc_channel_name

xcproj_path=${xcproj_dstpath}
echo "xcproj_path: "${xcproj_path}

cd ${BIN_DIRPATH}

#Search xcscheme file, return filepath
. ./${core_cmd_folder}/XProjSearchFile.sh ${xcproj_path} ${xcscheme_extension}

xcscheme_path=${search_file_path}

#xcproj_name
xcproj_name=${xcproj_path##*/}
echo "xcproj_name: "${xcproj_name}

#Modify xcscheme file's properties
for xcspath in ${xcscheme_path}
do
	${python_cmd} ./${core_cmd_folder}/XProjModifyXcscheme.py ${xcspath} ${xcproj_name}
done

#Create group
${python_cmd} ./${core_cmd_folder}/XProjAddGroup.py ${xcproj_path} ${xc_channel_name} ${framework_group}

#Remove files
${python_cmd} ./${core_cmd_folder}/XProjRemoveFile.py ${xcproj_path} ${xc_rmsdk_cmpt}

#Set bitcode NO
${python_cmd} ./${core_cmd_folder}/XProjModifyBitcode.py ${xcproj_path}

#Add Other linker flags
${python_cmd} ./${core_cmd_folder}/XProjAddOtherFlags.py ${xcproj_path} -ObjC -lz

#Add architectures
${python_cmd} ./${core_cmd_folder}/XProjModifyArchs.py ${xcproj_path} ${xc_archs}

#Catch sdk args
. ./${core_cmd_folder}/XProjGainSDKRes.sh ${project_path}/${sdks_folder}/${xc_channel_name}

#Add bundle
${python_cmd} ./${core_cmd_folder}/XProjAddBundle.py ${xcproj_path} ${xc_channel_name} ${xc_bundles}

#Add framework
for xc_framework in ${xc_frameworks}
do
	[[ ${xc_framework} =~ 'xsdkFramework.framework' ]]
	if [ $? -eq 0 ];then
		${shell_cmd} ./${core_cmd_folder}/XProjAddDynamicFramework.sh ${BIN_DIRPATH}/${core_cmd_folder} ${xcproj_path} ${xcproj_target} ${xc_channel_name} ${xc_framework}
	else
		${python_cmd} ./${core_cmd_folder}/XProjAddFramework.py ${xcproj_path} ${xc_channel_name} ${xc_framework}
	fi
done

#Add static lib
${python_cmd} ./${core_cmd_folder}/XProjAddStaticLib.py ${xcproj_path} ${xc_channel_name} ${xc_libraries}

#add file
${python_cmd} ./${core_cmd_folder}/XProjAddFile.py ${xcproj_path} ${xc_channel_name} ${xc_files}

#Add system dylib
if [ "${xc_sys_dylibs}" ];then
	${python_cmd} ./${core_cmd_folder}/XProjAddSysDylib.py ${xcproj_path} ${xc_sys_dylibs}
fi

#Add system framework
${python_cmd} ./${core_cmd_folder}/XProjAddSysFramework.py ${xcproj_path} ${xc_sys_frameworks}

#Package
. ./${core_cmd_folder}/XProjPackageUtil.sh ${project_path} -p ${xcproj_name} -t ${xcproj_target} -c -n ${xc_channel_name} -o ${ipa_output_path} -m ${xc_min_deployment}

wks_path=${workstation_path}
echo "wks_path: "$wks_path

ipa_path=${ipa_path}
echo "ipa_path: "$ipa_path

wks_ipa_path=${wks_ipa_path}
echo "wks_ipa_path: "$wks_ipa_path

cd ${BIN_DIRPATH}

if [ "${wks_ipa_path}" ];then
	#Unzip
	. ./${core_cmd_folder}/XProjUnzip.sh $wks_ipa_path

	dst_path=${app_dir}
	echo "dst_path: "$dst_path

	#Search 1024x1024 png
	. ./${core_cmd_folder}/XProjSearchFile.sh ${icon_folder_path}/${xc_channel_name} png 1

	icon_path=${search_file_path}
	echo "icon_path: "${icon_path}

	#Generate Icon
	${shell_cmd} ./${core_cmd_folder}/XProjGenIcon.sh ${icon_path} ${dst_path}

	#Remove ipa
	remove ${wks_ipa_path}

	payload_dirpath=$(dirname ${dst_path})
	echo "Payload_path: "$payload_dirpath

	#Modify info.plist
	${shell_cmd} ./${core_cmd_folder}/XProjModifyInfoPlist.sh ${dst_path}/Info.plist "${xc_infoplist_args}"

	#Modify sdk config
	${shell_cmd} ./${core_cmd_folder}/XProjModSDKBundleConfig.sh ${dst_path} "${xc_initsdk_args}"

	#Codesign
	${shell_cmd} ./${core_cmd_folder}/XProjCodesign.sh ${payload_dirpath} ${BIN_DIRPATH}/${core_cmd_folder} "${xc_certificate_name}" ${xc_mobileprovision_path}

	cd ${BIN_DIRPATH}

	#ipa_name
	ipa_name=$(basename $wks_ipa_path)
	echo "ipa_name: "${ipa_name}

	#Zip
	${shell_cmd} ./${core_cmd_folder}/XProjZip.sh ${payload_dirpath} ${ipa_name}

	cp -Rf ${wks_ipa_path} ${ipa_path}
	remove ${wks_ipa_path}
fi

remove ${xcproj_path}

cleanUp() {
	remove ${project_path}/build
	remove ${sdks_dst_path}
	remove ${wks_path}
}

if [ ${xc_complete_flag} = 'y' ];then
	cleanUp
fi

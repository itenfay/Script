#!/bin/sh

#-------------------------------------------------------
# 功能：编译xcode项目并打ipa包
# 使用说明：
# 编译project
# DYFPackageUtils <project directory> [-p <project name>] [-t <target name>] [-o <ipa output directory>]
#				   [-f <project configuration>] [-h <channel name>] [-m <min deployment>] [-c]
# 编译workspace
# DYFPackageUtils <project directory> -w -s <schemeName> [-f <project configuration>] [-m <min deployment>] [-c]
# 参数说明：
# -h		帮助
# -f  NAME  工程的configuration, 默认为Release
# -o  PATH  生成的ipa文件输出的目录, 默认为工程根路径下的"iMobileApps"目录
# -p  NAME  编译的project的名称
# -t  NAME  编译的target的名称, 如果不传入target, 则编译默认的target
# -w	    编译workspace
# -s  NAME  对应workspace下需要编译的scheme, scheme名称与target名称必须一致
# -c	    编译前是否先clean工程
# -n  NAME  渠道标识
# -m  NUM   编译时设置SDK最低兼容版本, 不指定时默认编译配置的最低兼容版本
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/7
#-------------------------------------------------------

help()
{
	echo '编译project'
	echo 'DYFPackageUtils <project directory> [-p <project name>] [-t <target name>] [-o <ipa output directory>]'
	echo '				   [-f <project configuration>] [-n <channel name>] [-m <min deployment>] [-c] [-h]'
	echo '编译workspace'
	echo 'DYFPackageUtils <project directory> -w -s <schemeName> [-f <project configuration>] [-m <min deployment>] [-c] [-h]'
	echo '参数说明：'
	echo '-h		帮助'
	echo '-f  NAME  工程的configuration, 默认为Release'
	echo '-o  PATH  生成的ipa文件输出的目录, 默认为工程根路径下的"iMobileApps"目录'
	echo '-p  NAME  编译的project的名称'
	echo '-t  NAME  编译的target的名称, 如果不传入target, 则编译默认的target'
	echo '-w	    编译workspace'
	echo '-s  NAME  对应workspace下需要编译的scheme, scheme名称与target名称必须一致'
	echo '-c	    编译前是否先clean工程'
	echo '-n  NAME  渠道标识'
	echo '-m  NUM   编译时设置SDK最低兼容版本, 不指定时默认编译配置的最低兼容版本'
	exit
}

guide()
{
	echo 'DYFPackageUtils: Error, usage with "cmd -h"'
	exit
}

if [ $#  -lt 1 ];then
	echo 'DYFPackageUtils: Warning: enter the root directory of Xcode project.'
	exit 2
fi

if [ ! -d $1 ];then
	echo 'DYFPackageUtils: Warning: '$1' not a valid directory.'
	exit 2
fi

# cd
cd $1

# 工程路径
project_path=$(pwd)

# Clean工程, 默认不清理
should_clean="n"

# ipa文件输出目录
output_path=''

# 编译target
build_target=''

# 编译config, 默认为Release
build_config=Release

# option字符串，会逐个匹配
OPTIND=2
option=":co:t:ws:f:p:n:m:h"
# 获取和处理命令行选项
while getopts $option optname
do
	case "$optname" in
	"o")
		output_path=$OPTARG
		if [ ! -d $output_path ];then
			mkdir $output_path
		fi
		;;
	"t")
		build_target=$OPTARG
		;;
	"c")
		should_clean='y'
		;;
	"f")
		build_config=$OPTARG
		;;
	"p")
		build_project=$OPTARG
		;;
	"n")
		channel_name=$OPTARG
		;;
	"m")
		deployment=$OPTARG
		;;
	"w")
		workspace_name='*.xcworkspace'
		ls $project_path/$workspace_name &>/dev/null
		if [ $? = 0 ];then
			build_workspace=$(echo $(basename $project_patch/$workspace_name))
		else
			guide
		fi
		;;
	"s")
		build_scheme=$OPTARG
		;;
	"h")
		help
		;;
	"?")
		guide
		;;
	":")
		guide
		;;
	*)
		guide
		;;
	esac
done

site_name=com.pkgtool.workstation
build_dir=Build
temp_path=$(mktemp) > /dev/null 2>&1
workstation_path=${temp_path%/*}/${site_name}
rm -rf ${temp_path}

# build目录路径
build_path=${workstation_path}/${build_dir}
echo "build_path: "$build_path

# 生成app目录
app_dirname=Release-iphoneos

if [ $build_config = Debug ];then
	app_dirname=Debug-iphoneos
fi

if [ $channel_name ];then
	app_dirname=${app_dirname}/${channel_name}
fi

echo "app_dirname: "$app_dirname

# 编译后文件路径
cfg_build_dirpath=$build_path/$app_dirname
echo "cfg_build_dirpath: "$cfg_build_dirpath

# 编译命令
build_cmd='xcodebuild'

# 清空工程
clean_project()
{
	should_proj=$1
	if [ $should_clean = 'y' ];then
		if [ $should_proj = 'y' ];then
			xcproj_name=$2
			${build_cmd} -project ${xcproj_name} -configuration ${build_config} clean
		else
			${build_cmd} -configuration ${build_config} clean
		fi
	fi
}

# 使用xcrun打包
runPkgApp()
{
	pkg_outpath=$1
	xcrun -sdk iphoneos PackageApplication -v ./${app_dirname}/*.app -o ${pkg_outpath}
}

if [ $build_workspace ];then
	# 编译workspace
	if [ ! $build_scheme ];then
		guide
	fi

	clean_project 'n'

	build_cmd=${build_cmd}' -sdk iphoneos'

	build_cmd=${build_cmd}' -workspace '${build_workspace}' -scheme '${build_scheme}' -configuration '${build_config}

	build_cmd=${build_cmd}' CONFIGURATION_BUILD_DIR='${cfg_build_dirpath}' ONLY_ACTIVE_ARCH=NO'
else
	# 编译project
	build_cmd=${build_cmd}' -sdk iphoneos'

	if [ $build_project ];then
		clean_project 'y' ${build_project}
		build_cmd=${build_cmd}' -project '${build_project}
	else
		clean_project 'n'
	fi

	if [ $build_target ];then
		build_cmd=${build_cmd}' -target '${build_target}
	fi

	build_cmd=${build_cmd}' -configuration '${build_config}

	build_cmd=${build_cmd}' CONFIGURATION_BUILD_DIR='${cfg_build_dirpath}' ONLY_ACTIVE_ARCH=NO'
fi

# 设置iOS最低版本兼容部署
if [ $deployment ];then
	build_cmd=${build_cmd}' IPHONEOS_DEPLOYMENT_TARGET='${deployment}
fi

if [ ! $output_path ];then
	output_path="${project_path}/iMobileApps"
fi
echo "output_path: "$output_path

build_log_fpath=${output_path}/Log
# mkdir -p ${build_log_fpath}
if [ ${channel_name} ];then
	build_log_fpath=${build_log_fpath}/${channel_name}
fi
build_log_fpath=${build_log_fpath}_log.txt

# 执行编译
echo "build_cmd: "$build_cmd
$build_cmd #2>${build_log_fpath}

if [ $? -eq 0 ];then
	# Build目录
	cd $build_path

	# 获得app名称
	app_name=""
	if [ $build_scheme ];then
		app_name=${build_scheme}.app
	else
		app_name=$(basename ./${app_dirname}/*.app)
	fi
	echo "app_name: "$app_name

	# 获得工程target名称
	if [ ! $build_target ];then
		build_target=$(echo $app_name | awk -F. '{print $1}')
	fi
	echo "build_target: "$build_target

	# 通过app文件名获得渠道标识
	if [ ! $channel_name ];then
		channel_name=${app_name##*-}
		channel_name=`echo $channel_name | awk -F. '{print $1}'`
	fi
	echo "channel_name: "$channel_name

	# 获得Info.plist文件路径
	info_plist_path=${build_path}/${app_dirname}/${app_name}/Info.plist
	echo "info_plist_path: "$info_plist_path

	# 获取build的版本号
	bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${info_plist_path})
	echo "bundleVersion: "$bundleVersion

	# 获取应用显示名称
	displayName=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName" ${info_plist_path})
	if [ ! $displayName ];then
		displayName=${build_target}
	fi
	echo "displayName: "$displayName

	# ipa输出名称
	ipa_name=${displayName}
	ipa_name=${ipa_name}_${channel_name}_${bundleVersion}_$(date +"%Y%m%d%H%M%S")
	echo "ipa_name: "$ipa_name

	mkdir -p ${output_path}

	ipa_path=${output_path}/${ipa_name}.ipa

	wks_ipa_path=${workstation_path}
	if [ $channel_name ];then
		wks_ipa_path=${wks_ipa_path}/${channel_name}
		mkdir -p ${wks_ipa_path}
	fi
	wks_ipa_path=${wks_ipa_path}/${ipa_name}.ipa

	runPkgApp ${wks_ipa_path}
fi

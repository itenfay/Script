#!/bin/sh

#-------------------------------------------------------
# 功能:修改SDK配置参数
# 说明:
# 1）第1个参数请传app路径
# 2）第2个参数请传SDK配置参数
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/4/22
#-------------------------------------------------------

if [ $# -lt 1 ];then
	echo "XProjModSDKBundleConfig: Error, enter the path of the application."
	exit 2
fi

appl_path=$1

init_args=$2

if [ ! ${init_args} ];then
	echo "XProjModSDKBundleConfig: Error, enter the arguments for the initialization of SDK."
	exit 2
fi

files_indir='Files'

upkg_bundle_name='UPKGConfig.bundle'
upkg_bundle_filename='conf.plist'
upkg_bundle_filepath=${appl_path}/${upkg_bundle_name}/${files_indir}/${upkg_bundle_filename}

buddy_cmd='/usr/libexec/PlistBuddy'

if [ -e ${upkg_bundle_filepath} ];then
	xargs=${init_args//|/ }

	for arg in ${xargs}
	do
		key=$(echo ${arg} | awk -F ':' '{print $1}')
		value=$(echo ${arg} | awk -F ':' '{print $2}')
		type=string
		if [ ${value} = 'true' -o ${value} = 'false' ];then
			type=bool
		fi
		${buddy_cmd} -c "Add:${key} ${type} ${value}" ${upkg_bundle_filepath} >/dev/null 2>&1
		if [ $? -ne 0 ];then
			${buddy_cmd} -c "Set:${key} ${value}" ${upkg_bundle_filepath}
		fi
	done

	upkg_bundle_mod_filename='conf.cfg'
	upkg_bundle_mod_filepath=${appl_path}/${upkg_bundle_name}/${files_indir}/${upkg_bundle_mod_filename}

	cp ${upkg_bundle_filepath} ${upkg_bundle_mod_filepath}
	rm -rf ${upkg_bundle_filepath}
fi

fd_bundle_name='UdFoundation.bundle'
fd_bundle_filename='propertyList.plist'
fd_bundle_mod_filename='propertyList.cfg'

fd_bundle_parent_path=${appl_path}/${fd_bundle_name}/${files_indir}
fd_bundle_filepath=${fd_bundle_parent_path}/${fd_bundle_filename}

if [ -e ${fd_bundle_filepath} ];then
	fd_bundle_mod_filepath=${fd_bundle_parent_path}/${fd_bundle_mod_filename}
	cp ${fd_bundle_filepath} ${fd_bundle_mod_filepath}
	rm -rf ${fd_bundle_filepath}
fi

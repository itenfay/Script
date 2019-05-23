#!/bin/sh

#-------------------------------------------------------
# 功能：修改Info.plist文件属性
# 1）第一个参数为Info.plist文件路径
# 2）第二个参数为修改属性参数
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/21
#-------------------------------------------------------

if [ $# -lt 1 ];then
	echo 'XProjModifyInfoPlist: Error! Please enter the path of Info.plist after the command.'
	exit 2
fi

if [ ! -e $1 ];then
	echo 'XProjModifyInfoPlist: Warning: '$1' not a file.'
	exit 2
fi

if [ ! $2 ];then
	echo "XProjModifyInfoPlist: Warning: please enter modify properties."
	exit 2
fi

plist_path=$1
echo "plist_path: "$plist_path

plist_args=$2
plist_args=${plist_args//|/ }
echo "plist_args: "$plist_args

for arg in ${plist_args}
do
	[[ $arg =~ "BundleId" ]]
	if [ $? -eq 0 ];then
		BundleId=$(echo $arg | awk -F '=' '{print $2}')
	fi

	[[ $arg =~ "BundleDisplayName" ]]
	if [ $? -eq 0 ];then
		BundleDisplayName=$(echo $arg | awk -F '=' '{print $2}')
	fi

	[[ $arg =~ "QueriesSchemes" ]]
	if [ $? -eq 0 ];then
		arg=$(echo $arg | awk -F '=' '{print $2}')
		arg=${arg//,/ }
		QueriesSchemes=${arg}
	fi

	[[ $arg =~ "URLTypes" ]]
	if [ $? -eq 0 ];then
		arg=$(echo $arg | awk -F '=' '{print $2}')
		arg=${arg//,/ }
		URLTypes=${arg}
	fi

	[[ $arg =~ "Orientations" ]]
	if [ $? -eq 0 ];then
		arg=$(echo $arg | awk -F '=' '{print $2}')
		arg=${arg//,/ }
		Orientations=${arg}
	fi
done

buddy_cmd='/usr/libexec/PlistBuddy'

if [ "${BundleId}" ];then
	${buddy_cmd} -c "Set:CFBundleIdentifier ${BundleId}" ${plist_path}
fi

if [ "${BundleDisplayName}" ];then
	${buddy_cmd} -c "Delete:CFBundleDisplayName" ${plist_path}
	${buddy_cmd} -c "Add:CFBundleDisplayName string ${BundleDisplayName}" ${plist_path}
fi

if [ "${QueriesSchemes}" ];then
	${buddy_cmd} -c "Delete:LSApplicationQueriesSchemes" ${plist_path}
	${buddy_cmd} -c "Add:LSApplicationQueriesSchemes array" ${plist_path}
	idx=0
	for scheme in ${QueriesSchemes}
	do
		${buddy_cmd} -c "Add:LSApplicationQueriesSchemes:${idx} string ${scheme}" ${plist_path}
		idx=`expr $idx + 1`
	done
fi

if [ "${URLTypes}" ];then
	${buddy_cmd} -c "Delete:CFBundleURLTypes" ${plist_path}
	${buddy_cmd} -c "Add:CFBundleURLTypes array" ${plist_path}
	idx=0
	for type in ${URLTypes}
	do
		var1=$(echo $type | awk -F ':' '{print $1}')
		var2=$(echo $type | awk -F ':' '{print $2}')
		${buddy_cmd} -c "Add:CFBundleURLTypes:${idx} dict" ${plist_path}
		${buddy_cmd} -c "Add:CFBundleURLTypes:${idx}:CFBundleTypeRole string Editor" ${plist_path}
		${buddy_cmd} -c "Add:CFBundleURLTypes:${idx}:CFBundleURLName string ${var1}" ${plist_path}
		${buddy_cmd} -c "Add:CFBundleURLTypes:${idx}:CFBundleURLSchemes array" ${plist_path}
		${buddy_cmd} -c "Add:CFBundleURLTypes:${idx}:CFBundleURLSchemes:0 string ${var2}" ${plist_path}
		idx=`expr $idx + 1`
	done
fi

if [ "${Orientations}" ];then
	${buddy_cmd} -c "Delete:UISupportedInterfaceOrientations" ${plist_path}
	${buddy_cmd} -c "Delete:UISupportedInterfaceOrientations~ipad" ${plist_path}
	${buddy_cmd} -c "Add:UISupportedInterfaceOrientations array" ${plist_path}
	${buddy_cmd} -c "Add:UISupportedInterfaceOrientations~ipad array" ${plist_path}
	idx=0
	for orientation in ${Orientations}
	do
		${buddy_cmd} -c "Add:UISupportedInterfaceOrientations:${idx} string ${orientation}" ${plist_path}
		${buddy_cmd} -c "Add:UISupportedInterfaceOrientations~ipad:${idx} string ${orientation}" ${plist_path}
		idx=`expr $idx + 1`
	done
fi

${buddy_cmd} -c "Add:NSAppTransportSecurity:NSAllowsArbitraryLoads bool true" ${plist_path}

Icons=(
	"AppIcon29x29" "AppIcon40x40" "AppIcon57x57" "AppIcon60x60"
)

Icons_ipad=(
	"AppIcon29x29" "AppIcon40x40" "AppIcon50x50" "AppIcon72x72"
	"AppIcon76x76" "AppIcon83.5x83.5"
)

${buddy_cmd} -c "Delete:CFBundleIcons" ${plist_path}
${buddy_cmd} -c "Add:CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconFiles array" ${plist_path}

idx=0
for em in ${Icons[*]}
do
	${buddy_cmd} -c "Add:CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconFiles:${idx} string ${em}" ${plist_path}
	idx=`expr $idx + 1`
done

${buddy_cmd} -c "Delete:CFBundleIcons~ipad" ${plist_path}
${buddy_cmd} -c "Add:CFBundleIcons~ipad:CFBundlePrimaryIcon:CFBundleIconFiles array" ${plist_path}

idx=0
for em in ${Icons_ipad[*]}
do
	${buddy_cmd} -c "Add:CFBundleIcons~ipad:CFBundlePrimaryIcon:CFBundleIconFiles:${idx} string ${em}" ${plist_path}
	idx=`expr $idx + 1`
done

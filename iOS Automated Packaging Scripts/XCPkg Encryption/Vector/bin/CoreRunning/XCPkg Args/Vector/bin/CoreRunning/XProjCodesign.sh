#!/bin/sh

#-------------------------------------------------------
# 功能：重签名
# 1）参数一为Payload目录路径
# 2）参数二为PkgCore目录路径
# 3）参数三为证书名称
# 4）参数四为mobileprovision文件路径
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/31
#-------------------------------------------------------

if [ $# -lt 4 ];then
	echo 'XProjCodesign: Error! Should enter the path of Payload, the dirpath of script, certificate_name and the path of mobileprovision.'
	exit 2
fi

payload_path=$1

core_dirpath=$2

certificate_name=$3

mobileprovision_path=$4

home_path=$(dirname ${payload_path})

app_path=$(find ${payload_path} -name '*.app')

security_cmd='/usr/bin/security'

python_cmd='/usr/bin/python'

plistbuddy_cmd='/usr/libexec/PlistBuddy'

codesign_cmd='/usr/bin/codesign'

plutil_cmd='/usr/bin/plutil'

export_plist_name="mobileprovision.plist"

new_plist_name="entitlements.plist"

plist_info_path="${app_path}/Info.plist"

code_signature_path="${app_path}/_CodeSignature"

embedded_mobileprovision_path="${app_path}/embedded.mobileprovision"

plist_srcpath=${home_path}/${export_plist_name}

plist_dstpath=${home_path}/${new_plist_name}

payload_dir=$(echo ${payload_path} | rev | awk -F '/' '{print $1}' | rev)

xmldata=$(${security_cmd} cms -D -i ${mobileprovision_path})

cd ${home_path}

cat << EOF > ${export_plist_name}
${xmldata}
EOF

cd ${core_dirpath}

${python_cmd} ./XProjGenEntitlementsPlist.py ${plist_srcpath}

${plutil_cmd} -convert xml1 ${plist_srcpath} -o ${plist_dstpath}

${plistbuddy_cmd} -c "Delete:CFBundleResourceSpecification" ${plist_info_path}

rm -rf ${code_signature_path}

cp -f ${mobileprovision_path} ${embedded_mobileprovision_path}

if [ -e ${plist_dstpath} ];then
	${codesign_cmd} -f -s "${certificate_name}" --no-strict --entitlements=${plist_dstpath} ${app_path}
	if [ $? -eq 0 ];then
		${codesign_cmd} -v ${app_path}
	fi
fi

# remove
rm -rf ${plist_srcpath} ${plist_dstpath}

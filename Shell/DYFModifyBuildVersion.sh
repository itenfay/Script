#!/bin/sh

##################################################
#
# Desc   : 修改build版本号
# Author : dyf
# Date   : 2017/03/15
#
##################################################


# 脚本路径
SCRPATH=$SRCROOT/${PROJECT_NAME}
echo "SCRPATH:" ${SCRPATH}

# Info.plist路径
INFOPLIST_PATH=${SCRPATH}/Info.plist
echo "INFOPLIST_PATH:" ${INFOPLIST_PATH}

PLIST_BUDDY=/usr/libexec/PlistBuddy

version=$($PLIST_BUDDY -c "Print CFBundleShortVersionString" "$INFOPLIST_PATH")
build=$($PLIST_BUDDY -c "Print CFBundleVersion" "$INFOPLIST_PATH")

OLD_IFS="$IFS"
IFS="."
versionArr=($version)
buildArr=($build)
IFS="$OLD_IFS"

vlength=${#versionArr[@]}
blength=${#buildArr[*]}

if [ $blength -gt $vlength ];then
	bNumber=$[${buildArr[$[$blength - 1]]} + 1]
	for((idx=0; idx<$vlength; idx++))
	do
		vVal=${versionArr[idx]}
		bVal=${buildArr[idx]}
		if [ $vVal -gt $bVal ];then
			bNumber=1
			break
		fi
	done
else
	bNumber=1
fi

newBuild="${version}.${bNumber}"

$PLIST_BUDDY -c "Set :CFBundleVersion $newBuild" "$INFOPLIST_PATH"

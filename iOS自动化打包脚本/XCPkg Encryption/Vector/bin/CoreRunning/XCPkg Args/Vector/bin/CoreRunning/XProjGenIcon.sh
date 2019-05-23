#!/bin/sh

#-------------------------------------------------------
# 功能：生成Icon各尺寸图
# 说明：
# 1）第一个参数为1024x1024寸Icon图片路径
# 2）第二个参数为Icon图片输出目录
#-------------------------------------------------------
# 作者：dyf
# 邮箱：1659640627@qq.com
# 日期：2016/3/17
#-------------------------------------------------------

if [ $# -lt 2 ];then
	echo 'XProjGenIcon: Warning: enter the path of 1024x1024 png and the output directory after the command.'
	exit 2
fi

if [ ! -e $1 ];then
	echo 'XProjGenIcon: Warning: '$1' not a valid file.'
	exit 2
fi

if [ ! -d $2 ];then
	echo 'XProjGenIcon: Warning: '$2' not a valid directory.'
	exit 2
fi

Icon_srcpath=$1

Icon_dstpath=$2

AppIconNames=(
#iphone
	"29.png"	"29@2x.png" "29@3x.png"
	"40@2x.png" "40@3x.png"
	"57.png"	"57@2x.png"
	"60@2x.png" "60@3x.png"
#ipad
	"29~ipad.png" "29@2x~ipad.png"
	"40~ipad.png" "40@2x~ipad.png"
	"50~ipad.png" "50@2x~ipad.png"
	"72~ipad.png" "72@2x~ipad.png"
	"76~ipad.png" "76@2x~ipad.png"
	"83.5@2x~ipad.png"
)
#echo "AppIconNames: "${AppIconNames[*]}

sips_cmd='sips'

function genrateICON()
{
	size=$1
	name=$2
	${sips_cmd} -Z ${size} ${Icon_srcpath} --out ${Icon_dstpath}/${name}
}

Icon_prefix='AppIcon'

for IconName in ${AppIconNames[@]}
do
	size=`echo ${IconName} | awk -F [@~] '{print $1}'`

	if [[ ${size} =~ 'png' ]];then
		size=${size%.*}
	fi

	scale=`echo ${IconName} | awk -F [@~] '{print $2}' | grep -Eo '[0-9]+'`

	if [ ! ${scale} ];then
		real_size=$(echo "${size}")
	else
		real_size=$(echo "${size} * ${scale}" | bc)
	fi

	Icon_newname=${Icon_prefix}${size}'x'${IconName}

	#echo "size: "$real_size" Icon_newname: "$Icon_newname

	genrateICON ${real_size} ${Icon_newname}
done

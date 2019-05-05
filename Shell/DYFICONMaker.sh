#! /bin/sh

#------------------------------------------------------------------------------
#
# Generates each size image for ICON
#
# Usage: DYFICONMaker -i <path> -o <output directory> [-t ios | mac] [-h]
#
# -i  path  the path of 1024x1024 pixel ICON
# -o  path  the path of output directory for generated images
# -t  type  os type, e.g.: ios or mac, default ios
# -h        help
#
# Author: dyf
# Email : 1659640627@qq.com
# Date  : 2016/3/17
#
#------------------------------------------------------------------------------

help()
{
    echo 'sh DYFICONMaker.sh -i <path> -o <output directory> [-t ios | mac] [-h]'
    echo '-i  path  the path of 1024x1024 pixel ICON'
    echo '-o  path  the path of output directory for generated images'
    echo '-t  type  os type, e.g.: ios or mac, default ios'
    echo '-h        help'
    exit 1
}

guide()
{
    echo 'Error, usage with "cmd -h".'
    exit 1
}

osType='ios'

option=':i:o:t:h'

while getopts $option optname
do
    case "${optname}" in
    'i')
        iconPath=$OPTARG
        ;;
    'o')
        outputDir=$OPTARG
        ;;
    't')
        osType=$OPTARG
        ;;
    'h')
        help
        ;;
    '?')
        guide
        ;;
    ':')
        guide
        ;;
    *)
        guide
        ;;
    esac
done

if [ ! "${iconPath}" -o ! "${outputDir}" ];then
    guide
fi

if [ ! -e ${iconPath} ];then
    echo 'Warning: '${iconPath}' not a valid file.'
    exit 2
fi

if [ ! -d ${outputDir} ];then
    echo 'Warning: '${outputDir}' not a valid directory.'
    exit 3
fi

# 数字部分为ICON尺寸, 新ICON比源ICON尺寸小
# 修改数字即修改ICON尺寸

# MAC
MacAppIconNames=(
 "16.png"  "32.png"
 "64.png"  "128.png"
 "256.png" "512.png"
)

# IOS
IOSAppIconNames=(
 "20.png" "20@2x.png" "20@3x.png"
 "29.png" "29@2x.png" "29@3x.png"
 "40.png" "40@2x.png" "40@3x.png"
 "60@2x.png" "60@3x.png"
 "76.png"    "76@2x.png"
 "83.5@2x.png"
)

AppIconNames=()

if [ ${osType} = 'ios' ];then
    AppIconNames=${IOSAppIconNames[@]}
else
    AppIconNames=${MacAppIconNames[@]}
fi

sips_cmd='/usr/bin/sips'

function genIcon()
{
    size=$1
    name=$2
    ${sips_cmd} -Z ${size} ${iconPath} --out ${outputDir}/${name}
}

Prefix='Icon'

for IconName in ${AppIconNames[@]}
do
    size=`echo ${IconName} | awk -F [@~] '{print $1}'`

    if [[ ${size} =~ 'png' ]];then
        size=${size%.*}
    fi

    scale=`echo ${IconName} | awk -F [@~] '{print $2}' | grep -Eo '[0-9]+'`

    if [ ! ${scale} ];then
        fullsize=$(echo "${size}")
    else
        fullsize=$(echo "${size} * ${scale}" | bc)
    fi

    #new_name=${Prefix}${size}'x'${IconName}
    new_name=${Prefix}'-'${IconName}

    echo 'size : '$fullsize' new_name : '$new_name

    genIcon $fullsize $new_name
done

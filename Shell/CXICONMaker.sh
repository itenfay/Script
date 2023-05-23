#! /bin/sh

#------------------------------------------------------------------------------
#
# Generates each size image for ICON
#
# Usage: CXICONMaker -i <path> -o <output directory> [-t ios | mac] [-h]
#
# -i  path  the path of 1024x1024 pixel ICON
# -o  path  the path of output directory for generated images
# -t  type  os type, e.g.: ios or mac, default ios
# -h        help
#
# Author: chenxing
# Email : chenxing640@foxmail.com
# Date  : 2016/3/17
#
#------------------------------------------------------------------------------

help()
{
    echo 'sh CXICONMaker.sh -i <path> -o <output directory> [-t ios | mac] [-h]'
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
        ICONPath=$OPTARG
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

if [ ! "${ICONPath}" -o ! "${outputDir}" ];then
    guide
fi

if [ ! -e ${ICONPath} ];then
    echo 'Warning: '${ICONPath}' not a valid file.'
    exit 2
fi

if [ ! -d ${outputDir} ];then
    echo 'Warning: '${outputDir}' not a valid directory.'
    exit 3
fi

# 数字部分为ICON尺寸, 新ICON比源ICON尺寸小
# 修改数字即修改ICON尺寸

# MAC
MacAppICONNames=(
 "16.png"  "32.png"
 "64.png"  "128.png"
 "256.png" "512.png"
)

# IOS
IOSAppICONNames=(
 "20.png" "20@2x.png" "20@3x.png"
 "29.png" "29@2x.png" "29@3x.png"
 "40.png" "40@2x.png" "40@3x.png"
 "60@2x.png" "60@3x.png"
 "76.png" "76@2x.png"
 "83.5@2x.png"
)

AppICONNames=()

if [ ${osType} = 'ios' ];then
    AppICONNames=${IOSAppICONNames[@]}
else
    AppICONNames=${MacAppICONNames[@]}
fi

sips_cmd='/usr/bin/sips'

function resizeICON()
{
    size=$1
    name=$2
    ${sips_cmd} -Z ${size} ${ICONPath} --out ${outputDir}/${name}
}

Prefix='AppIcon'

for ICONName in ${AppICONNames[@]}
do
    size=`echo ${ICONName} | awk -F [@~] '{print $1}'`

    if [[ ${size} =~ 'png' ]];then
        size=${size%.*}
    fi

    scale=`echo ${ICONName} | awk -F [@~] '{print $2}' | grep -Eo '[0-9]+'`

    if [ ! ${scale} ];then
        fullsize=$(echo "${size}")
    else
        fullsize=$(echo "${size} * ${scale}" | bc)
    fi

    #new_name=${Prefix}'-'${ICONName}
    new_name=${Prefix}${size}'x'${ICONName}

    echo 'size : '$fullsize' new_name : '$new_name

    resizeICON $fullsize $new_name
done

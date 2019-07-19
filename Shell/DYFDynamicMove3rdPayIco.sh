#!/bin/sh

##################################################
#
# Name：DYFDynamicMove3rdPayIco
# Desc：动态移动三方支付ico
# Date：2017/07/10
# Author：dyf
#
##################################################

# 脚本路径
SCRPATH=$SRCROOT
echo "SCRPATH:" ${SCRPATH}

# 获取参数
usingClientMode=$1
echo "usingClientMode:" ${usingClientMode}

# bundle路径
bundlePath=$SCRPATH/Resources/XOPlatformResource.bundle/Images/XORes.bundle
echo "bundlePath:" ${bundlePath}

# ico所在目录路径
icoDir=$SCRPATH/AppBasic/PayIco
echo "icoDir:" ${icoDir}

payIcos=(
    aliico@2x.png wcico@2x.png
    tenpico@2x.png unionico@2x.png
)

for ico in ${payIcos[@]}
do
    srcPath=${icoDir}/${ico}
    dstPath=${bundlePath}/${ico}
    echo "ico:" ${ico} "srcPath:" ${srcPath} "dstPath:" ${dstPath}
    if [ ${usingClientMode} -eq 1 ];then
        if [ -e ${srcPath} ];then
            mv ${srcPath} ${dstPath}
        fi
    else
        if [ -e ${dstPath} ];then
            mv ${dstPath} ${srcPath}
        fi
    fi
done

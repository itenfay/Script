#! /bin/sh

#------------------------------------------------------------------------------
#
# Delete __MACOSX directory in a Mac zip
#
# Author: chenxing
# Email : chenxing640@foxmail.com
# Date  : 2018/05/25
#
#------------------------------------------------------------------------------

zpath=$1
echo "zpath:" ${zpath}

if [ -e "${zpath}" ];then
    suffix=${zpath##*.}
    echo "suffix:" ${suffix}

    if [ ${suffix} == 'zip' ];then
        macosxDirpath="${zpath}/__MACOSX"
        echo "__MACOSX": ${macosxDirpath}

        zip -d "${zpath}" __MACOSX/\*
    else
        echo "${zpath} is not zip format."
    fi
else
    echo "${zpath} doesn't exist."
fi

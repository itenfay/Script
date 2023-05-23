#!/bin/sh

#-------------------------------------------------------------------------------
# Purpose: 文件转换成
# Author:  chenxing
# Created: 2017-12-21
# update:  2017-12-21
#-------------------------------------------------------------------------------

if [ $# -lt 3 ]; then
    echo "ERROR: The parameter is missing."
    exit 1
fi

# s目录
scrdir=$(dirname $0)
echo "scrdir =" $scrdir

# 进入s目录
cd $scrdir
echo "pwd =" $(pwd)

# 转换类型
m_fctype=$1
echo "m_fctype =" $m_fctype

# 源文件路径
m_srcpath=$2
echo "m_srcpath =" $m_srcpath

# 输出路径
m_dstpath=$3
echo "m_dstpath =" $m_dstpath

convert()
{
    if [ $m_fctype = 'txt' ]; then
        python ./core/excel2txt.py $m_srcpath $m_dstpath
    elif [ $m_fctype = 'xlsx' ]; then
        python ./core/txt2excel.py $m_srcpath $m_dstpath
    else
        echo "ERROR: File conversion type is incorrect."
        exit 1
    fi
}

waiting()
{
    wait
}

convert
waiting

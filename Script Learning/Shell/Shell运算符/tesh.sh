#!/bin/sh

url="http://www.baidu.com"

var="a-b-i4.app"
var=${var##*-}
var=`echo $var | awk -F. '{print $1}'`
echo "var : "$var

build_path="/Users/dyfei/Desktop/Release"

exec_remove_path()
{
if [ -d $build_path -o -e $build_path ]
then
	rm -rf $build_path
fi
}

exec_remove_path

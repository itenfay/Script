#! /bin/sh

#------------------------------------------------------------------------------
#
# Delete .DS_Store and first parameter is true that indicates os
# no longer creates .DS_Store, otherwise creates
#
# Author: chenxing
# Email : chenxing640@foxmail.com
# Date  : 2018/05/25
#
#------------------------------------------------------------------------------

bt='true'
bf='false'

# input first parameter
ifp=$1
echo "input first parameter:" ${ifp}

if [ "${ifp}" == '0' -o "${ifp}" == "false" ]; then
    xp=$bf
fi

if [ "${ifp}" == '1' -o "${ifp}" == "true" ]; then
    xp=$bt
else
    echo "invalid parameter."
    exit 2
fi

echo "bool parameter:" $xp

cd

currDir=$(pwd)
echo "currDir:" ${currDir}

sudo find ./ -name ".DS_Store" -depth -exec rm {} \;

defaults write com.apple.desktopservices DSDontWriteNetworkStores ${xp}

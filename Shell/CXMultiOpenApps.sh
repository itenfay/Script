#!/bin/sh
#
# Created by chenxing 2023/05/24.
#
# Multi-open app for MacOS.
#

argsLen=$#
if test $[argsLen] -lt $[1] ; then
    echo 'Please input a number, e.g.: 1, 2, and so on.' # Input a number between 1 to 4
    exit 1
fi

arg1=$1
echo "Your number is: $arg1"

function multiOpen() {
    case $arg1 in
        1)
        echo "Multi-open WeChat..."
        # -n --new 打开指定App
        # open -n /Applications/WeChat.app/Contents/MacOS/WeChat
        `nohup /Applications/WeChat.app/Contents/MacOS/WeChat > /dev/null 2>&1 &`
        ;;
        2)
        echo "Multi-open QQ..."
        # QQ直接键入 Command+N 就可以打开新窗口
        `nohup /Applications/QQ.app/Contents/MacOS/QQ > /dev/null 2>&1 &`
        ;;
        *)
        echo "只支持多开微信和QQ"
        exit 1
    esac
}

execute() {
    multiOpen
}

# Executes all steps.
execute

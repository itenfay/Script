#! /bin/sh

#------------------------------------------------------------------------------
#
# Shows or hides the files for Mac.
#
# Author: dyf
# Email : 1659640627@qq.com
# Date  : 2018/7/20
#
#------------------------------------------------------------------------------

b=false # Hides the files.

arg1=$1
echo "Input arg:" ${arg1}

if [ "${arg1}" == 'true' -o "${arg1}" == '1' ]; then
    b=true # Shows the files.
fi

# Mac show or hide files.
# Open terminal, Input：

defaults write com.apple.finder AppleShowAllFiles -bool ${b}

# After execute commad, reload Finder with using the shortcut key (option+command+esc), select Finder, reboot it or Command.
killall Finder

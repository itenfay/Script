#!/bin/sh
#
# Created by chenxing 2023/05/23.
#
# Update macOS hosts or refresh DNS.
#

if test $# -lt 1 ; then
    echo "Please input a number: "
    echo "  1 - update hosts."
    echo "  2 - refresh DNS only."
    exit 1
fi

arg1=$1
echo "arg1=$arg1"

content=""
hostsPath=""
finalPath=""

function joinRawContent() {
    echo "######################################"
    echo "Step1: joinRawContent"
    echo "######################################"
    content="${content}##"
    content="${content}\n# Host Database"
    content="${content}\n#"
    content="${content}\n"
    content="${content}\n# localhost is used to configure the loopback interface"
    content="${content}\n# when the system is booting.  Do not change this entry."
    content="${content}\n##"
    content="${content}\n"
    content="${content}\n127.0.0.1    localhost"
    content="${content}\n255.255.255.255    broadcasthost"
    content="${content}\n::1             localhost\n\n"
    echo "Raw Content: \n$content"
}

function getPaths() {
    echo "######################################"
    echo "Step2: getPaths"
    echo "######################################"
    cd ~/Desktop/
    path=`pwd`
    echo "Current Path: $path"
    hostsPath="${path}/tmp-hosts"
    echo "Hosts Path: $hostsPath"
    finalPath="${path}/hosts"
    echo "Final Path: $finalPath\n"
}

# GitHub url: https://github.com/521xueweihan/GitHub520
# Update url: https://raw.hellogithub.com/hosts
function getHosts() {
    echo "######################################"
    echo "Step3: getHosts"
    echo "######################################"
    curlHosts="curl -X GET -o ${hostsPath} https://raw.hellogithub.com/hosts"
    echo "${curlHosts}"
    `${curlHosts}`
    while read line
    do
    lineN="$line\n"
    content="${content}${lineN}"
    done < $hostsPath
    echo "\nFinal Content: \n$content\n"
}

function writeToLocalFile() {
    echo "######################################"
    echo "Step4: writeToLocalFile"
    echo "######################################\n"
    echo ${content} > $finalPath
    cd
}

clean() {
    echo "######################################"
    echo "Step5: clean"
    echo "######################################\n"
    `rm -fr ${hostsPath}`
}

copy() {
    echo "######################################"
    echo "Step6: copy"
    echo "######################################"
    etcHostsPath="/etc/hosts"
    #cpfile="sudo cp -fi ${finalPath} ${etcHostsPath}" #提示确认操作
    cpfile="sudo cp ${finalPath} ${etcHostsPath}"
    echo "${cpfile} \n"
    ${cpfile}
}

updateDNS() {
    if test $1 -eq 1 ; then
        echo "######################################"
        echo "Step7: updateDNS"
        echo "######################################"
    fi
    uDns='sudo killall -HUP mDNSResponder'
    echo "${uDns}"
    # Executes this comand.
    ${uDns}
}

execute() {
    joinRawContent
    getPaths
    getHosts
    writeToLocalFile
    clean
    copy
    updateDNS 1
}

case $arg1 in
    1)
    # Executes all steps.
    execute
    ;;
    2)
    # Updates DNS only.
    updateDNS 0
    ;;
    *)
    echo "Invalid the parameter."
    exit 1
esac

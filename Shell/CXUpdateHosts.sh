#!/bin/sh
#
# Created by chenxing 2023/05/23.
#
# Update hosts.
#

content=""
hostsPath=""
finalPath=""

function joinRawContent() {
    echo "\n**************************************"
    echo "* Step1: joinRawContent"
    echo "**************************************"
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
    echo "**************************************"
    echo "* Step2: getPaths"
    echo "**************************************"
    cd ~/Desktop/
    path=`pwd`
    echo "Current Path: $path"
    hostsPath="${path}/temp-hosts"
    echo "Hosts Path: $hostsPath"
    finalPath="${path}/hosts"
    echo "Final Path: $finalPath\n"
}

function getHosts() {
    echo "**************************************"
    echo "* Step3: getHosts"
    echo "**************************************"
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
    echo "**************************************"
    echo "* Step4: writeToLocalFile"
    echo ${content} > $finalPath
    cd
}

clean() {
    echo "* Step5: clean"
    echo "**************************************\n"
    `rm -fr ${hostsPath}`
}

copy() {
    echo "**************************************"
    echo "* Step6: copy"
    echo "**************************************"
    etcHostsPath="/etc/hosts"
    cpi="sudo cp -fi ${finalPath} ${etcHostsPath}"
    echo "${cpi} \n"
    ${cpi}
}

updateDNS() {
    echo "\n**************************************"
    echo "* Step7: updateDNS"
    echo "**************************************"
    uDns='sudo killall -HUP mDNSResponder'
    echo "${uDns}\n"
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
    updateDNS
}

# Executes all steps.
execute

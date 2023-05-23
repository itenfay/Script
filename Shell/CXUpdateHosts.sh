#! /bin/sh
#
# Created by chenxing 2023/05/23.
#
# Update hosts.
#

content=""
hostsPath=""
finalPath=""

function joinRawContent() {
    echo "Step1: joinRawContent\n"
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
    echo "Raw Content: $content"
}

function getPaths() {
    echo "Step2: getPaths\n"
    cd ~/Desktop/
    path=`pwd`
    echo "CurrPath: $path"
    hostsPath="${path}/temp-hosts"
    echo "Hosts Path: \n$hostsPath"
    finalPath="${path}/hosts"
    echo "Final Path: \n$finalPath\n"
}

function getHosts() {
    echo "Step3: getHosts\n"
    curlHosts="curl -X GET -o ${hostsPath} https://raw.hellogithub.com/hosts"
    echo "${curlHosts}"
    `${curlHosts}`
    while read line
    do
        lineN="$line\n"
        content="${content}${lineN}"
    done < $hostsPath
    echo "Final Content: \n$content\n"
}

function writeToLocalFile() {
    echo "Step4: writeToLocalFile\n"
    echo ${content} > $finalPath
    cd
}

clean() {
    echo "Step5: clean\n"
    `rm -fr ${hostsPath}`
}

finish() {
    echo "Step6: finish\n"
    etcHostsPath="/etc/hosts"
    cpi="sudo cp -fi ${finalPath} ${etcHostsPath}"
    echo ${cpi}
    ${cpi}
}

updateDNS() {
    echo "Step7: updateDNS\n"
    uDns='sudo killall -HUP mDNSResponder'
    echo "${uDns}"
    # Executes the comand.
    ${uDns}
}

execute() {
    joinRawContent
    getPaths
    getHosts
    writeToLocalFile
    clean
    finish
    updateDNS
}

execute

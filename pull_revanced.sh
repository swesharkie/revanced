#!/bin/bash
url=$(curl -s "https://api.github.com/repos/NoName-exe/revanced-extended/releases/latest" \ | jq -r '.assets[] | .browser_download_url' | grep https.*youtube-revanced-extended-v.*\.apk)
filename=$(echo $url | sed -nr 's/.*(youtube-revanced-extended-v.*\.apk)/\1/p')
if grep -Fxq "$filename" downloaded.txt
then
    echo "true"
else
    curl -LO $url
    echo $filename >> downloaded.txt
    find . -type f -name "youtube-revanced-extended-v*.apk" -execdir bash -c 'mv "$0" "youtube-revanced-extended-latest.apk"' {} \;
fi

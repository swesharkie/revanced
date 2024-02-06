#!/bin/bash
url=$(curl -s "https://api.github.com/repos/NoName-exe/revanced-extended/releases/latest" \ | jq -r '.assets[] | .browser_download_url' | grep https.*youtube-revanced-extended-v.*\.apk)
filename=$(echo $url | sed -nr 's/.*(youtube-revanced-extended-v.*\.apk)/\1/p')
if grep -Fxq "$filename" downloaded.txt
then
    echo "nothing new"
else
    curl -LO $url
    echo $filename >> downloaded.txt
    find . -type f -name "youtube-revanced-extended-v*.apk" -execdir bash -c 'mv "$0" "youtube-revanced-extended-latest.apk"' {} \;
    version=$(echo $filename | sed -nr 's/.*v(.*)-all\.apk/\1/p')
    git add -u
    git commit -m "New version! $version"
    git push
fi

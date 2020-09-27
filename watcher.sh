#!/bin/bash

if  [[ $1 = "-c" ]] # Chromium
then
        browser_folder = ~/.cache/chromium/Default/Cache
elif [  $1 = "-g" ] # Google Chrome
then
        browser_folder = ~/.cache/google-chrome/Default/Cache
elif [  $1 = "-f" ] # Firefox
then
        echo "Firefox: Not implemented yet"
elif [  $1 = "-s" ] # Safari
then
        echo "Safari: Not implemented yet"
elif [  $1 = "-o" ] # Opera
then
        echo "Opera: Not implemented yet"
elif [  $1 = "-b" ] # Brave
then
        echo "Brave: Not implemented yet"
else
        browser_folder = ~/.cache/chromium/Default/Cache
fi

folder=$(date | md5sum | cut -d' ' -f1)

mkdir /tmp/http-$folder/
touch /tmp/http-$folder/cache.log

inotifywait -m $browser_folder -e create |
    while read dir action file; do
        echo [$(date "+%Y/%m/%d %H:%M:%S")] - $(cat $dir$file | grep -aEo "(http|https)://[a-zA-Z0-9./?=_%:+-]*") >> /tmp/http-$folder/activity-$folder.log
    done

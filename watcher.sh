#!/bin/bash

folder=$(date | md5sum | cut -d' ' -f1)

mkdir /tmp/http-$folder/
touch /tmp/http-$folder/cache.log

inotifywait -m ~/.cache/chromium/Default/Cache -e create |
    while read dir action file; do
        echo [$(date "+%Y/%m/%d %H:%M:%S")] - $(cat $dir$file | grep -aEo "(http|https)://[a-zA-Z0-9./?=_%:+-]*") >> /tmp/http-$folder/activity-$folder.log
    done

#!/bin/bash

if  [ $1 = "-c" ] # Chromium
then
        browser=chromium
        browser_folder=~/.cache/chromium/Default/Cache
elif [  $1 = "-g" ] # Google Chrome
then
        browser=google-chrome
        browser_folder=~/.cache/google-chrome/Default/Cache
elif [  $1 = "-f" ] # Firefox
then
        echo "Firefox: Not implemented yet, but Firefox ESR available with -fesr option"
elif [  $1 = "-fesr" ] # Firefox ESR
then
        browser=firefox-esr
        browser_folder=~/.cache/mozilla/firefox/*.default-esr/cache2/entries
elif [  $1 = "-s" ] # Safari
then
        echo "Safari: Not implemented yet (Never ?)"
elif [  $1 = "-o" ] # Opera
then
        browser=opera
        browser_folder=~/.cache/opera/Cache
elif [  $1 = "-b" ] # Brave
then
        echo "Brave: Not implemented yet"
else
        browser_folder=~/.cache/chromium/Default/Cache
fi

name=$(date | md5sum | cut -d' ' -f1)
folder=/tmp/http-$browser-$name/

mkdir $folder

inotifywait -m $browser_folder -e create |
    while read dir action file; do
        echo [$(date "+%Y/%m/%d %H:%M:%S")] - $(cat $dir$file | grep -aEo "(http|https)://[a-zA-Z0-9./?=_%:+-\&]*") >> $folder$name.log
    done

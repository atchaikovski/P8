#!/bin/bash

msg=$1

if [ "$msg" == "" ]; then

 msg = "another attempt"
fi

md5sum index.html >md5sum.txt

git add .
git commit -m $msg
git push -u origin main


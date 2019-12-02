#!/usr/bin/env bash

cd /Users/wuruoye/Documents/flutter/all/all
/./Applications/flutter/bin/flutter build web
rm -rf build/web/assets/assets/fonts
ssh ubuntu@wuruoye.com "rm -rf /home/ubuntu/www/all"
scp -r -q build/web ubuntu@wuruoye.com:/home/ubuntu/www/all
#!/bin/bash

rsync -arv --delete --include '*/' --include '*.markdown' \
--exclude '*' --prune-empty-dirs \
/Users/jtqiu/develop/lwwd/chapters/**/. \
/Users/jtqiu/develop/lwwd/octopress/source/_posts/.

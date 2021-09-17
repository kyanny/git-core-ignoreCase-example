#!/bin/bash
set -x

git --version

repo=ignoreCase-false-rename-file

rm -rf /tmp/$repo

git init /tmp/$repo
cd /tmp/$repo
git config core.ignoreCase
git config core.ignoreCase false
git commit --allow-empty -m "Initial commit"

date +%s > A.txt
git add A.txt
git commit -m "Add A.txt"
git mv A.txt a.txt || git mv -f A.txt a.txt
git add a.txt
git commit -m "git mv (-f) A.txt a.txt"

git log --oneline /tmp/$repo/a.txt
git log --oneline --follow /tmp/$repo/a.txt

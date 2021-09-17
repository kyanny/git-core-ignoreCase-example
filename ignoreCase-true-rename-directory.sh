#!/bin/bash
set -x

git --version

repo=ignoreCase-true-rename-directory

rm -rf /tmp/$repo

git init /tmp/$repo
cd /tmp/$repo
git config core.ignoreCase
git config core.ignoreCase true
git commit --allow-empty -m "Initial commit"

mkdir -p 0A
date +%s > 0A/A.txt
git add 0A
git commit -m "Create 0A/"
git mv 0A 0a || git mv -f 0A 0a || git mv 0A _tmp && git mv _tmp 0a
git add 0a
git commit -m "git mv 0A -> 0a"

git log --oneline /tmp/$repo/0a
git log --oneline --follow /tmp/$repo/0a
git log --oneline /tmp/$repo/0a/A.txt
git log --oneline --follow /tmp/$repo/0a/A.txt

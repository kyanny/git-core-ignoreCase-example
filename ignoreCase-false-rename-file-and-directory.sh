#!/bin/bash
set -x

git --version

repo=ignoreCase-false-rename-file-and-directory

rm -rf /tmp/$repo

git init /tmp/$repo
cd /tmp/$repo
git config core.ignoreCase
git config core.ignoreCase false
git commit --allow-empty -m "Initial commit"

mkdir -p 0A
date +%s > 0A/A.txt
git add 0A
git commit -m "Create 0A/"
git mv 0A _tmp && git mv _tmp 0a && git mv 0a/A.txt 0a/a.txt || git mv -f 0a/A.txt 0a/a.txt
git add 0a
git commit -m "git mv 0A/A.txt -> 0a/a.txt"

git log --oneline /tmp/$repo/0a
git log --oneline --follow /tmp/$repo/0a
git log --oneline /tmp/$repo/0a/a.txt
git log --oneline --follow /tmp/$repo/0a/a.txt

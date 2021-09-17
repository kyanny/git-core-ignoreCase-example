# git-core-ignoreCase-example

Collection of the shell scripts that tests how `git mv` and `core.ignoreCase` option works.

## TL;DR

- To rename file in a case-sensitive manner, do `git mv`.

```sh
git mv A.txt a.txt
```

If it fails, add `-f` option.

```
git mv -f A.txt a.txt
```

For renaming file, `git mv`'s behavior slightly changes by [`core.ignoreCase`](https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreignoreCase) option setting. To learn more, check the output of [*ignoreCase-false-rename-file.sh*](https://github.com/kyanny/git-core-ignoreCase-example#ignorecase-false-rename-filesh) script and [*ignoreCase-true-rename-file.sh*](https://github.com/kyanny/git-core-ignoreCase-example#ignorecase-true-rename-filesh) script below.

- To rename directory in a case-sensitive manner, do `git mv` twice.

```
git mv 0A/ _tmp/ && git mv _tmp/ 0a
```

- To rename file and directory at once, do above `git mv` operations in a row. Order doesn't matter.

```
git mv 0A/ _tmp/ && git mv _tmp/ 0a && git mv -f 0a/A.txt 0a/a.txt
# You can do `git mv` for file first, too.
git mv -f 0A/A.txt 0A/a.txt && git mv 0A/ _tmp/ && git mv _tmp/ 0a/
```

# How to run test scripts

```sh
for sh in $(ls *.sh);
do
  printf "## $sh\n"
  bash $sh
done
```

## ignoreCase-false-rename-directory.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-false-rename-directory
+ rm -rf /tmp/ignoreCase-false-rename-directory
+ git init /tmp/ignoreCase-false-rename-directory
Initialized empty Git repository in /private/tmp/ignoreCase-false-rename-directory/.git/
+ cd /tmp/ignoreCase-false-rename-directory
+ git config core.ignoreCase
true
+ git config core.ignoreCase false
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) 4a6886e] Initial commit
+ mkdir -p 0A
+ date +%s
+ git add 0A
+ git commit -m 'Create 0A/'
[main c989401] Create 0A/
 1 file changed, 1 insertion(+)
 create mode 100644 0A/A.txt
+ git mv 0A 0a
fatal: renaming '0A' failed: Invalid argument
+ git mv -f 0A 0a
fatal: renaming '0A' failed: Invalid argument
+ git mv 0A _tmp
+ git mv _tmp 0a
+ git add 0a
+ git commit -m 'git mv 0A -> 0a'
[main 8ebfce0] git mv 0A -> 0a
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {0A => 0a}/A.txt (100%)
+ git log --oneline /tmp/ignoreCase-false-rename-directory/0a
8ebfce0 git mv 0A -> 0a
+ git log --oneline --follow /tmp/ignoreCase-false-rename-directory/0a
8ebfce0 git mv 0A -> 0a
+ git log --oneline /tmp/ignoreCase-false-rename-directory/0a/A.txt
8ebfce0 git mv 0A -> 0a
+ git log --oneline --follow /tmp/ignoreCase-false-rename-directory/0a/A.txt
8ebfce0 git mv 0A -> 0a
c989401 Create 0A/
```

## ignoreCase-false-rename-file-and-directory.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-false-rename-file-and-directory
+ rm -rf /tmp/ignoreCase-false-rename-file-and-directory
+ git init /tmp/ignoreCase-false-rename-file-and-directory
Initialized empty Git repository in /private/tmp/ignoreCase-false-rename-file-and-directory/.git/
+ cd /tmp/ignoreCase-false-rename-file-and-directory
+ git config core.ignoreCase
true
+ git config core.ignoreCase false
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) 4a6886e] Initial commit
+ mkdir -p 0A
+ date +%s
+ git add 0A
+ git commit -m 'Create 0A/'
[main c989401] Create 0A/
 1 file changed, 1 insertion(+)
 create mode 100644 0A/A.txt
+ git mv 0A _tmp
+ git mv _tmp 0a
+ git mv 0a/A.txt 0a/a.txt
fatal: destination exists, source=0a/A.txt, destination=0a/a.txt
+ git mv -f 0a/A.txt 0a/a.txt
+ git add 0a
+ git commit -m 'git mv 0A/A.txt -> 0a/a.txt'
[main a8304c2] git mv 0A/A.txt -> 0a/a.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename 0A/A.txt => 0a/a.txt (100%)
+ git log --oneline /tmp/ignoreCase-false-rename-file-and-directory/0a
a8304c2 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline --follow /tmp/ignoreCase-false-rename-file-and-directory/0a
a8304c2 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline /tmp/ignoreCase-false-rename-file-and-directory/0a/a.txt
a8304c2 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline --follow /tmp/ignoreCase-false-rename-file-and-directory/0a/a.txt
a8304c2 git mv 0A/A.txt -> 0a/a.txt
c989401 Create 0A/
```

## ignoreCase-false-rename-file.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-false-rename-file
+ rm -rf /tmp/ignoreCase-false-rename-file
+ git init /tmp/ignoreCase-false-rename-file
Initialized empty Git repository in /private/tmp/ignoreCase-false-rename-file/.git/
+ cd /tmp/ignoreCase-false-rename-file
+ git config core.ignoreCase
true
+ git config core.ignoreCase false
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) e72c3a8] Initial commit
+ date +%s
+ git add A.txt
+ git commit -m 'Add A.txt'
[main b30cd28] Add A.txt
 1 file changed, 1 insertion(+)
 create mode 100644 A.txt
+ git mv A.txt a.txt
fatal: destination exists, source=A.txt, destination=a.txt
+ git mv -f A.txt a.txt
+ git add a.txt
+ git commit -m 'git mv (-f) A.txt a.txt'
[main 80f99cf] git mv (-f) A.txt a.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename A.txt => a.txt (100%)
+ git log --oneline /tmp/ignoreCase-false-rename-file/a.txt
80f99cf git mv (-f) A.txt a.txt
+ git log --oneline --follow /tmp/ignoreCase-false-rename-file/a.txt
80f99cf git mv (-f) A.txt a.txt
b30cd28 Add A.txt
```

## ignoreCase-true-rename-directory.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-true-rename-directory
+ rm -rf /tmp/ignoreCase-true-rename-directory
+ git init /tmp/ignoreCase-true-rename-directory
Initialized empty Git repository in /private/tmp/ignoreCase-true-rename-directory/.git/
+ cd /tmp/ignoreCase-true-rename-directory
+ git config core.ignoreCase
true
+ git config core.ignoreCase true
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) e72c3a8] Initial commit
+ mkdir -p 0A
+ date +%s
+ git add 0A
+ git commit -m 'Create 0A/'
[main 91773a4] Create 0A/
 1 file changed, 1 insertion(+)
 create mode 100644 0A/A.txt
+ git mv 0A 0a
fatal: renaming '0A' failed: Invalid argument
+ git mv -f 0A 0a
fatal: renaming '0A' failed: Invalid argument
+ git mv 0A _tmp
+ git mv _tmp 0a
+ git add 0a
+ git commit -m 'git mv 0A -> 0a'
[main ef8fbd2] git mv 0A -> 0a
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {0A => 0a}/A.txt (100%)
+ git log --oneline /tmp/ignoreCase-true-rename-directory/0a
ef8fbd2 git mv 0A -> 0a
+ git log --oneline --follow /tmp/ignoreCase-true-rename-directory/0a
ef8fbd2 git mv 0A -> 0a
+ git log --oneline /tmp/ignoreCase-true-rename-directory/0a/A.txt
ef8fbd2 git mv 0A -> 0a
+ git log --oneline --follow /tmp/ignoreCase-true-rename-directory/0a/A.txt
ef8fbd2 git mv 0A -> 0a
91773a4 Create 0A/
```

## ignoreCase-true-rename-file-and-directory.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-true-rename-file-and-directory
+ rm -rf /tmp/ignoreCase-true-rename-file-and-directory
+ git init /tmp/ignoreCase-true-rename-file-and-directory
Initialized empty Git repository in /private/tmp/ignoreCase-true-rename-file-and-directory/.git/
+ cd /tmp/ignoreCase-true-rename-file-and-directory
+ git config core.ignoreCase
true
+ git config core.ignoreCase true
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) e72c3a8] Initial commit
+ mkdir -p 0A
+ date +%s
+ git add 0A
+ git commit -m 'Create 0A/'
[main 91773a4] Create 0A/
 1 file changed, 1 insertion(+)
 create mode 100644 0A/A.txt
+ git mv 0A _tmp
+ git mv _tmp 0a
+ git mv 0a/A.txt 0a/a.txt
+ git add 0a
+ git commit -m 'git mv 0A/A.txt -> 0a/a.txt'
[main 9a8d950] git mv 0A/A.txt -> 0a/a.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename 0A/A.txt => 0a/a.txt (100%)
+ git log --oneline /tmp/ignoreCase-true-rename-file-and-directory/0a
9a8d950 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline --follow /tmp/ignoreCase-true-rename-file-and-directory/0a
9a8d950 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline /tmp/ignoreCase-true-rename-file-and-directory/0a/a.txt
9a8d950 git mv 0A/A.txt -> 0a/a.txt
+ git log --oneline --follow /tmp/ignoreCase-true-rename-file-and-directory/0a/a.txt
9a8d950 git mv 0A/A.txt -> 0a/a.txt
91773a4 Create 0A/
```

## ignoreCase-true-rename-file.sh

```sh
+ git --version
git version 2.32.0
+ repo=ignoreCase-true-rename-file
+ rm -rf /tmp/ignoreCase-true-rename-file
+ git init /tmp/ignoreCase-true-rename-file
Initialized empty Git repository in /private/tmp/ignoreCase-true-rename-file/.git/
+ cd /tmp/ignoreCase-true-rename-file
+ git config core.ignoreCase
true
+ git config core.ignoreCase true
+ git commit --allow-empty -m 'Initial commit'
[main (root-commit) e72c3a8] Initial commit
+ date +%s
+ git add A.txt
+ git commit -m 'Add A.txt'
[main b30cd28] Add A.txt
 1 file changed, 1 insertion(+)
 create mode 100644 A.txt
+ git mv A.txt a.txt
+ git add a.txt
+ git commit -m 'git mv (-f) A.txt a.txt'
[main 80f99cf] git mv (-f) A.txt a.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename A.txt => a.txt (100%)
+ git log --oneline /tmp/ignoreCase-true-rename-file/a.txt
80f99cf git mv (-f) A.txt a.txt
+ git log --oneline --follow /tmp/ignoreCase-true-rename-file/a.txt
80f99cf git mv (-f) A.txt a.txt
b30cd28 Add A.txt
```

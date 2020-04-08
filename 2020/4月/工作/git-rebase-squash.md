# git 多个commit 合并为一个commit 

### 帮助
https://git-scm.com/docs/git-rebase
https://help.github.com/cn/github/using-git/about-git-rebase
https://www.swack.cn/wiki/0015584169400261c43b924ee334788aa13a5674638e280000/001561947910677fc64a21aae384ec39889ec1ae3b688d7000

### 1 git cherry-pick 
cherry-pick mr 

### 2 rebase 
1. git rebase -i HEAD~n
2. 或者 git rebase -i 所有合并的commit id  之前

### 3 chang 
除了第一个pick
其他commit pick -> squash 

### 4 commit
完善 commit 信息

### 5 push 
推送

### 提示
这里所有操作可以通过 git 数据完善，学会这个流程，更容易学习git  

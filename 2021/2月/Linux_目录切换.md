一、目录栈指令

目录栈是用户最近访问过的系统目录列表，并以堆栈的形式管理。栈中的内容与Shell环境变量DIRSTACK的值对应

1、dirs

1）功能
显示当前目录栈中的所有记录（不带参数的dirs命令显示当前目录栈中的记录）

2）语法
（1）格式：dirs [-clpv] [+n] [-n]
（2）选项
-c  删除目录栈中的所有记录
-l   以完整格式显示
-p  一个目录一行的方式显示
-v  每行一个目录来显示目录栈的内容，每个目录前加上的编号
+N 显示从左到右的第n个目录，数字从0开始
-N  显示从右到左的第n个日录，数字从0开始
注意：dirs始终显示当然目录, 再是堆栈中的内容；即使目录堆栈为空, dirs命令仍然只显示当然目录

2、pushd

1）功能
pushd命令常用于将目录加入到栈中，加入记录到目录栈顶部，并切换到该目录；若pushd命令不加任何参数，则会将位于记录栈最上面的2个目录对换位置

2）语法
（1）格式：pushd [目录 | -N | +N]  [-n]
（2）选项
目录  将该目录加入到栈顶，并执行"cd 目录"，切换到该目录
+N  将第N个目录移至栈顶（从左边数起，数字从0开始）
-N  将第N个目录移至栈顶（从右边数起，数字从0开始）
-n  将目录入栈时，不切换目录

3、popd

1）功能
popd用于删除目录栈中的记录；如果popd命令不加任何参数，则会先删除目录栈最上面的记录，然后切换到删除过后的目录栈中的最上面的目录

2）语法
（1）格式：pushd [-N | +N]  [-n]
（2）选项
+N  将第N个目录删除（从左边数起，数字从0开始）
-N  将第N个目录删除（从右边数起，数字从0开始）
-n  将目录出栈时，不切换目录


二、 示例

**入栈与出栈**
[root@root](mailto:root@root):~# mkdir /root/dir{1,2,3,4}
[root@root](mailto:root@root):~# for ((i=1;i<=4;i++)); do pushd /root/dir${i}; done
/root/dir1 ~
/root/dir2 /root/dir1 ~
/root/dir3 /root/dir2 /root/dir1 ~
/root/dir4 /root/dir3 /root/dir2 /root/dir1 ~

[root@root:/root/dir4](mailto:root@root:/root/dir4)# dirs 
/root/dir4 /root/dir3 /root/dir2 /root/dir1 ~
dirs显出了栈中的所有目录

[root@root:/root/dir4](mailto:root@root:/root/dir4)# popd（相当于popd +0）
/root/dir3 /root/dir2 /root/dir1 ~
[root@root:/root/dir4](mailto:root@root:/root/dir4)# dirs
/root/dir3 /root/dir2 /root/dir1 ~
可以看出/root/dir4目录已被清除，此时栈里已经没有了dir4目录，切当前目录切换为dir3

[root@root:/root/dir3](mailto:root@root:/root/dir3)# pushd /root/dir4 
/root/dir4 /root/dir3 /root/dir2 /root/dir1 ~
不推荐以上面的方法进行切换，因为这种方式和cd没有区别。

[root@root:/root/dir4](mailto:root@root:/root/dir4)# popd +1
/root/dir4 /root/dir2 /root/dir1 ~
推荐以这种方式进行切换，尤其是目录层次比较多时

[root@root:/root/dir4](mailto:root@root:/root/dir4)# popd -2
/root/dir4 /root/dir1 ~

[root@root:/root/dir2](mailto:root@root:/root/dir2)# pushd -1
/root/dir1 ~ /root/dir2 /root/dir3 /root/dir4
注意：最左边表示栈顶，最右边表示栈底

**清空栈**
[root@root](mailto:root@root):~# dirs
~ /root/dir2 /root/dir3 /root/dir4 /root/dir1
[root@root](mailto:root@root):~# dirs -c
[root@root](mailto:root@root):~# dirs
~

**列表形式显示的栈的内容**
[root@root:/root/dir4](mailto:root@root:/root/dir4)# dirs -l -v
0 /root/dir4
1 /root/dir3
2 /root/dir2
3 /root/dir1
4 /root
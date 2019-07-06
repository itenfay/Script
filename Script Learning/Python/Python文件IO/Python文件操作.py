#!/usr/bin/python
#coding=utf-8

#打开和关闭文件

#Python 提供了必要的函数和方法进行默认情况下的文件基本操作。
#你可以用 file 对象做大部分的文件操作。

#open 函数
#你必须先用Python内置的open()函数打开一个文件，创建一个file对象，相关的方法才可以调用它进行读写。
#语法：
#file object = open(file_name [, access_mode][, buffering])
#各个参数的细节如下：
#file_name：file_name变量是一个包含了你要访问的文件名称的字符串值。
#access_mode：access_mode决定了打开文件的模式：只读，写入，追加等。所有可取值见如下的完全列表。这个参数是非强制的，默认文件访问模式为只读(r)。
#buffering:如果buffering的值被设为0，就不会有寄存。如果buffering的值取1，访问文件时会寄存行。如果将buffering的值设为大于1的整数，表明了这就是的寄存区的缓冲大小。如果取负值，寄存区的缓冲大小则为系统默认。

#不同模式打开文件的完全列表：
#模式      描述
#r       以只读方式打开文件。文件的指针将会放在文件的开头。这是默认模式。
#rb      以二进制格式打开一个文件用于只读。文件指针将会放在文件的开头。这是默认模式。
#r+      打开一个文件用于读写。文件指针将会放在文件的开头。
#rb+     以二进制格式打开一个文件用于读写。文件指针将会放在文件的开头。
#w       打开一个文件只用于写入。如果该文件已存在则将其覆盖。如果该文件不存在，创建新文件。
#wb      以二进制格式打开一个文件只用于写入。如果该文件已存在则将其覆盖。如果该文件不存在，创建新文件。
#w+      打开一个文件用于读写。如果该文件已存在则将其覆盖。如果该文件不存在，创建新文件。
#wb+     以二进制格式打开一个文件用于读写。如果该文件已存在则将其覆盖。如果该文件不存在，创建新文件。
#a       打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。
#        如果该文件不存在，创建新文件进行写入。
#ab      以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。
#        也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。
#a+      打开一个文件用于读写。如果该文件已存在，文件指针将会放在文件的结尾。文件打开时会是追加模式。
#        如果该文件不存在，创建新文件用于读写。
#ab+     以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。
#        如果该文件不存在，创建新文件用于读写。

#File对象的属性
#一个文件被打开后，你有一个file对象，你可以得到有关该文件的各种信息。
#以下是和file对象相关的所有属性的列表：
#属性             描述
#file.closed     返回true如果文件已被关闭，否则返回false。
#file.mode       返回被打开文件的访问模式。
#file.name       返回文件的名称。
#file.softspace	如果用print输出后，必须跟一个空格符，则返回false。否则返回true。

#打开一个文件
fo = open("foo.txt", "wb+")
print "文件名 : ", fo.name
print "是否已关闭 : ", fo.closed
print "访问模式 : ", fo.mode
print "末尾是否强制加空格 : ", fo.softspace

#close()方法
#File 对象的 close（）方法刷新缓冲区里任何还没写入的信息，并关闭该文件，这之后便不能再进行写入。
#当一个文件对象的引用被重新指定给另一个文件时，Python 会关闭之前的文件。
#用 close（）方法关闭文件是一个很好的习惯。
#语法：
#fileObject.close()

#fo.close()

#读写文件：
#file对象提供了一系列方法，能让我们的文件访问更轻松。来看看如何使用read()和write()方法来读取和写入文件。
#write()方法
#write()方法可将任何字符串写入一个打开的文件。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。
#Write()方法不在字符串的结尾不添加换行符('\n')：
#语法：
#fileObject.write(string);

fo.write("Python 是一个非常好的语言。\n是的，的确非常好!!")

fo.close()

#read()方法
#read（）方法从一个打开的文件中读取一个字符串。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。
#语法：
#fileObject.read([count]);
#在这里，被传递的参数是要从已打开文件中读取的字节计数。
#该方法从文件的开头开始读入，如果没有传入count，它会尝试尽可能多地读取更多的内容，很可能是直到文件的末尾

fo = open("foo.txt", "r+")
str = fo.read()
print "读取的字符串是 :", str

fo.close()

#文件定位
#tell()方法告诉你文件内的当前位置；换句话说，下一次的读写会发生在文件开头这么多字节之后。
#seek（offset [,from]）方法改变当前文件的位置。Offset变量表示要移动的字节数。From变量指定开始移动字节的参考位置。
#如果from被设为0，这意味着将文件的开头作为移动字节的参考位置。
#如果设为1，则使用当前的位置作为参考位置。如果它被设为2，那么该文件的末尾将作为参考位置。

#打开一个文件
fo = open("foo.txt", "r+")
str = fo.read(10)
print "读取的字符串是 :", str

#查找当前位置
pos = fo.tell()
print "文件当前位置：", pos

#把指针再次重新定位到文件开头
pos = fo.seek(0, 0)
print "文件当前位置 :", fo.tell()
str = fo.read()
print "读取的字符串是 :", str

#关闭文件
fo.close()

#重命名和删除文件

#Python的os模块提供了帮你执行文件处理操作的方法，比如重命名和删除文件。
#要使用这个模块，你必须先导入它，然后才可以调用相关的各种功能。
#rename()方法：
#rename()方法需要两个参数，当前的文件名和新文件名。
#语法：
#os.rename(current_file_name, new_file_name)

import os

try:
    # 重命名文件test.txt到test1.txt。
    os.rename("test.txt", "test1.txt")
except OSError:
    print "文件不存在！！！"

#remove()方法
#你可以用remove()方法删除文件，需要提供要删除的文件名作为参数。
#语法：
#os.remove(file_name)

try:
    os.remove("test1.txt")
except OSError:
    print "文件不存在！！！"

#Python里的目录：
#所有文件都包含在各个不同的目录下，不过Python也能轻松处理。
#os模块有许多方法能帮你创建，删除和更改目录。

#mkdir()方法
#可以使用os模块的mkdir()方法在当前目录下创建新的目录们。你需要提供一个包含了要创建的目录名称的参数。
#语法：
#os.mkdir("newdir")

try:
    os.mkdir("test")
except OSError:
    print "目录已经存在"

#chdir()方法
#可以用chdir()方法来改变当前的目录。chdir()方法需要的一个参数是你想设成当前目录的目录名称。
#语法：
#os.chdir("newdir")

os.chdir("./test/")

#getcwd()方法：
#getcwd()方法显示当前的工作目录。
#语法：
#os.getcwd()

print os.getcwd()

#rmdir()方法
#rmdir()方法删除目录，目录名称以参数传递。
#在删除这个目录之前，它的所有内容应该先被清除。
#语法：
#os.rmdir('dirname')

os.chdir('..')
print os.getcwd()
os.rmdir("test")

#文件、目录相关的方法
#三个重要的方法来源能对Windows和Unix操作系统上的文件及目录进行一个广泛且实用的处理及操控，如下：
#File 对象方法: file对象提供了操作文件的一系列方法。
#OS 对象方法: 提供了处理文件及目录的一系列方法。

#Python File(文件) 方法
#file 对象使用 open 函数来创建，下表列出了 file 对象常用的函数：
#序号	方法及描述
#1   file.close()
#    关闭文件。关闭后文件不能再进行读写操作。
#2   file.flush()
#    刷新文件内部缓冲，直接把内部缓冲区的数据立刻写入文件, 而不是被动的等待输出缓冲区写入。
#3   file.fileno()
#    返回一个整型的文件描述符(file descriptor FD 整型), 可以用在如os模块的read方法等一些底层操作上。
#4   file.isatty()
#    如果文件连接到一个终端设备返回 True，否则返回 False。
#5   file.next()
#    返回文件下一行。
#6   file.read([size])
#    从文件读取指定的字节数，如果未给定或为负则读取所有。
#7   file.readline([size])
#    读取整行，包括 "\n" 字符。
#8   file.readlines([sizehint])
#    读取所有行并返回列表，若给定sizeint>0，返回总和大约为sizeint字节的行,
#        实际读取值可能比sizhint较大, 因为需要填充缓冲区。
#9   file.seek(offset[, whence])
#    设置文件当前位置
#10  file.tell()
#    返回文件当前位置。
#11  file.truncate([size])
#    截取文件，截取的字节通过size指定，默认为当前文件位置。
#12  file.write(str)
#    将字符串写入文件，没有返回值。
#13  file.writelines(sequence)
#    向文件写入一个序列字符串列表，如果需要换行则要自己加入每行的换行符。

#Python OS 文件/目录方法
#os 模块提供了非常丰富的方法用来处理文件和目录。常用的方法如下表所示：
#序号	方法及描述
#1
#os.access(path, mode)
#
#检验权限模式
#2
#os.chdir(path)
#
#改变当前工作目录
#3
#os.chflags(path, flags)
#
#设置路径的标记为数字标记。
#4
#os.chmod(path, mode)
#
#更改权限
#5
#os.chown(path, uid, gid)
#
#更改文件所有者
#6
#os.chroot(path)
#
#改变当前进程的根目录
#7
#os.close(fd)
#
#关闭文件描述符 fd
#8
#os.closerange(fd_low, fd_high)
#
#关闭所有文件描述符，从 fd_low (包含) 到 fd_high (不包含), 错误会忽略
#9
#os.dup(fd)
#
#复制文件描述符 fd
#10
#os.dup2(fd, fd2)
#
#将一个文件描述符 fd 复制到另一个 fd2
#11
#os.fchdir(fd)
#
#通过文件描述符改变当前工作目录
#12
#os.fchmod(fd, mode)
#
#改变一个文件的访问权限，该文件由参数fd指定，参数mode是Unix下的文件访问权限。
#13
#os.fchown(fd, uid, gid)
#
#修改一个文件的所有权，这个函数修改一个文件的用户ID和用户组ID，该文件由文件描述符fd指定。
#14
#os.fdatasync(fd)
#
#强制将文件写入磁盘，该文件由文件描述符fd指定，但是不强制更新文件的状态信息。
#15
#os.fdopen(fd[, mode[, bufsize]])
#
#通过文件描述符 fd 创建一个文件对象，并返回这个文件对象
#16
#os.fpathconf(fd, name)
#
#返回一个打开的文件的系统配置信息。name为检索的系统配置的值，它也许是一个定义系统值的字符串，这些名字在很多标准中指定（POSIX.1, Unix 95, Unix 98, 和其它）。
#17
#os.fstat(fd)
#
#返回文件描述符fd的状态，像stat()。
#18
#os.fstatvfs(fd)
#
#返回包含文件描述符fd的文件的文件系统的信息，像 statvfs()
#19
#os.fsync(fd)
#
#强制将文件描述符为fd的文件写入硬盘。
#20
#os.ftruncate(fd, length)
#
#裁剪文件描述符fd对应的文件, 所以它最大不能超过文件大小。
#21
#os.getcwd()
#
#返回当前工作目录
#22
#os.getcwdu()
#
#返回一个当前工作目录的Unicode对象
#23
#os.isatty(fd)
#
#如果文件描述符fd是打开的，同时与tty(-like)设备相连，则返回true, 否则False。
#24
#os.lchflags(path, flags)
#
#设置路径的标记为数字标记，类似 chflags()，但是没有软链接
#25
#os.lchmod(path, mode)
#
#修改连接文件权限
#26
#os.lchown(path, uid, gid)
#
#更改文件所有者，类似 chown，但是不追踪链接。
#27
#os.link(src, dst)
#
#创建硬链接，名为参数 dst，指向参数 src
#28
#os.listdir(path)
#
#返回path指定的文件夹包含的文件或文件夹的名字的列表。
#29
#os.lseek(fd, pos, how)
#
#设置文件描述符 fd当前位置为pos, how方式修改: SEEK_SET 或者 0 设置从文件开始的计算的pos; SEEK_CUR或者 1 则从当前位置计算; os.SEEK_END或者2则从文件尾部开始. 在unix，Windows中有效
#30
#os.lstat(path)
#
#像stat(),但是没有软链接
#31
#os.major(device)
#
#从原始的设备号中提取设备major号码 (使用stat中的st_dev或者st_rdev field)。
#32
#os.makedev(major, minor)
#
#以major和minor设备号组成一个原始设备号
#33
#os.makedirs(path[, mode])
#
#递归文件夹创建函数。像mkdir(), 但创建的所有intermediate-level文件夹需要包含子文件夹。
#34
#os.minor(device)
#
#从原始的设备号中提取设备minor号码 (使用stat中的st_dev或者st_rdev field )。
#35
#os.mkdir(path[, mode])
#
#以数字mode的mode创建一个名为path的文件夹.默认的 mode 是 0777 (八进制)。
#36
#os.mkfifo(path[, mode])
#
#创建命名管道，mode 为数字，默认为 0666 (八进制)
#37
#os.mknod(filename[, mode=0600, device])
#创建一个名为filename文件系统节点（文件，设备特别文件或者命名pipe）。
#38
#os.open(file, flags[, mode])
#
#打开一个文件，并且设置需要的打开选项，mode参数是可选的
#39
#os.openpty()
#
#打开一个新的伪终端对。返回 pty 和 tty的文件描述符。
#40
#os.pathconf(path, name)
#
#返回相关文件的系统配置信息。
#41
#os.pipe()
#
#创建一个管道. 返回一对文件描述符(r, w) 分别为读和写
#42
#os.popen(command[, mode[, bufsize]])
#
#从一个 command 打开一个管道
#43
#os.read(fd, n)
#
#从文件描述符 fd 中读取最多 n 个字节，返回包含读取字节的字符串，文件描述符 fd对应文件已达到结尾, 返回一个空字符串。
#44
#os.readlink(path)
#
#返回软链接所指向的文件
#45
#os.remove(path)
#
#删除路径为path的文件。如果path 是一个文件夹，将抛出OSError; 查看下面的rmdir()删除一个 directory。
#46
#os.removedirs(path)
#
#递归删除目录。
#47
#os.rename(src, dst)
#
#重命名文件或目录，从 src 到 dst
#48
#os.renames(old, new)
#
#递归地对目录进行更名，也可以对文件进行更名。
#49
#os.rmdir(path)
#
#删除path指定的空目录，如果目录非空，则抛出一个OSError异常。
#50
#os.stat(path)
#
#获取path指定的路径的信息，功能等同于C API中的stat()系统调用。
#51
#os.stat_float_times([newvalue])
#决定stat_result是否以float对象显示时间戳
#52
#os.statvfs(path)
#
#获取指定路径的文件系统统计信息
#53
#os.symlink(src, dst)
#
#创建一个软链接
#54
#os.tcgetpgrp(fd)
#
#返回与终端fd（一个由os.open()返回的打开的文件描述符）关联的进程组
#55
#os.tcsetpgrp(fd, pg)
#
#设置与终端fd（一个由os.open()返回的打开的文件描述符）关联的进程组为pg。
#56
#os.tempnam([dir[, prefix]])
#
#返回唯一的路径名用于创建临时文件。
#57
#os.tmpfile()
#
#返回一个打开的模式为(w+b)的文件对象 .这文件对象没有文件夹入口，没有文件描述符，将会自动删除。
#58
#os.tmpnam()
#
#为创建一个临时文件返回一个唯一的路径
#59
#os.ttyname(fd)
#
#返回一个字符串，它表示与文件描述符fd 关联的终端设备。如果fd 没有与终端设备关联，则引发一个异常。
#60
#os.unlink(path)
#
#删除文件路径
#61
#os.utime(path, times)
#
#返回指定的path文件的访问和修改的时间。
#62
#os.walk(top[, topdown=True[, onerror=None[, followlinks=False]]])
#
#输出在文件夹中的文件名通过在树中游走，向上或者向下。
#63
#os.write(fd, str)
#
#写入字符串到文件描述符 fd中. 返回实际写入的字符串长度
#参考地址：
#http://kuanghy.github.io/python-os/
#http://python.usyiyi.cn/python_278/library/os.html





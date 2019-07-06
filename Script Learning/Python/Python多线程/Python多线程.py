#!/usr/bin/python
#coding=utf-8

#Python 多线程
#多线程类似于同时执行多个不同程序，多线程运行有如下优点：
#使用线程可以把占据长时间的程序中的任务放到后台去处理。
#用户界面可以更加吸引人，这样比如用户点击了一个按钮去触发某些事件的处理，可以弹出一个进度条来显示处理的进度
#程序的运行速度可能加快
#在一些等待的任务实现上如用户输入、文件读写和网络收发数据等，线程就比较有用了。在这种情况下我们可以释放一些珍贵的资源如内存占用等等。
#线程在执行过程中与进程还是有区别的。每个独立的线程有一个程序运行的入口、顺序执行序列和程序的出口。但是线程不能够独立执行，必须依存在应用程序中，由应用程序提供多个线程执行控制。
#每个线程都有他自己的一组CPU寄存器，称为线程的上下文，该上下文反映了线程上次运行该线程的CPU寄存器的状态。
#指令指针和堆栈指针寄存器是线程上下文中两个最重要的寄存器，线程总是在进程得到上下文中运行的，这些地址都用于标志拥有线程的进程地址空间中的内存。
#线程可以被抢占（中断）。
#在其他线程正在运行时，线程可以暂时搁置（也称为睡眠） -- 这就是线程的退让。

#开始学习Python线程
#Python中使用线程有两种方式：函数或者用类来包装线程对象。
#函数式：调用thread模块中的start_new_thread()函数来产生新线程。语法如下:
#thread.start_new_thread ( function, args[, kwargs] )
#参数说明:
#function - 线程函数。
#args - 传递给线程函数的参数,他必须是个tuple类型。
#kwargs - 可选参数。

import thread
import time

# 为线程定义一个函数
def print_time(threadName, delay):
    count = 0
    while count < 5:
        time.sleep(delay)
        count += 1
        print "%s: %s" % (threadName, time.ctime(time.time()))

#创建两个线程

try:
    thread.start_new_thread(print_time, ("Thread-1", 2))
    thread.start_new_thread(print_time, ("Thread-2", 4))
except:
    print "Error: unable to start thread"

while 1:
    pass



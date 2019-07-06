#!/usr/bin/python
#coding=utf-8

#线程的结束一般依靠线程函数的自然结束；也可以在线程函数中调用thread.exit()，
#他抛出SystemExit exception，达到退出线程的目的。

#线程模块
#Python通过两个标准库thread和threading提供对线程的支持。thread提供了低级别的、原始的线程以及一个简单的锁。
#thread 模块提供的其他方法：
#threading.currentThread(): 返回当前的线程变量。
#threading.enumerate(): 返回一个包含正在运行的线程的list。正在运行指线程启动后、结束前，不包括启动前和终止后的线程。
#threading.activeCount(): 返回正在运行的线程数量，与len(threading.enumerate())有相同的结果。
#除了使用方法外，线程模块同样提供了Thread类来处理线程，Thread类提供了以下方法:
#run(): 用以表示线程活动的方法。
#start():启动线程活动。
#join([time]): 等待至线程中止。这阻塞调用线程直至线程的join() 方法被调用中止-正常退出或者抛出未处理的异常-或者是可选的超时发生。
#isAlive(): 返回线程是否活动的。
#getName(): 返回线程名。
#setName(): 设置线程名。

import threading
import time

#使用Threading模块创建线程
#使用Threading模块创建线程，直接从threading.Thread继承，然后重写__init__方法和run方法：

exitFlag = 0

def print_time(threadName, delay, counter):
    while counter:
        if exitFlag:
            thread.exit()
        time.sleep(delay)
        print "%s : %s" % (threadName, time.ctime(time.time()))
        counter -= 1

class myThread(threading.Thread): #继承父类threading.Thread

    def __init__(self, threadID, name, counter):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = counter

    def run(self):
        print "Starting " + self.name
        print_time(self.name, self.counter, 5)
        print "Exiting " + self.name

#创建新线程
t1 = myThread(1, "Thread-1", 1)
t2 = myThread(2, "Thread-2", 2)

#启动线程
t1.start()
t2.start()

#线程同步
#如果多个线程共同对某个数据修改，则可能出现不可预料的结果，为了保证数据的正确性，需要对多个线程进行同步。
#使用Thread对象的Lock和Rlock可以实现简单的线程同步，这两个对象都有acquire方法和release方法，对于那些需要每次只允许一个线程操作的数据，可以将其操作放到acquire和release方法之间。如下：
#多线程的优势在于可以同时运行多个任务（至少感觉起来是这样）。但是当线程需要共享数据时，可能存在数据不同步的问题。
#考虑这样一种情况：一个列表里所有元素都是0，线程"set"从后向前把所有元素改成1，而线程"print"负责从前往后读取列表并打印。
#那么，可能线程"set"开始改的时候，线程"print"便来打印列表了，输出就成了一半0一半1，这就是数据的不同步。为了避免这种情况，引入了锁的概念。
#锁有两种状态——锁定和未锁定。每当一个线程比如"set"要访问共享数据时，必须先获得锁定；如果已经有别的线程比如"print"获得锁定了，那么就让线程"set"暂停，也就是同步阻塞；等到线程"print"访问完毕，释放锁以后，再让线程"set"继续。
#经过这样的处理，打印列表时要么全部输出0，要么全部输出1，不会再出现一半0一半1的尴尬场面。
#实例：

threadLock = threading.Lock()
threads = []

class myThread2(threading.Thread): #继承父类threading.Thread
    
    def __init__(self, threadID, name, counter):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = counter
    
    def run(self):
        print "Starting " + self.name
        # 获得锁，成功获得锁定后返回True
        # 可选的timeout参数不填时将一直阻塞直到获得锁定
        # 否则超时后将返回False
        threadLock.acquire()
        print_time(self.name, self.counter, 5)
        # 释放锁
        threadLock.release()
        print "Exiting " + self.name

#创建新线程
t3 = myThread(1, "Thread-3", 1)
t4 = myThread(2, "Thread-4", 2)

#启动线程
t3.start()
t4.start()

# 添加线程到线程列表
threads.append(t3)
threads.append(t4)

# 等待所有线程完成
for t in threads:
    t.join()





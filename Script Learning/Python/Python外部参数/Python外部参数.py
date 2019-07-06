#!/usr/bin/python
# _*_ coding: UTF-8 _*_

import sys

def print_externParams():
    count = 0
    for arg in sys.argv:
        print "Param-%d: " % count, arg
        count += 1

def print_externParams2():
    length = len(sys.argv)
    #print length
    if length > 1:
        for idx in range(1, len(sys.argv)):
            print "Param-%d: " % idx, sys.argv[idx]
    else:
        print "Not found extern parameters！"

if __name__ == "__main__":
    #print_externParams()
    print_externParams2()

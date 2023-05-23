#!/usr/bin/python
# -*- encoding: utf-8 -*-

#-------------------------------------------------------------------------------
# Purpose: excel转换成txt
# Author:  chenxing
# Created: 2017-12-19
# update:  2017-12-20
#-------------------------------------------------------------------------------

import time
import os
import sys
import xlrd #需要的模块

splitsymbol = '\t'

def set_default_encoding():
    reload(sys)
    sys.setdefaultencoding('utf-8')

def open_excel(file):
    try:
        data = xlrd.open_workbook(file)
        return data
    except Exception, e:
        print str(e)

def row_strs(row):
    rowtext = "";
    for i in range(len(row)):
        if i == len(row) - 1:
            rowtext = rowtext + str(row[i])
        else:
            rowtext = rowtext + str(row[i]) + splitsymbol
    return rowtext

def xlsx2txt(srcpath, dstpath, sheetIndex=0):
    print 'converting txt ... '

    startTime = time.time()

    data = open_excel(srcpath)

    file = open(dstpath, "w") # 文件读写方式是写

    table = data.sheets()[sheetIndex] # 表头
    nrows = table.nrows  # 行数
    
    for row in range(nrows):
        values = table.row_values(row)
        rstrs = row_strs(values) # 调用函数，将行数据拼接成字符串
        text = rstrs.replace("\n", "\\n")
        file.writelines(text + '\n') # 将字符串写入新文件

    file.close() #关闭写入的文件

    endTime = time.time()

    print "spend time %d ms" %(1000*(endTime - startTime))

def gettxtfilename(srcpath):
    name = os.path.splitext(os.path.basename(srcpath))[0] + '.txt'
    return name

def getdstpath(filename, srcpath=None):
    path = sys.argv[2]
    
    if not os.path.exists(path):
        path = os.path.dirname(srcpath)
    
    dstpath = os.path.join(path, filename)

    return dstpath

def getsrcpath():
    if len(sys.argv) < 3:
        print "Error: requires the path of the source file and output directory."
        sys.exit(1)

    path = os.path.join(os.getcwd(), sys.argv[1])

    if not os.path.exists(path):
        print "ERROR: %s can not find" %path
        sys.exit(1)

    return path

def main():
    set_default_encoding()
    
    srcpath = getsrcpath()
    filename = gettxtfilename(srcpath)
    txtpath = getdstpath(filename, srcpath)

    xlsx2txt(srcpath, txtpath)

if __name__ == "__main__":
    main()

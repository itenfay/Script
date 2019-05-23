#!/usr/bin/python
# -*- encoding: utf-8 -*-

#-------------------------------------------------------------------------------
# Purpose: Txt转换成Excel
# Author:  dyf
# Created: 2017-12-18
# update:  2017-12-20
#-------------------------------------------------------------------------------

import time
import os
import sys
import xlsxwriter

default_encoding = 'utf-8'

def set_default_encoding():
    if sys.getdefaultencoding() != default_encoding:
        reload(sys)
        sys.setdefaultencoding(default_encoding)

def txt2xlsx(srcpath, dstpath, sheetnum=1):
    print 'converting xlsx ... '

    startTime = time.time()
    
    #打开txt文本进行读取
    f = open(srcpath, 'r')

    xlsxPath = dstpath
    row = 0
    col = 0
    splitsymbol = '\t'

    workbook = xlsxwriter.Workbook(xlsxPath)
    worksheet = workbook.add_worksheet(name = 'sheet' + str(sheetnum))
   
    #border:单元格边框宽度, align:对齐方式, bg_color: 背景颜色, font_size: 字体大小, bold: 字体加粗
    #format = workbook.add_format({'border':1, 'align':'center', 'valign':'vcenter', 'font_size':12, 'bold':True})
    format = workbook.add_format({'align':'center', 'valign':'vcenter', 'font_size':12})

    while True:
        line = f.readline() #一行一行读取
        if not line:
            break
        worksheet.set_row(row, 20) #设定某行单元格属性，高度为22像素，行索引从0开始
        for item in line.split(splitsymbol): #读取出相应的内容写到item
            mstr = item.strip().decode(default_encoding)
            value = mstr.replace("\\n", "\n")
            worksheet.write(row, col, value, format)
            col += 1 #另起一列
        worksheet.set_column(row, col, 20) #设定每列单元格属性，宽度为40像素，行索引从0开始
        row += 1 #另起一行
        col = 0  #初始成第一列

    f.close()
    
    workbook.close()

    endTime = time.time()

    print "spend time %d ms" %(1000*(endTime - startTime))

def getxlsxfilename(srcpath):
    filename = os.path.splitext(os.path.basename(srcpath))[0] + '.xlsx'
    return filename

def getdstpath(filename, srcpath=None):
    path = sys.argv[2]
    
    if not os.path.exists(path):
        path = os.path.dirname(srcpath)

    dstpath = os.path.join(path, filename)

    if os.path.exists(dstpath):
        os.remove(dstpath)

    return dstpath

def main():
    if len(sys.argv) < 3:
        print "Error: requires the path of the source file and output directory."
        sys.exit(1)
    
    txtpath = os.path.join(os.getcwd(), sys.argv[1])

    if not os.path.exists(txtpath):
        print "ERROR: %s can not find" %txtpath
        sys.exit(1)
    
    filename = getxlsxfilename(txtpath)
    dstpath = getdstpath(filename, txtpath)

    txt2xlsx(txtpath, dstpath)

if __name__ == '__main__':
    main()

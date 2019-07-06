#!/usr/bin/python
#coding=utf-8

import sqlite3

con = sqlite3.connect('test.db')

con.execute("""CREATE TABLE IF NOT EXISTS tbl (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        grp INTEGER);""")

c = con.cursor()

c.execute("""INSERT INTO tbl (grp) VALUES (0);""")
c.execute("""INSERT INTO tbl (grp) VALUES (1);""")

newId = c.lastrowid

print "New rowid =", newId

c.close()
con.close()

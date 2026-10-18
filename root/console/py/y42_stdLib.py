#   ***************************************************************************
#   My Python Tutorial  ::  standardLibrary
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   mod:    os,sys,glob,re,math,random,datetime,zlib,timeit
#   fct:    dir

#   === :header
import os
import sys
import glob
import re
import math
import random
from datetime import date
import timeit
from timeit import Timer
import zlib

import LIB_inc as m;    g = m.CLib();   sTc = 'TcStdLib'
g.f_header(sTc)

#   === :content
'''
    content:
        m:  module.os
        m:  module.sys
            s:  Stdin, Stdout, StdErr
        m:  module.glob
        m:  module.regExpr
        m:  module.math
        m:  module.random
        m:  module.dateTime
        m:  module.timeit
        m:  module.zlib
'''

# https://py-tutorial-de.readthedocs.org/de/python-3.3/stdlib.html

#
#   m:  module.os
#

g.f_menu("module: os")

L = dir(os)
g.f_text("L(os)  => %s" % (L))

#
#   m:  module.sys
#

g.f_menu("module: sys")
g.f_text("args:<%s>" % g.f_sArgs())     # show it

#
#   s:  Stdin, Stdout, StdErr
#

g.f_menuS1("module: sys - stdin,stdout,stderr")

#   Das Modul sys hat darueber hinaus auch Attribute
#       fuer stdin, stdout und stderr.
#   Letzteres ist vor allem bei der Ausgabe von Warnungen und Fehlermeldungen
#   nuetzlich, etwa wenn stdout umgeleitet worden ist:

#   stdout
sys.stdout.write('Hello of stdout\n')

#   stderr version:default
s = "[" + g.f_sVersion() + "]\n"
sys.stderr.write(s)

#   stderr version:thisFile
s = "[" + g.f_sVersion(__file__) + "]\n"
sys.stderr.write(s)

#
#   m:  module.glob
#

g.f_menu("module: glob")

s = '*.py'
L = glob.glob(s)
g.f_text("L(%s)  => %s" % (s,L))


#
#   m:  module.regExpr
#

g.f_menu("module: reg")

L = re.findall(r'\bk[a-z]*', 'drei kleine katzen')
g.f_text("L.re  => %s" % (L))

#   doch so ist es einfacher
s     = 'Tee fuer zwei'
sTmp  = s.replace('zwei', 'drei')
g.f_text("s.replace(%s)  => %s" % (s,sTmp))

#
#   m:  module.math
#

g.f_menu("module: math")


y = math.cos(math.pi / 4.0)
g.f_text("cos(pi/4) => %f" % (y))

#
#   m:  module.random
#

g.f_menu("module: random")

#   choice
L = ['Apfel', 'Birne', 'Banane']
g.f_text("use L => %s" % (L))
g.f_text("choice(L) => %s" % (random.choice(L)))
g.f_text("choice(L) => %s" % (random.choice(L)))

#   random floating value
g.f_text("random() => %s" % (random.random()))

#   random integer inside range
n = 10
g.f_text("random(%d) => %d" % (n,random.randrange(n)))

#   sample
iMin,iMax,iNum = 1,50,5
tSample = random.sample(range(iMin,iMax), iNum)     # from 1..50 only 5
g.f_text("sample min|max:(%d...%d) num:(%d) => %s" %
    (iMin,iMax,iNum,tSample))

#
#   m:  module.datetime
#

g.f_menu("module: date & time")

g.f_text("today() => %s" % (date.today()))

dtNow   = date.today()
dtBirth = date(1964, 7, 9)
dt      = dtNow - dtBirth
g.f_text("age=dtNow-dtBirth => %s" % (dt.days))


#
#   m:  module.timeit
#

g.f_menu("module: timeit")

#   hasAttr
s = "if hasattr(str, '__bool__'): pass"
y = timeit.timeit(stmt=s, number=100000)
g.f_text("time(stmt=hasattr) : %s" % (y))

#   div Zero
s = """\
try:
    str.__nonzero__
except AttributeError:
    pass
"""
y = timeit.timeit(stmt=s, number=100000)
g.f_text("time(stmt=divZero) : %s" % (y))


# --- A) cmp 2 statements
stmt1   = "'t=a; a=b; b=t', 'a=1; b=2'"     # Zuweisung ueber tmp Variable
stmt2   = "'a,b = b,a', 'a=1; b=2'"         # python-like Zuweisung
sRc1    = Timer(stmt1).timeit()
sRc2    = Timer(stmt2).timeit()
g.f_text("time(stmt1) : %s" % (sRc1))
g.f_text("time(stmt2) : %s" % (sRc2))


#
#   m:  module.zlib
#

g.f_menu("module: zlib")

tByte   = b"ABC 123  ABC 567 123 123 123 ABC"   # byte-like string with repeat
s = str(tByte)
g.f_text("len(s=%s) => %s" % (s,len(s)))

xCpr = zlib.compress(tByte)
s = str(xCpr)
g.f_text("x = len(compressed(s)) => x=%s,len=%s" % (s,len(s)))

yByte = zlib.decompress(xCpr)
g.f_text("y = decompressed(x) => %s" % (yByte))
assert (type(yByte) is type(tByte))
assert (yByte == tByte)

z = zlib.crc32(tByte)
g.f_text("z = crc32(s) => %s" % (z))


#   === :footer
g.f_footer(sTc)

#   ###########################################################################
#   My Python Tutorial  :: import
#   ###########################################################################
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   https://docs.python.org/3/reference/import.html
#   https://docs.python.org/3/tutorial/modules.html

#   --- content
#       b:  function
#       b:  body
#           m:  import <sys>
#               s:  content.sys
#               s:  sys.argv
#               s:  sys.searchPath
#           m:  import <os>
#           m:  import <time>
#               s:  time*
#           m:  import <dateTime>
#           m:  import <calendar>
#           m:  import <math>
#               s:  module content
#               s:  show pi and e
#               s:  using math
#               s:  rename nameSpace
#                   u:  show my.pi and my.e
#                   u:  calc sin(my.pi/2)
#           m:  import <MyLib>
#               s:  show.MyLibBase
#               s:  show.MyLibSubclass
#               s:  show.FunctionLocals
#               s:  show.MyHelp

#   ===========================================================================
#   b:  function
#   ===========================================================================

#   === lolcal output function
def F_showTuple(p_sName,p_tTuple):
    """MyDocStr:=ThisIsMyShow function"""       # set: docString
    i = 0
    for x in p_tTuple:
        i += 1
        if i == 1:
            s = "<<< "
            s += p_sName
            s += " =: "
            s += x
        else:
            s = ";" + x
        g.f_print(s)
    print("")
    return i   # exit(1)


def F_showLocals():
    a = 5
    b = 10
    c = 15
    g.f_text(locals())

#   ===========================================================================
#   b:  body
#   ===========================================================================

#   === :header
#   import random
import LIB_inc as m;    g = m.CLib();   sTc = 'tcSytem'
g.f_header(sTc)

#   fetch posix # Verbose
bVerbose = True
bOsPosix = g.f_bOsPosix()
g.f_text("IsPosix =: <%r>" % bOsPosix)

#
#   m:  import <sys>
#

import sys


g.f_menu("import.sys")

sMod = 'sys'
tVal = sys.builtin_module_names

#   s:  content.sys
g.f_menuS1("content:sys")
g.f_text("len of Module<'%s'> = %d"  % (sMod,len(tVal)))
g.f_text("type(tVal) =: <%s>" % (type(tVal)))
sTxt = ("module:<%s>" % sMod)
F_showTuple(sTxt,tVal)

#   s:  sys.argv
g.f_menuS1("sys:argv")
s = ("sysArgv[0] => '%s'" % (sys.argv[0]))
g.f_text(s)

#   s:  sys.searchPath
g.f_menuS1("sys:path")
tVal = sys.path
g.f_text("Len(sysPath)=%d" % (len(tVal)))
F_showTuple("SysPath",tVal)
g.f_text("Args:%s" % g.f_sArgs())


#
#   m:  import <os>
#

import os


g.f_menu("import.os")
sRc = os.path.abspath(__file__)
s   = ("os.path.absPath => '%s'" % (sRc))
g.f_text(s)

#
#   m:  import <time>
#

import time

g.f_menu("import.time")

sTime   = time.time()
sOut    = "time.time := <%s>" % sTime
g.f_text(sOut)

tRc     = time.localtime(sTime)     # !CRQ-240407:isNoStr
sOut    = "localTime :=  <" + str(tRc) + ">"
g.f_text(sOut)

sRc     = time.asctime(tRc)
sOut    = "ascTime := <%s>" % sRc
g.f_text(sOut)


#   s:  time*

g.f_menuS1("import.time*")

from time import *

sLt     = localtime()
sFm     = "%Y-%m-%d,%H:%M:%S"
sTm     = strftime(sFm,sLt)
s       = "strfTime(%s,%s) => '%s'" % (sLt,sFm,sTm)
g.f_text(s)

#
#   m:  import <dateTime>
#

g.f_menu("import.dateTime")

from datetime import date
from datetime import datetime
#   from datetime import time

xDt     = date.today()
sFm     = "%d/%m/%y"
sRc     = xDt.strftime(sFm)
s       = "xDate.strfTime(%s) => '%s'" % (sFm,sRc)
g.f_text(s)

xDt     = datetime.now()
sFm     = "%d/%m/%y;%H:%M:%S"
sRc     = xDt.strftime(sFm)
s       = "xNow.strfTime(%s) => '%s'" % (sFm,sRc)
g.f_text(s)


#
#   m:  import <calendar>
#

g.f_menu("import.calendar")

import calendar

iYe     = 1964
iMo     = 7
s       = "Calendar(%d,%d) => ..." % (iYe,iMo)
g.f_text(s)

#   using object calendar
sRc     = calendar.month(iYe, iMo)
print(sRc)

#
#   m:  import <math>
#

g.f_menu("import.math")

import math
from math import pi
from math import sin


sMod = 'math'

#   s:  module content
g.f_menuS1("show module content")
tVal = dir(math)    # get directory of 'math' - not list directoy
g.f_text("len of Module<'%s'> = %d"  % (sMod,len(tVal)))
sTxt = ("module:<%s>" % sMod); F_showTuple(sTxt,tVal)

#   s:  show pi and e
f = math.pi;    s = "pi => %f" % (f);   g.f_text(s)
f = math.e;     s = "e  => %g" % (f);   g.f_text(s)

#   s:  using math.sin

#   save pi
x = math.pi
g.f_text("pi := %g" % x)

#   y = sin(pi)
y   = math.sin(x)   # sin(pi) == 0
g.f_text("math.sin(%g) => %f" % (x,y))

#   y = sin(pi/2)
x   = pi / 2
y   = sin(x)        # same function, but known inside math
g.f_text("mah.sin(%g) => %f" % (x,y))

#   s:  rename nameSpace

g.f_menuS1("rename name space")
import math as p

#   use renamed name space My p

#   u:  show my.pi and my.e
g.f_menuS2("show my pi&e")
f = p.pi;    s = "My.pi => %f" % (f);   g.f_text(s)
f = p.e;     s = "My.e  => %g" % (f);   g.f_text(s)

#   u:  calc sin(my.pi/2)
x = p.pi / 2
y = p.sin(x)    # sin() inside m
g.f_text("My.sin(%g) => %f" % (x,y))

#
#   m:  import <MyLib>
#

g.f_menu("import.MyLib")

#   using direct import
g.f_text("using F_who")
m.F_who()

#   s:  show.MyLibBase
g.f_menuS1("show MyLib.bases")
g.f_text(m.CStack.__bases__)

#   s:  show.MyLibSubclass
g.f_menuS1("show MyLib.subclass")
g.f_text(m.CStack.__subclasses__)

#   s:  show.FunctionLocals
g.f_menuS1("show locals")
F_showLocals()

#   s:  show.MyHelp
g.f_menuS1("show.MyHelp")
if bOsPosix:
    g.f_text("t.b.d help() not stops inside bash")
else:
    if sys.version_info >= (3,10):
        help(F_showTuple)   # get the docString

#   === :footer
g.f_footer(sTc)

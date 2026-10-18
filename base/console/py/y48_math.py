#   ***************************************************************************
#   My Python Tutorial  :: float || math
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   url:
#   https://www.w3schools.com/python/ref_func_float.asp
#   https://www.w3schools.com/python/ref_math_sin.asp

#   --- content:
#       m:  random
#       m:  ceil|floor|trunc
#       m:  round
#       m:  max || min
#       m:  abs
#       m:  power || **
#       m:  exp == e**n
#       m:  sqrt
#       m:  sin | cos | tan
#           s:  sin
#           s:  cos
#           s:  tan
#       m:  Angular Conversion :: deg <=> rad

#   === :header
from decimal import Decimal
import math
import time
import LIB_inc as m;    g = m.CLib();   sTc = 'tcMath'
g.f_header(sTc)

#
#   m:  random
#

g.f_menu("random")

x = g.f_iRandom()
g.f_text("iRnd.def => %d" % x)

i = 60
x = g.f_iRandom(i)
g.f_text("iRnd(%d) => %d" % (i,x))          # rnd(max)
assert (x <= i)

i,j = 100,80
x = g.f_iRandom(i,j)
g.f_text("iRnd(%d,%d) => %d" % (i,j,x))     # rnd(max,min)
assert (x <= i)
assert (x >= j)

i,j = 2,1
x = g.f_iRandom(i,j)
g.f_text("iRnd(%d,%d) => %d" % (i,j,x))     # 1..2
assert (x <= i)
assert (x >= j)

#
#   m:  prime
#

g.f_menu("prime")

#   run primeTest
iStart = time.perf_counter_ns()
for x in g.C_LIST_number:
    g.f_isPrime(x)
iStopp = time.perf_counter_ns()
assert (iStopp > iStart)

#   result
fTime = (iStopp - iStart) / 1000000.0
g.f_text(f"calcPrimeTime.raw : {fTime} [ms]")

#
#   m:  ceil || floar || trunc
#

g.f_menu("ceil || floor || trunc")

f = 3.12

i = math.ceil(f)
g.f_text("ceil(%f)  =: %d" % (f,i))     # 4
i = math.ceil(-f)
g.f_text("ceil(%f)  =: %d" % (-f,i))    # -3

i = math.floor(f)
g.f_text("floor(%f) =: %d" % (f,i))     # 3
i = math.floor(-f)
g.f_text("floor(%f) =: %d" % (-f,i))    # -4

i = math.trunc(f)
g.f_text("trunc(%f) =: %d" % (f,i))     # 3
i = math.trunc(-f)
g.f_text("trunc(%f) =: %d" % (-f,i))    # -4


#
#   m:  round
#

#   https://www.w3schools.com/python/ref_func_round.asp

g.f_menu("round")

f = 3.12
i = round(f)
g.f_text("round(%f)  =: %d" % (f,i))            # 3

f = 5.5
i = round(f)
g.f_text("round(%f)  =: %d" % (f,i))            # 6 !

f = 5.76543
i   = 1         # precision using 1 digits
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 5.80..

f = 5.76543
i = 2           # precision using 2 digits
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 5.770... !


#
#   s:  decimal
#

g.f_menuS1("using Decimal")

f = 2.675
i = 2

# normal float
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 2.67

#   exact frac
#   from decimal import Decimal


f = Decimal('2.575')
fRc = round(f,i)
g.f_text("round(%f,%d)* =: %f" % (f,i,fRc))     # 2.58


#
#   s:  round up
#

g.f_menuS1("roundUp")

f = 82.123456789
i = -1
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 80

f = 444.45
i = -1
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 440.0...

i = -2
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 400.0...

i = -3
fRc = round(f,i)
g.f_text("round(%f,%d)  =: %f" % (f,i,fRc))     # 0.0


#
#   m:  max || min
#

g.f_menu("max || min")

t = (5, 7, 105, 25, 3)

i = max(t); g.f_text("max(T:%s) =: %d" % (str(t),i))
i = min(t); g.f_text("min(T:%s) =: %d" % (str(t),i))


#
#   m:  abs
#

g.f_menu("abs")

f = 3.14
x = abs(f); g.f_text("abs(%f) =: %d" % (f,x))

f = -654.1
x = abs(f); g.f_text("abs(%f) =: %d" % (f,x))


#
#   m:  power || **
#

g.f_menu("power|**")

a = 4.1; b = 3.5
x = pow(a,b);       g.f_text("pow(%f;%f) =: %f" % (a,b,x))
x = a ** b;         g.f_text("%f ** %f =: %f" % (a,b,x))

a = -3; b = 3
x = pow(a,b);       g.f_text("pow(%f;%f) =: %f" % (a,b,x))

x = a ** b;         g.f_text("%f ** %f =: %f" % (a,b,x))

#
#   m:  exp == e**n
#

g.f_menu("exp")

f = 5.1
x = math.exp(f);    g.f_text("exp(%f) =: %f" % (f,x))

#
#   m:  log | log10
#

g.f_menu("log|log10")

#   m:  log  == log(x,e)

f = 10
x = math.log(f);    g.f_text("log(%f)   =: %f" % (f,x))
f = 100
x = math.log10(f);  g.f_text("log10(%f) =: %f" % (f,x))

#
#   m:  sqrt
#

g.f_menu("sqrt")
f = 100
x = math.sqrt(f);   g.f_text("sqrt(%f)  =: %f" % (f,x))
f = 77.7
x = math.sqrt(f);   g.f_text("sqrt(%f)  =: %f" % (f,x))

#
#   m:  constants pi|e
#

g.f_menu("constants")
x = math.pi;        g.f_text("pi  =: %f" % (x))
x = math.e;         g.f_text("e   =: %f" % (x))
x = math.nan;       g.f_text("nan =: %f" % (x))

#
#   m:  sin | cos | tan
#

g.f_menu("sin|cos|tan")

#   s:  sin
f = math.pi
x = math.sin(f);    g.f_text("sin(pi) =: %f" % (x))
f = math.pi / 2
x = math.sin(f);    g.f_text("sin(pi/2)=:%f) =: %f" % (f,x))
f = math.pi / 4
x = math.sin(f);    g.f_text("sin(pi/4)=:%f) =: %f" % (f,x))
a = 30.0
f = math.radians(a)
x = math.sin(f);    g.f_text("sin degree(%d)=: %f" % (a,x))

#   s:  cos
f = math.pi
x = math.cos(f);    g.f_text("cos(pi) =: %f" % (x))
f = math.pi / 2
x = math.cos(f);    g.f_text("cos(pi/2)=:%f) =: %f" % (f,x))
f = math.pi / 4
x = math.cos(f);    g.f_text("cos(pi/4)=:%f) =: %f" % (f,x))

#   s:  tan
f = math.pi
x = math.tan(f);    g.f_text("tan(pi) =: %f" % (x))
f = math.pi / 2
x = math.tan(f);    g.f_text("tan(pi/2)=:%f) =: %f" % (f,x))
f = math.pi / 4
x = math.tan(f);    g.f_text("tan(pi/4)=:%f) =: %f" % (f,x))

#
#   m:  Angular Conversion :: deg <=> rad
#

g.f_menu("deg <=>rad")
f = math.pi
x = math.degrees(f);    g.f_text("DEG(%f) =: %f" % (f,x))

f = 30.0
x = math.radians(f);    g.f_text("RAD(%f) =: %f" % (f,x))

#   === :footer
g.f_footer(sTc)

#   ###########################################################################
#   My Python Tutorial  :: generator && iterator    doc:[!29]
#   ###########################################################################
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   https://www.geeksforgeeks.org/generators-in-python/
#   https://wiki.python.org/moin/Generators
#   https://www.w3schools.com/python/ref_func_next.asp

#   --- Generator
#       defines a function
#   A generator function in Python is defined like a normal function,
#       but whenever it needs to generate a value,
#   it does so with the yield keyword rather than return.
#   If the body of a def contains yield, the function
#   automatically becomes a Python generator function.

#   --- Iterator
#       defines a class

#   MOD:   random
#   KEY:   yield
#   FCT:   iter, reversed, next

'''
    !content:
        m:  generator
            s:  loop
            s:  gen.city
            s:  gen.city.forever
            s:  gen.club && for next(pGen)
            s:  gen.permuation
            s:  gen.abc
            s:  gen.Square
        m:  iterator
            s:  itr.Fruit
            s:  itr.City:iter&&reversed
            s:  itr.Class.Power
            s:  itr.Name.forever
'''

#   === :header
from __future__ import annotations
import sys
assert sys.version_info >= (3,9)
import LIB_inc as m;    g = m.CLib();   sTc = 'tcGeneratorIterator'
g.f_header(sTc)

#
#   m:  generator.beginner
#

g.f_menu("generator for beginners",p_bNL=True)  # any comment

#
#   s:  loop
#

#   The normale python loop is already a generator

g.f_menuS1("loop - a usual python loop")

eCity = {'Hamburg','Muenchen','Berlin','Frankfurt'}
g.f_text("using eCity := %s" % str(eCity))

i = 0
for x in eCity:
    g.f_text("for.eCity[%d] => '%s'" % (i,x))
    i += 1


#
#   s:  gen.city
#

g.f_menuS1("generator.function:city")


#   define a function
def F_generator_city():
    eCity = {'Hamburg','Muenchen','Berlin','Frankfurt'}
    for x in eCity:
        yield x
    # returns eCity[i:=0] and stores a ptr &eCity[i+1]

#   using the function like a set to eCity
i = 0
for x in F_generator_city():
    g.f_text("gen.eCity[%d] => '%s' " % (i,x))
    i += 1


#
#   s:  gen.city.forever
#

g.f_menuS1("generator.function:forever.city")

g.f_trace("define function")
def F_generator_city_stack():
    eCity = {'Hamburg','Muenchen','Berlin','Frankfurt'}
    while True:             # forever
        x = eCity.pop()
        yield x             # save and add x
        eCity.add(x)


g.f_trace("run")
i = 0
nMaxRun = 8
for x in F_generator_city_stack():
    g.f_text("genStack.eCity[%d] => '%s' " % (i,x))
    i += 1
    if (i >= nMaxRun):
        break

#
#   s:  gen.club && for next(pGen)
#

g.f_menuS1("generator using iterator")

#   define generator
g.f_trace("define function club")
def F_generator_club():
    eClub = {'Bayern','BvB','Gladbach','S04','HSV'}
    for x in eClub:
        yield x

#   get generator Ptr pGen
g.f_trace("get function-return-code")
pFct = F_generator_club()

#   loop
g.f_trace("loop")
bRc = False
try:
    for i in range(10):
        sFwd = next(pFct)
        g.f_text("gen.itr.eClub [%d] => '%s'" % (i,sFwd))
except Exception:
    g.f_text("&&& break")
    bRc = True

#
#   s:  gen.permuation
#

g.f_menuS1("permutation")

g.f_trace("define")
def F_generator_permutation(p_lVal):
    n = len(p_lVal)
    if n == 0: yield []      # empty genPtr
    else:
        for i in range(n):
            for x in F_generator_permutation(p_lVal[:i] + p_lVal[i + 1:]):
                yield [p_lVal[i]] + x


g.f_trace("for FGen")
i = 1
for x in F_generator_permutation(['a','d','e']):
    s = ''.join(x)      # list=>string
    s = F"[{i}] : {s}"
    g.f_text(s)
    i += 1


g.f_trace("ready")


#
#   generator.advanced
#

#
#   s:  gen.abc
#

g.f_menuS1("abc - send && next")

g.f_trace("define")
def F_generator_abc(p_sVal):
    iCtr = 0
    while True:
        i  = (yield p_sVal[iCtr % len(p_sVal)])
#       print("i = %s" % (i))
        if i:
            iCtr = i
#           print("i=TRUE: %s" % (i))
        else:
            iCtr += 1
#           print("i=FALSE: %s,%s" % (i,iCtr))

#   init my generator
g.f_trace("init")
sTestAbc = "abcdef"
g.f_text("input = <%s>" % (sTestAbc))

#   get generator-ptr
g.f_trace("get FGenAbc Ptr")
xAbc = F_generator_abc(sTestAbc)

#   using: next()
g.f_trace("run next")

s = next(xAbc)
g.f_text("gen-ABC => '%s'" % (s))   # 'a'

s = next(xAbc)
g.f_text("gen-ABC => '%s'" % (s))   # 'b'

#   using: send()
#   index = i => next = i+1
#   a b c d e f
g.f_trace("use send")
#   => sample[3+1]=sample[4]='e''
i = 3
#   SEND to generator
xAbc.send(i)
s = next(xAbc)
g.f_text("gen-ABC(send(%d)) => '%s'" % (i,s))   # <<< 'e'


#
#   s:  gen.Square
#

g.f_menuS1("square")


#   define my expression
g.f_trace("define expr square")
n       = 5
genSqr  = (x**2 for x in range(1,n + 1))

#   parse with Next() all possible values
g.f_trace("while forever")
bEc = False
try:
    while True:
        g.f_text("gen-SQR => %d" % (next(genSqr)))
except Exception as x:
    bEc = True
    sEc = str(x)
    g.f_text("<<< Exc = '%s'" % (sEc))
assert (bEc is True)

#
#   m:  iterator
#

g.f_menu("Iterator",p_bNL=True)


#
#   s:  itr.Fruit
#

g.f_menuS1("intro iterator.Fruit")

#   define a list
L = ["apple", "banana", "cherry"]
g.f_text("L.fruit : '%s'" % L)

#   define a iterator to this list
pLi = iter(L)

#   show the List
g.f_trace("for i in ranges")
for i in range(len(L)):
    g.f_text("[%d] : '%s'" % (i, str(next(pLi))))

#   output
#   [0] : 'apple'
#   [1] : 'banana'
#   [2] : 'cherry'

#
#   s:  itr.City:iter&&reversed
#

g.f_menuS1("iterator.City")

#   define a list
L = ["Washington","Moscow","London","Berlin","Paris"]
g.f_text("L.city : '%s'" % L)

#   sort my list
L.sort()
g.f_text("L.city.sorted : '%s'" % L)

#   define normal iterator FWD and inverted iterator REV
pFwd = iter(L)
pRev = reversed(L)

#   using
g.f_trace("for i in range")
for i in range(len(L)):
    sFwd = str(next(pFwd))
    sRev = str(next(pRev))
    g.f_text("[%d] : fwd:'%s' && rev:'%s'" % (i, sFwd, sRev))


#
#   s:  itr.Class.Power
#

g.f_menuS1("iterator.Power")

class CPowerOfTwo:

    def __init__(self, p_iMax: int) -> None:
        self.__m_iMax = p_iMax

    def __iter__(self) -> CPowerOfTwo:
        self.__m_iCtr = 0
        return self
    def __next__(self) -> int:          # 0..9
        if self.__m_iCtr < self.__m_iMax:
            iVal = 2 ** self.__m_iCtr   # 2** 0 == 1
            self.__m_iCtr += 1
            return iVal
        raise StopIteration

#   --- eoc.CPowerOfTwo

pIter = CPowerOfTwo(10)

g.f_trace("for x in range")
i = 1
for xIter in pIter:
    g.f_text("p[%2.2d] : %4.4d" % (i,xIter))
    i += 1


#
#   s:  itr.Name.forever - Non-exceeding
#

g.f_menuS1("iterator.Name.forever")


class CNamesForever:

    def __init__(self, names):
        self.names = names
        self.num_names = len(self.names)
        self.current_n = 0

    def __iter__(self):
        self.current_n = 0
        return self

    def __next__(self):
        if self.current_n < self.num_names:
            current_result = self.names[self.current_n]
            self.current_n += 1
            return current_result
        self.current_n = 0
        current_result = self.names[self.current_n]
        self.current_n += 1
        return current_result

#   define name list

L = ["Peter", "Harvey", "Jan"]
g.f_text("L.names : '%s'" % L)

pIter4Ever = CNamesForever(L)
g.f_text("p:=L = %s" % str(pIter4Ever))

iMax = 7
g.f_text("for in range(%d) ..." % iMax)

for i in range(iMax):
    sName = next(pIter4Ever)
    g.f_text("name [%2.2d] = '%s'" % (i + 1,sName))


#   === :footer
g.f_footer(sTc)

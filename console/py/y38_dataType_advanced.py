#   ###########################################################################
#   My Python Tutorial  :: dataType advanced
#   ###########################################################################
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   List comprehension offers a shorter syntax
#       when you want to create a new list based on the values of
#       an existing list.

#   url:
#   https://www.w3schools.com/python/python_lists_comprehension.asp

'''
    !content:
        m:  list.comprehension
        m:  list.map
        m:  list.primeNumber
        m:  tuple.named
        m:  enum
'''


#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcDataTypeAdvanced'
g.f_header(sTc)

#   ===========================================================================
#   m:  list.comprehension
#   ===========================================================================

g.f_menu("list comprehension")

lSqr = [x**2 for x in range(1,10)]
g.f_text("squares => %s" % (lSqr))


#   =================================================================
#   m:  list.abstract
#   =================================================================

g.f_menu("list abstration with map & lambda")

#       vorheriges Kapitel mit lambda und map
g.f_menuS1("Celsius vs Fahrenheit")
tT = (0,20,33,40,60,80,100)
l_F2C = [round((5.0 / 9) * (x - 32)) for x in tT]
l_C2F = [round((9.0 / 5) * x + 32) for x in tT]
g.f_text("F2C_map(x) => %s" % (l_F2C))
g.f_text("C2F_map(x) => %s" % (l_C2F))

#   mit Listen-Abstraktion
l_F2C = [round(((5.0 / 9) * (x - 32))) for x in tT]
l_C2F = [round((9.0 / 5) * x + 32) for x in tT]
g.f_text("F2C(x) => %s" % (l_F2C))
g.f_text("C2F(x) => %s" % (l_C2F))

g.f_menuS1("Mathematics")
l_FX = [x for x in range(50,101) if (x % 4 == 0)]
g.f_text("FX(xDIV4,50<=x<=100) => %s" % (l_FX))

g.f_menuS1("List abstraction with a normal function")
# Wie kann eine Funktion anhand verschiedener Input-Werte
# geprueft werden ?
def f_sqr(x):
    y = x * x
    return y
tSrc = (1,10,20)        # input
lObj = [f_sqr(x) for x in tSrc]   # output
g.f_text("mySqr(%s) => %s" % (tSrc,lObj))


#   =================================================================
#   m:  list.primeNumber
#   =================================================================

g.f_menu("primeNumber")

from math import sqrt


#   keine Primzahlen
g.f_menuS1("no Prime")
n = 20
e_noP   = {j for i in range(2,int(sqrt(n))) for j in range(i * 2, n, i)}
g.f_text("eNoPrim(%d)  => %s" % (n,e_noP))

def f_primes(n):
    if n == 0:
        eRc = {0}
        return eRc
    elif n == 1:
        eRc = {0,1}
        return eRc
    else:
        _e     = {j for i in range(2,int(sqrt(n))) for j in range(i * 2, n, i)}
        eTmp   = {x for x in range(2,n) if x not in e_noP}
        eRc    = set()  # {0,1}
        for e in eTmp:
            if e > 2:
                eRc.add(e)
    return eRc

eVal = f_primes(n)
g.f_text("ePrim(%d)  => %s" % (n,eVal))


#   ===========================================================================
#   m:  tuple.named
#   ===========================================================================

#   url:   https://www.geeksforgeeks.org/namedtuple-in-python/

#   In Python, NamedTuple is present inside the collections module.
#   It provides a way to create simple, lightweight data
#       structures similar to a class, but without the overhead
#       of defining a full class.
#   Like dictionaries, they contain keys
#       that are hashed to a particular value.
#   On the contrary,
#       it supports both access from key-value and iteration,
#       the functionality that dictionaries lack.

g.f_menu("namedTuple")

# Python code to demonstrate namedtuple()
from collections import namedtuple


# Declaring namedtuple()
TStudent = namedtuple('TStudent', ['name', 'age', 'DOB'])

#   Adding values
S = TStudent('Peter', 20, '712834')

#   Type
tc = type(TStudent)
g.f_text("? type(TStudent) =: '%s'" % (tc))     # <class 'type'>

tx = type(S)
g.f_text("? type(S) =: '%s'" % (tx))    # <<   class '__main__.Student'>

#   Access using name
g.f_text("+ Name of Student : %s" % (S.name))

#   Access using index
i = 1
g.f_text("+ iAge of Student using index:[%d]   : %d" % (i,S[i]))


#   ===========================================================================
#   m:  enum
#   ===========================================================================
#   url:   https://docs.python.org/3/library/enum.html

g.f_menu("enum")

from enum import Enum


EColor = Enum('Color', ['RED','GREEN','BLUE'])

#   check enum
te = type(EColor)
g.f_text("? type(E) =: '%s'" % (te))        # <<< class 'enum.EnumType'

#   set a color
X = EColor.RED
tx1 = type(X)
g.f_text("? type(X) =: '%s'" % (tx1))       # <<< enum 'Color'
g.f_text("? color(X) =: '%s'" % str(X))     # <<< Color.RED

#   === :footer
g.f_footer(sTc)

#   coding:UTF-8
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ-------$

#   ***************************************************************************
#   My Python Tutorial  :: operator
#   ***************************************************************************

#   url:    https://www.w3schools.com/python/python_operators.asp

#   content:
#   +   operator
#       •   m:  arithmetic
#       •   m:  bitwise
#       •   m:  change&assign
#       •   m:  compare
#       •   m:  logical
#       •   m:  membership
#       •   m:  identity

#   === :header
import random
import LIB_inc as m; g = m.CLib(); sTc = 'TcOperator'
g.f_header(sTc,True)

#   === :init
a = random.randint(1,10)    # 1..10
b = random.randint(1,10)    # 1..10
c = random.randint(1,10)    # 1..10

#   === :helper for print char '%''
z = '%'

#   ===========================================================================
#   m:  arithmetic
#   ===========================================================================

g.f_menu("operator.arithmetic")
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)

#   standard
x = a + b; g.f_text("a + b    \t=: %d" % (x))
x = a - b; g.f_text("a - b    \t=: %d" % (x))
x = a * b; g.f_text("a * b    \t=: %d" % (x))
x = a / b; g.f_text("a / b    \t=: %d" % (x))   # like div(x,b) float=>int

#   exponential
x = a**b; g.f_text("a ** b  \t=: %d" % (x))

#   modulo
x = a % b; g.f_text("a %c b   \t=: %d" % (z,x))

#   floor
x = a // b; g.f_text("a // b  \t=: %d" % (x))


#   ===========================================================================
#   m:  bitwise
#   ===========================================================================

g.f_menu("operator.bitwise")
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)
g.f_text(("a,b,c := ('%s','%s','%s')" % (bin(a),bin(b),bin(c))),g.C_COLOR_CYAN)

x = a & b;  g.f_text("a & b  \t=: %d=%s" % (x,bin(x)))
x = a | b;  g.f_text("a | b  \t=: %d=%s" % (x,bin(x)))
x = a ^ b;  g.f_text("a ^ b  \t=: %d=%s" % (x,bin(x)))
x = a << b; g.f_text("a << b \t=: %d=%s" % (x,bin(x)))
x = a >> b; g.f_text("a >> b \t=: %d=%s" % (x,bin(x)))
x = ~x;     g.f_text("~a     \t=: %d=%s" % (x,bin(x)))

#   ===========================================================================
#   m:  change&assign
#   ===========================================================================

g.f_menu("operator.change&assign")
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)

#   arithmetic
x = a; x += b; g.f_text("a += b \t=: %d" % x)
x = a; x -= b; g.f_text("a -= b \t=: %d" % x)
x = a; x *= b; g.f_text("a *= b \t=: %d" % x)
x = a; x /= b; g.f_text("a /= b \t=: %d" % x)   # like div(x,b)

#   explonential
x = a; x **= b;  g.f_text("a **= b  \t=: %d" % x)

#   modulo/floor
x = a; x %= b;   g.f_text("a %c= b  \t=: %d" % (z,x))
x = a; x //= b;  g.f_text("a //= b  \t=: %d" % x)

#   bitweise
x = a; x &= b;  g.f_text("a &= b    \t=: %d" % x)
x = a; x |= b;  g.f_text("a |= b    \t=: %d" % x)
x = a; x ^= b;  g.f_text("a ^= b    \t=: %d" % x)
x = a; x >>= b; g.f_text("a >> b    \t=: %d" % x)
x = a; x <<= b; g.f_text("a << b    \t=: %d" % x)

#   ===========================================================================
#   m:  compare
#   ===========================================================================

g.f_menu("operator.compare")
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)

if a == b:
    x = True
else:
    x = False
s = ("? == ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

if a != b:
    x = True
else:
    x = False
s = ("? != ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

if a > b:
    x = True
else:
    x = False
s = ("? >  ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

if a < b:
    x = True
else:
    x = False
s = ("? <  ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

if a >= b:
    x = True
else:
    x = False
s = ("? >= ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

if a <= b:
    x = True
else:
    x = False
s = ("? <= ('%d','%d') =: %r" % (a,b,x)); g.f_text("%s" % s)

#   ===========================================================================
#   m:  logical
#   ===========================================================================

g.f_menu("operator.logical")
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)

#   and, or, not

x = False

if a > b and a > c:
    x = True
else:
    x = False
s = ("? '%d'>'%d' and '%d'>'%d' =: %r" % (a,b,a,c,x)); g.f_text("%s" % s)

if a > b or a > c:
    x = True
else:
    x = False
s = ("? '%d'>'%d' or '%d'>'%d' =: %r" % (a,b,a,c,x)); g.f_text("%s" % s)

if not (a > b and a > c):
    x = True
else:
    x = False
s = ("? not ( '%d'>'%d' and '%d'>'%d' ) =: %r" % (a,b,a,c,x))
g.f_text("%s" % s)

#   ===========================================================================
#   m:  membership
#   ===========================================================================
#   op: in

g.f_menu("operator.membership")

#   set
lPlanet = ["Sonne", "Mond", "Mars"]
g.f_text(("LPlanet:='%s'" % lPlanet),g.C_COLOR_CYAN)

e = 'Mars'
x = (e in lPlanet)
s = ("? '%s' <in> L \t =: %r" % (e,x)); g.f_text("%s" % s)  # True

e = 'mars'
x = (e in lPlanet)
s = ("? '%s' <in> L \t =: %r" % (e,x)); g.f_text("%s" % s)  # False

#   ===========================================================================
#   m:  identity
#   ===========================================================================
#   op: is
#   op: is not
#   op: ==

g.f_menu("operator.identity")


#   i) try numbers
g.f_menuS1("identity.number")
a = 5
b = 5
c = a
g.f_text(("a,b,c := ('%d','%d','%d')" % (a,b,c)),g.C_COLOR_CYAN)

x = (a is b)
s = ("? <is>(a,b)  =: %r" % (x)); g.f_text("%s" % (s))  # True

x = (a is c)
s = ("? <is>(a,c)  =: %r" % (x)); g.f_text("%s" % (s))  # True

#   ii) try sets
g.f_menuS1("identity.set")
eA = {"apple", "banana"}
eB = {"apple", "banana"}

#   a copy in python is a pointer copy
eC = eA

#   show my sets
g.f_text(("aSet:='%s'" % eA),g.C_COLOR_CYAN)
g.f_text(("bSet:='%s'" % eB),g.C_COLOR_CYAN)
g.f_text(("cSet:='%s'" % eC),g.C_COLOR_CYAN)

#   compare with is
g.f_menuS2("using:'is'")
x = (eA is eB)
s = ("? <is>(eA,eB) =: %r" % (x)); g.f_text("%s" % s)   # False
x = (eA is eC)
s = ("? <is>(eA,eC) =: %r" % (x)); g.f_text("%s" % s)   # True

#   compare with ==
g.f_menuS2("using:'=='")
x = (a == b)
s = ("? == (a,b) =: %r" % (x));     g.f_text("%s" % s)  # True

#   compare with is not
g.f_menuS2("using:'is not'")
x = (a is not b)
s = ("? isNot (a,b) =: %r" % (x));  g.f_text("%s" % s)  # True

#   === :footer
g.f_footer(sTc)

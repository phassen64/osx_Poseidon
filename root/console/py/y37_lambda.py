#   ***************************************************************************
#   My Python Tutorial  :: Lambda (anonyme Funktionen)
#   ***************************************************************************

#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   MOD:   functools
#   KEY:   lambda
#   FCT:   map, filter, reduce

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcLambda'
g.f_header(sTc)

#   ---------------------------------------------------------------------------
g.f_menu("lambda")
#   ---------------------------------------------------------------------------

#   Def: (lambda a1,a2,..,an : <expression>) (p1...pn)
#   with a1..an = argument-list and p1...pn = parameter-list

#   verwendet direkt eine lambda Funktion
i,j = 5,3
y   = (lambda a,n: a ** n)(i,j)
g.f_text("y = pw1(%d,%d) =: %d" % (i,j,y))

#   define a lambda Funktion-Name
i,j = 2,8
FPow = lambda a,n: a ** n
g.f_text("y = pw2(%d,%d) =: %d" % (i,j,FPow(i,j)))

#   define a function, which uses a lambda Funktion
def f_use(p_fPtr,p_lBse,p_lExp):
    p_lRc = list()
    for b in p_lBse:
        if len(p_lRc) > 0:
            p_lRc.append(';')
        for e in p_lExp:
            y = p_fPtr(b,e)
            p_lRc.append(y)
    return p_lRc
lB  = [2,4,6]
lE  = [3,5]
lRc = f_use(FPow,lB,lE)
g.f_text("y = pw3(%s,%s) =: %s" % (lB,lE,lRc))

#   don't use global power function name FPow()
lB  = [7,3,4]
lE  = [2,6]
lRc = f_use(lambda a,n: a ** n, lB,lE)  # Parameter direkt dahinter
g.f_text("y = pw4(%s,%s) =: %s" % (lB,lE,lRc))
#   combine lB x lE =>
#       y = f(lB[i],lE[j]), i=0,1,2; j=0,1

#   ---------------------------------------------------------------------------
g.f_menu("map")
#   ---------------------------------------------------------------------------

#   Def: map(f,L)

lB  = [7,3,4]
lE  = [2,6,5]
lRc = list(map(lambda a,n: a ** n,lB, lE))
g.f_text("y = pw4(%s,%s) =: %s" % (lB,lE,lRc))
#   Achtung:
#   Die Parameter werden nicht wie bei f_use kombiniert,
#   sondern einzeln zugeordnet, also
#       y = f(lB[i],lE[i]), i=0,1,2

#
#   Fahrenheit vs Celsius
#

# Temperature, Fahrenheit=>Celsius, Celsius=>Fahrenheit
lT = (0,20,33,40,60,80,100)
l_F2C = [round((5.0 / 9) * (x - 32)) for x in lT]
l_C2F = [round((9.0 / 5) * x + 32) for x in lT]

# float-formatierte Ausgabe erforderlich
g.f_text("T():={%s}" % str(lT))
g.f_text("F2C(x) => %s" % (l_F2C))
g.f_text("C2F(x) => %s" % (l_C2F))

# use Lib function
l_F2C_f = [(5.0 / 9) * (x - 32) for x in lT]
l_C2F_f = [(9.0 / 5) * x + 32 for x in lT]
g.f_menuS1("print formated with list_f lib-function")
g.f_text("F2C_f(x) => %s" % (g.f_sList(l_F2C_f,False,"2.2f")))
g.f_text("C2F_f(x) => %s" % (g.f_sList(l_C2F_f,False,"2.1f")))

#   ---------------------------------------------------------------------------
g.f_menu("filter")
#   ---------------------------------------------------------------------------

#   Def: filter(f,L)

#   Im Gegensatz zu map wird nicht eine Funktion mit der Input-Liste aufgerufen,
#   also map :=> f(L), sondern bestimmte Werte der Input-Liste zurueckgegeben.
#   Allgemein: lRc = L' = F(L(x)).

#   Fib-Zahlen mit dem Wert '0'
def f_lFib(n):
    lRc = [0]
    if n == 0:
        return lRc
    a,b = 0,1
    for _i in range(n):
        a, b = b, a + b
        # g.f_text("lFib(%d) => %d" % (i+1,a))
        lRc.append(a)
    return lRc

lFib = f_lFib(15)
g.f_text("lFib => %s" % (lFib))

#   Filter auf Wahrheitsliste

#   un-gerade
lOdd = list(filter(lambda x: x % 2, lFib))
g.f_text("lOdd => %s" % (lOdd))

#   gerade
lEve = list(filter(lambda x: x % 2 == 0, lFib))
g.f_text("lEve => %s" % (lEve))

#   >0
tTmp = (-3,1,-55,2,8,-6,-7,9)
lGtZ = list(filter(lambda x: x > 0, tTmp))
g.f_text("lGtZ => %s" % (lGtZ))

#   ---------------------------------------------------------------------------
g.f_menu("reduce")
#   ---------------------------------------------------------------------------

import functools


#   Def : reduce(f,L)
#   with f => f(i) = f(f(i-1),L[i]); with : i=1,...,len(L); f(0)=L[0]

#   f(0)    = a0
#   f(1)    = a0 + a1
#   f(2)    = f(1) + a2
#   f(n)    = f(n-1) + aN

#   Allgemein:
#   f(i)    = f(f(i-1),L[i]); with : i=1,...,len(L); f(0)=L[0]

lSrc    = [1,2,3,4,5,6]
lRc     = functools.reduce(lambda x,y: x + y, lSrc)
g.f_text("reduce(%s) => %s" % (lSrc,lRc))

#   === :footer
g.f_footer(sTc)

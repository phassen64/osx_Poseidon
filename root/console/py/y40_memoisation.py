#   ###########################################################################
#   My Python Tutorial  ::  memoisation    doc:[!30]
#   ###########################################################################
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   Memoisation ist eine Technik, um Computerprogramme zu
#   beschleunigen, indem Rueckgabewerte von Funktionen
#   zwischengespeichert anstatt neu berechnet werden.
#   Memoisation aehnelt Dynamischer Programmierung, bewahrt
#   jedoch im Gegensatz zu dieser die grundlegende
#   Vorgehensweise des zu beschleunigenden Verfahrens.


#   Decorator := is a Function Ptr

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcMemoisation'
g.f_header(sTc)

#   LT 35
C_MAX_VALUES    = 30

#   Trace?
C_DEBUG         = False
C_TRACE         = False    # set it to False

#   init my globals
g_bTrace        = False     # dynamic
g_sTrace        = "&&& TRC([{p1:d}]:FCT:={p2:s})"
g_sTrace_cls    = "&&& TRC([{p1:d}]:CLS:=[{p2:s}::{p3:s}])"

#   ArgCheck?
bArgCheck = False

#   ---------------------------------------------------------------------------
#   Header: definitions
#   ---------------------------------------------------------------------------

g.f_menu("decorators")

#
#   === standard fib-functions
#

def f_fib1(n):  # recursive
    if (C_TRACE and n == C_MAX_VALUES):
        g.f_trace()
    if n == 0: return 0
    elif n == 1: return 1
    else: return f_fib1(n - 1) + f_fib1(n - 2)

def f_fib2(n):  # iterative
    if (C_TRACE and n == C_MAX_VALUES):
        g.f_trace()
    a,b = 0,1
    for _i in range(n): a, b = b, a + b
    return a

#
#   === extended memoize fib-functions
#

#   Diese Funktion ist am schnellsten !
hMemo = dict()  # memo/dict solution - external def
def f_fib3(n):
    if (C_TRACE and n == C_MAX_VALUES):
        g.f_trace()
    if n == 0:    hMemo[0] = 0
    elif n == 1:  hMemo[1] = 1
    elif n not in hMemo:
        hMemo[n] = f_fib3(n - 1) + f_fib3(n - 2)
    return hMemo[n]

#
#   === Pointer function
#

#   Anm1: Der indirekte Aufruf ueber Pointer ist nicht wesentlich schneller
#   als der direkte Aufruf von fib1.

#   Anm2: Aufruf der Memo-Funktion - fetch fPtr
#           fPtr(n)     <== NICHT erlaubt bei Harvard
#   Diese Technik funktioniert nicht mit einer Harvard-Architektur,
#   bei der Code und Daten unterschiedlichen Adress-Bereichen zugewiesen
#   werden.
#   siehe:
#   https://de.wikipedia.org/wiki/Harvard-Architektur
#   In dem Beispiel werden Code-Ptr auf Daten-Ptr angewandt

#   Anm3: Trace zeugt, dass der HelperA nur 1x aufgerufen wird.
#   Dies liegt darin, dass die Funktion fib1 sich selbst direkt aufruft.

#   Anm4: fib4 ist i.d.R. sogar langsamer als fib1 !

def f_memoizeA(p_funcPtr):               # INPUT: functionPtr
    g.f_trace()
    hMemo = dict()                      # create dictionary
    def f_helperA(n):
        if n not in hMemo:
            s = "&&& TRC([{p1:d}],{p2:s},{p3:d})"
            if C_TRACE:
                g.f_trace(p_sTxt=s,p_bEnabled=C_DEBUG)
            hMemo[n] = p_funcPtr(n)     # call my orginal fib-function
        return hMemo[n]
    return f_helperA                    # returns &(f_helperA)

#   define a decorator mit einfacher Syntax
f_fib4  = f_memoizeA(f_fib1)    # IN:fctPtr,OUT:fctPtr - p is the decorator

#
#   === Decorator   : @-function
#

#   AnM: Diese Funktion ist besser - es wird tatsaechlich der HelperB
#   aufgerufen.

def f_memoizeB(p_funcPtr):              # INPUT: functionPtr
    g.f_trace()
    hMemo = dict()
    def f_helperB(n):
        if n not in hMemo:
            s = "&&& TRC([{p1:d}],{p2:s},{p3:d})"
            g.f_trace(s,p_bEnabled=C_DEBUG)
            hMemo[n] = p_funcPtr(n)     # call my orginal fib-function
        return hMemo[n]
    return f_helperB                    # returns &(f_helperB)

@f_memoizeB     # @-muss vor der Funktion stehen
def f_fib5(n):  # recursive
    if (C_TRACE and (n == C_MAX_VALUES)):
        g.f_trace()
    if n == 0: return 0
    elif n == 1: return 1
    else: return f_fib5(n - 1) + f_fib5(n - 2)

#
#   === Decorator   : @-class
#

#   AnM: Diese Funktion fib6 ist etwa so schnell wie die iterative fib2-Loesung
#   und schneller als fib5.
#   Anm: Die Trace-Zeilen reduzieren erheblich die Performance.

class CMemoize:
    def __init__(self, p_pFct):
        self.m_pFct  = p_pFct
        self.m_hMemo = dict()
        g.f_trace(p_bEnabled=C_DEBUG)
    def __call__(self, *p_tArgs):
        if p_tArgs not in self.m_hMemo:
            g.f_trace(p_bEnabled=C_DEBUG)
            self.m_hMemo[p_tArgs] = self.m_pFct(*p_tArgs)
        return self.m_hMemo[p_tArgs]

@CMemoize       # Vor der Funktion  !
def f_fib6(n):  # recursive
    if (C_TRACE and (n == C_MAX_VALUES)):
        g.f_trace()
    if n == 0: return 0
    elif n == 1: return 1
    else: return f_fib6(n - 1) + f_fib6(n - 2)

#
#   === Decorator   : @-args
#

#   Jetzt sollen nur die Argumente geprueft werden.
#   Es duerfen nur positive Zahlen eingegeben werden.

def f_argCheck(p_funcPtr):
    g.f_trace()
    _hMemo = dict()
    def f_helperC(n):
        if ((type(n) is int) and (n > 0)):
            return (p_funcPtr(n))
        else:
            raise Exception
            ("?Arg(" + str(n) + "): is not type 'Integer' or '>0')")
        return True
    return f_helperC

@f_argCheck     # @-muss vor der Funktion stehen
def f_fib7(n):
    if n == 0: return 0
    elif n == 1: return 1
    else: return f_fib7(n - 1) + f_fib7(n - 2)

#   ---------------------------------------------------------------------------
#   Body
#   ---------------------------------------------------------------------------

#   --- call 1-6
g.f_menu("call fktPtr")

n = C_MAX_VALUES
lFct = [f_fib1,f_fib2,f_fib3,f_fib4,f_fib5,f_fib6]      # fktPtr() Array
i = 0
sCol = g.C_COLOR_CYAN
for pFct in lFct:
    i += 1
    if (i == 99):     # show special value 1..6
        s = "&&& FCT:=<{p1:s}>".format(p1=str(pFct))
        g.f_trace()
    s = "\tfib{p1:d}:({p2:d}) =: ...".format(p1=i,p2=n)
#   g.f_text(s)
    g.f_print(s,sCol)
    t0  = g.f_iDtm2Unix()
    y   = pFct(n)                     # (*pFctPtr)(n)
    td  = g.f_iDtm2Unix() - t0
    g.f_puts(("=:%d; timeNeeded=<%s>(ms)" % (y,td)),sCol)

#   --- call 7=argCheck
g.f_menu("call argCheck?")
if bArgCheck:
    bExc = False
    try:
        y = f_fib7(-123)
    except Exception as iExc:
        bExc = True
        g.f_text("fib7(x)=>exc=>{%s}" % (str(iExc)))
    #   TEST:bExc=False
    if (not bExc):
        g.f_exit(p_sTxt="NoExc!")

'''
    end of functions
'''

g.f_trace("finish")

#   === :footer
g.f_footer(sTc)

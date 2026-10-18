#   ***************************************************************************
#   My Python Tutorial  :: function
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   url:
#       https://www.w3schools.com/python/python_functions.asp
#       https://peps.python.org/pep-3107/
#       https://www.tutorialspoint.com/python/python_function_annotations.htm
#       https://www.geeksforgeeks.org/args-kwargs-python/

#   === :header
from __future__ import annotations      # at begin of file
import sys
assert sys.version_info >= (3,9)
from typing import Any      # dataType:any
from array import array     # dataType:array
import LIB_inc as m;  g = m.CLib();   sTc = 'TcFunction'
g.f_header(sTc)

#   === :content

'''
    content:
        m:  basics
        m:  check function annotation
        m:  defaultParameter
        m:  multiTypeParameter
        m:  variadic    * args vs kwargs
            s:  variadic.list <args>
            s:  variadic.dictionary <kwargs>
            s:  variadic:combined
        m:  specialParameter
            s:  positionOnly    arg/
            s:  keywordOnly     *arg
            s:  poskeyOnly:combined
        m:  callable
        m:  functionPtr
            s: define pFct
                u: call pPtr
            s: define hFct
                u: call hFct
        m:  generic function
        m:  docString
'''

#   ===========================================================================
#   m:  basics
#   ===========================================================================

g.f_menu("intro Function")

g.f_trace("define")

#   define a function - no return
def F_hello():
    sFct,sLoc = g.f_info('F'),g.f_info('L')
    g.f_text("Hello I am in function:<%s> at:<%s>" % (sFct,sLoc))

#   using function Annotation
def F_hello2() -> None:
    sFct,sLoc = g.f_info('F'),g.f_info('L')
    g.f_text("Hello2: I am in :<%s> at:<%s>" % (sFct,sLoc))

def F_add2(p_i1:int,p_i2:int) -> int:
    iSum = p_i1 + p_i2
    return iSum

#   call hello
g.f_menuS1("run hello")
F_hello()
F_hello2()

#   run add2
g.f_menuS1("run add")
i1 = g.f_iRandom()
i2 = g.f_iRandom()
iSum = F_add2(i1,i2)
g.f_text("F_add2: :<%d> + <%d> =: %d" % (i1,i2,iSum))

#   getType of a function
sType = type(F_hello);  g.f_text("? type(F) =: <%s>" % (sType))  # <<< function

#   ===========================================================================
#   m:  check function annotation
#   ===========================================================================
#   ?IsCheck the function annotation of
#       F_add2(p_i1:int,p_i2:int)->int

g.f_menu("generate a typeError")

a = 100
s = 'x'     # no integer!

try:
    x = F_add2(a,s)     # s has wrong Type
    g.f_text("x := fAdd(a,s) =:%d" % (x))

except Exception as tExc:
    s = "?excANY=["
    s += str(tExc)
    s += "]:<"
    s += type(tExc).__name__        # TypeError
    s += ">"
    g.f_text("%s" % (s))


#   ===========================================================================
#   m:  defaultParameter
#   ===========================================================================

g.f_menu("default parameter")

def F_person(p_sName:str = 'Harvey',
             p_iAge:int = 13,
             p_fWht:float = 2.13) -> str:
    s = F"The person:<{p_sName}> has Age:<{p_iAge}> and Weight:<{p_fWht}>"
    return s

#   use all default parameters
s = F_person(); g.f_text("CheckOf<def> =: %s" % s)

#   best pratise - name default-arguments
s = F_person(p_iAge=108); g.f_text("CheckOf<Age> =: %s" % s)

#   ===========================================================================
#   m:  multiTypeParameter
#   ===========================================================================

g.f_menu("multiTypeParameter functions")

#   new Fadd+
def F_multiType(b:bool,
                i:int,
                L:list,
                t:tuple,
                e:set,
                a:array
            ) -> tuple[bool, int]:
    #   calc something
    iRc = i + L[0] + t[0] + e.pop() + a[0]
    return True,iRc

b = True
i = 100
L = [10,'anton',99]
t = [3,'bert',7]
r = [3,'bert',7]
e = {5, 2, 3, 1}
a = array('i', [1000, -2, 3, +4, 5])

b,x = F_multiType(b,i,L,t,e,a)
g.f_text("x := fMulti+(a,b) =: %r && %d" % (b,x))    # True,1114


#   ===========================================================================
#   m:  variadic
#   ===========================================================================

#   Unbestimmte Anzahl von Parametern, die
#       a)  unbenannt  sind *args oder
#       a)  benannt  sind *kwargs   * keyword-args
#   Es koennen beliebig viele einzelne Werte oder
#   eine Liste,Tupel oder ein Dictionary


g.f_menu("variadic")

#
#   s:  variadic.list <args>
#
g.f_menuS1("variadic list")

def F_add(*p:list[int]) -> int:
    i = 0
    for x in p:
        if (not (isinstance(x,int))):
            continue
        i += x
    return i

#   run more than 2 values
iSum = F_add(1,2,3)
g.f_text("F_add(1,2,3)      =: %d" % (iSum))    # 6

#   run negative values
iSum = F_add(-1,5,8,-4)
g.f_text("F_add(-1,5,8,-4)  =: %d" % (iSum))    # 8

#   add List - define a list L, unpack L, call function
L = [7,8,9]
iSum = F_add(*L)
g.f_text("F_add(%s)  =: %d" % (str(L),iSum))    # 24

#   add random list
L   = []
n   = 5
iMax = 1000
iMin = -1000
for _x in range(n):
    i = g.f_iRandom(iMax,iMin)
    L.append(i)
iSum = F_add(*L)
g.f_text("F_add(%s)  =: %d" % (str(L),iSum))    # ?

#   check mixed list
L = [10,6.12,20,'peter',30]
iSum = F_add(*L)
g.f_text("F_addMixed(%s)  =: %d" % (str(L),iSum))    # 60

#
#   s:  variadic.dictionary <kwargs>
#

g.f_menuS1("variadic dictionary")

def F_country(**p_Hash:dict) -> int:
    i = 0
    sFct,sLoc = g.f_info('F'),g.f_info('L')
    g.f_text("Function:<%s> at:<%s>" % (sFct,sLoc))
    for eKV in p_Hash:
        i += 1
        s = "[{xIdx}]:{xKey}=>{xVal}".format(xIdx=i,xKey=eKV,xVal=p_Hash[eKV])
        g.f_text(s)
    return True

hCountry  = {
        "US": "USA",
        "DE": "Deutschland",
        "GB": "Great Britain",
        "ES": "Espania"
}

g.f_text("hCtry:%s" % g.f_sHash(hCountry))
F_country(**hCountry)

#
#   s:  variadic:combined
#

g.f_menuS1("variadic combined")

def F_variadicTest(
        p_iId: Any,
        *args: Any,     # args default
        x: int = 2,
        y: int = 3,
        z: int = 4,
        **kwargs: Any) \
        -> None:
    g.f_text(f"+ pos.iId := {p_iId}")
    g.f_text(f"+ def x := {x}, y := {y} , z := {z}")
    g.f_text("+ args   := <%s>   ; type:<%s>"   % (args,type(args)))
    g.f_text("+ kwargs := <%s>   ; type:<%s>"   % (kwargs, type(kwargs)))


g.f_text("runTest")
F_variadicTest(
    4711,       # std.iId
    3,          # args.1
    4,          # args.2
    x=1337,     # def.x
    m_bVal=False,       # kwarg.b
    m_sVal='peter',     # kwarg.s
    m_fVal=69.5,        # kwarg.f
)

#   pos := 4711
#   def x:1337 | y:3 | z:4
#   args    := <3,4>
#   kwargs  := <m_bVal:False, m_sVal:peter, m_fVal:69.5>

#   ===========================================================================
#   m:  specialParameter
#   ===========================================================================

g.f_menu("special Parameter")

#   s:  positionOnly    arg/     op '/' after argument
g.f_menuS1("argument:positionOnly")
def F_posOnly(p_iVal,/) -> int:
    iSum = p_iVal * 2
    return iSum
iRc  = F_posOnly(1)              # error F_posOnly(p_iVal=2)
g.f_text("FPosOnly := <%d>"   % (iRc))

#   s:  keywordOnly     *arg       op '*' before argument
g.f_menuS1("argument:keywordOnly")
def F_keyOnly(*,p_iVal) -> int:
    iSum = p_iVal * 4
    return iSum
iRc  = F_keyOnly(p_iVal=2)
g.f_text("FKeyOnly := <%d>"   % (iRc))

#   s:  poskeyOnly:combined
g.f_menuS1("argument:PosKeyOnly combined")
def F_poskeyOnly(p_A,/,p_B,*,p_C,p_D) -> int:     # 1x pos 2x key
    iSum = p_A * 2 + p_B * 4 - p_C ** p_D
    return iSum

#   combinations
iRc  = F_poskeyOnly(3,3,p_C=4,p_D=5);       g.f_text("FOsKeyOnly := <%d>" % iRc)
iRc  = F_poskeyOnly(3,p_B=11,p_C=4,p_D=1);  g.f_text("FOsKeyOnly := <%d>" % iRc)

#   ===========================================================================
#   m:  callable
#   ===========================================================================

g.f_menu("callable")

def F_print_list(p_iList: list[int]) -> None:
    g.f_text("L =: %s" % p_iList)

def F_wrapper_printList(    # needs future annotation
        p_iList_wrp: list[int],
        p_pFctn_wrp: callable[[list[int]], None]) -> None:
    p_pFctn_wrp(p_iList_wrp)

def F_test_callable() -> None:
    L_iDec = [10, 20, 30]
    F_wrapper_printList(L_iDec, F_print_list)

if __name__ == "__main__":
    F_test_callable()

#   ===========================================================================
#   m:  functionPtr
#   ===========================================================================

g.f_menu("functionPtr")

def F_TestPtr(p_iVal):
    sFct,sLoc = g.f_info('F'),g.f_info('L')
    g.f_text("I'm in:<%s> at:<%s> and get VAL:<%d>" % (sFct,sLoc,p_iVal))
    return 4711

#   s: define pFct
g.f_menuS1("using pFct")
p = F_TestPtr
g.f_text("? type(p) =: <%s>" % (type(p)))   # <class 'function'>
g.f_text("? &mem(p) =: <%X>" % (id(p)))     # 2BF25456AC0

#   u: call pFct()
g.f_menuS2("call pFct")
iVal = 789
iRc  = p(iVal)
g.f_text("pFct(%d) => %d" % (iVal,iRc))

#   s: define hFct
g.f_menuS1("using dictionary hFct")
sKey,sVal,iVal = 'm_fctPtr', F_TestPtr, 123
pFct = sKey
h    = {sKey: sVal}  # dictionary with 1 element
g.f_text("hFct =: <%s>" % str(h))

#   u: call hFct()
#   call my function - using dictionary
g.f_menuS2("call hFct")
iRc         = h[pFct](iVal)
g.f_text("h[pFct](%d) => %d" % (iVal,iRc))  # 123=>4711

#   ---------------------------------------------------------------------------
#   m:  generic function
#   ---------------------------------------------------------------------------
#   Funktionen mit veränderlichen Datentypen,
#       welche aber geprüft werden können,
#       im Gegensatz zur Verwendung von any.
#   url: https://www.tutorialspoint.com/python/python_generics.htm

g.f_menu("generic function")

#   import type
from typing import TypeVar

#   make new dataType
TValue = TypeVar("TValue")

#   function uses newDataType
def F_generic_repeat(x: TValue, n: int) -> list[TValue]:
    return [x] * n

#   run my test using as [int,float] for TValue
if __name__ == "__main__":
    L_gen = F_generic_repeat(2,5)
    g.f_text("l.gen1 = %s" % str(L_gen))
    L_gen = F_generic_repeat(1.0,3)  #  noqa
    g.f_text("l.gen2 = %s" % str(L_gen))
    assert (L_gen[2] == 1.0)


#   ===========================================================================
#   m:  docString
#   ===========================================================================
#   https://peps.python.org/pep-0257/

g.f_menu("docStr")

def F_doc():
    """MyDocStr:=ThisIsMy Docu"""       # set: docString

if sys.version_info >= (3,10):
    sRc = help(F_doc)   # get: docString
    g.f_text("docStr =: %s" % sRc)

#   === :footer
g.f_footer(sTc)

#   ***************************************************************************
#   My Python Tutorial  :: closure and decorator
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#
#   +   url
#       https://www.programiz.com/python-programming/closure
#       https://www.programiz.com/python-programming/decorator

#   •   closure
#       Python closure is a nested function that allows us to access variables
#               of the outer function even after the outer function is closed.
#       ---   principal
#       def fOuter()
#           def fInner()
#

#
#   •   decorator
#       In Python, a decorator is a design pattern that allows you to modify
#           the functionality of a function by wrapping it in another function.
#       The outer function is called the decorator,
#               which takes the original function as an argument and
#               returns a modified version of it.

'''
    !content:
        m:  closure
            s:  intro
            s:  auto-inner call
            s:  2-step-call:closure
            s:  pass functionPtr
        m:  decorator
            s:  decorator.print
            s:  decorator.timing
'''

#   === :header
import time
from typing import Any
import LIB_inc as m;  g = m.CLib();   sTc = 'TcDecorator'
g.f_header(sTc)

#   ===========================================================================
#   m:  closure
#   ===========================================================================

#   So what are closures good for?
#   Closures can be used to avoid global values and provide data hiding,
#       and can be an elegant solution for simple cases with one or few methods.
#   However, for larger cases with multiple attributes and methods,
#       a class implementation may be more appropriate.


g.f_menu("closure")


#
#   s:  intro   - manually inner-call
#

g.f_menuS1("intro")

#   --- des:
#   1. define 2 nested functions outer() and inner()
#   2. outer calls inner
#   3. run outer function

def f_showName(p_sName:str) -> None:
    def f__do_showName():     # define inner function
        g.f_text(f"My name is := <{p_sName}>")   # access to outer value
    f__do_showName()        # manuall inner-call function

#   call outer function
f_showName('John')
#   <<< My name is := <John>

#
#   s:  auto-inner call
#

g.f_menuS1("auto-inner with globals")

#   --- des:
#   1. nested functions outer() and inner()
#   2. outer() returns fctPtr to inner()
#   3. outer defines globals
#   4. inner() uses globals of outer()
#   5. run outer
#   6. automatically inner function will be called

def f_showTime(p_sMessage:str) -> Any:
    g_sMsg = p_sMessage
    g_tDtm = time.time()
    def f__inner() -> None:
        g.f_text("Msg: <%s>" % g_sMsg)   # access to global1
        g.f_text("Dtm: <%s>" % g_tDtm)   # access to global2
    return f__inner()

f_showTime("Peter!")
#   <<< Msg: <Peter!>
#   <<< Dtm: <1712657701.3962376>


#
#   s:  2-step-call:closure
#

g.f_menuS1("2-step-call:closure")

#   --- des:
#   1. define outer-add() an inner-add()
#   2. call outer and save fctPtr
#   3. call fctPtr to inner

def f_addOuter(x:int) -> callable:
    def f__innerAdd(y:int):
        return x + y
    return f__innerAdd

#   perform add
fPtr    = f_addOuter(5)        # stores x=5
iRc     = fPtr(6)              # f__innerAdd(6)

#   show
g.f_text("iRc.nested =: %d" % iRc)  # prints 11

#
#   s:  pass functionPtr
#

#   We can pass a function as an argument to another function in Python

g.f_menuS1("functionPtr-argument call")

#   --- des:
#   1. define normal function 1
#   2. define function2 with functionPtr to function in 1.
#   3. call function 2

#   normal add function1
def f_add2(x:int, y:int) -> int:
    return x + y

#   define function2 using a function pointer
def f_calculate(p_fPtr:callable, x:int, y:int):    # p_fPtr is &f())
    return p_fPtr(x, y)

#   call the function2
iRc = f_calculate(f_add2, 40, 60)
g.f_text("iRc.pass =: %d" % iRc)  # prints 100


#   ===========================================================================
#   m:  decorator
#   ===========================================================================

#   from functools import wraps

g.f_menu("decorator")

#
#   s:  decorator.print
#

g.f_menuS1("decorator @decoPrint")

#   --- des:
#   1.  the outer decorater "print" contains  inner function "wrapper"
#   2.  outer has argument fctPtr arguF
#   3.  inner calls arguF()
#   4.  outer() returns fctPtr to inner()

#   https://stackoverflow.com/questions/308999/what-does-functools-wraps-do

#   u:  define
g.f_menuS2("define decorator")

def F_decorator_print(p_pFct:callable) -> callable:
    sNam = p_pFct.__name__
    g.f_puts(("\t--- @decoPrint of:<%s>" % sNam),g.C_COLOR_BLUE)
    #    g.C_COLOR_BLUE)
    def f__wrapper(*args: Any, **kwargs: Any) -> Any:
        tResult = p_pFct(*args, **kwargs)
        g.f_text("Ausgabe:%s by:[%s]" % (str(tResult),sNam))
        return tResult
    return f__wrapper

#   check type
sType = type(F_decorator_print)
g.f_text("? type(@decoPrint) =: <%s>" % (sType))  # => class 'function

#   u:  using
g.f_menuS2("using decorator")

@F_decorator_print
def F_hello() -> str:
    '''only hello'''
    return 'Hello Peter'

@F_decorator_print
def F_add(a:int, b:int) -> int:
    '''Add two objects together, the long way'''
    return a + b

@F_decorator_print
def F_sum(*p:int) -> int:
    '''Sum any numbers together, the long way'''
    iSum = 0
    for x in p:
        iSum += x
    return iSum

#   u:  test
g.f_menuS2("test")
F_hello()
F_add(10,20)
F_sum(1,2,3,4)

#
#   s:  decorator.timing
#

g.f_menuS1("decorator: timing")

from functools import wraps

#   --- des:
#   1.  the outer decorater "timing" contains  inner function "timer"
#   2.  outer returns timerPtr

def F_decorator_timing(p_FctPtr:callable) -> callable:
    #   save nameSpace
    @wraps(F_decorator_timing)
    def f__timer(*args: Any, **kwargs: Any) -> Any:
        g.f_puts("\t--- decorator.timing",g.C_COLOR_BLUE)
        #   Timer.start
        fTimeStart  = time.perf_counter()
        tResult     = p_FctPtr(*args, **kwargs)  # fIterate...
        fTimeStopp  = time.perf_counter()
        #   Timer.stopp
        fTimeSpan   = fTimeStopp - fTimeStart
        g.f_text(f"Function {p_FctPtr.__name__} took: {fTimeSpan} s")
        return tResult
    return f__timer

#   check type
sType = type(F_decorator_timing)
g.f_text("? type(@decoTiming) =: <%s>" % (sType))  # => class 'function

#   u:  @decoTiming.iterate
g.f_menuS2("@decoTiming.iterate")

@F_decorator_timing
def F_iterate(n: int) -> int:
    val = 0
    for i in range(n):
        val += i
    return val

#   run
iVal = F_iterate(1_000_000)
g.f_text("iRc.iterate : <%f>" % iVal)


#   === :footer
g.f_footer(sTc)

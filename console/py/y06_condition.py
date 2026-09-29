#   coding:UTF-8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿Ñ×ØÜÞßäæçîðñôö÷üýþÿ---$
#   ***************************************************************************
#   My Python Tutorial  :: condition
#   ***************************************************************************

'''
    !content:
        •   m:  if-then-elif-else
                s:  shorthand:if
                s:  shorthand:if-else
                s:  shorthand:if-else-if-else
        •   m:  switch
        •   m:  match < removed >

'''

#
#   m:  prepare script
#

#   === :header
import random
import LIB_inc as m;    g = m.CLib();   sTc = 'TcCondition'
g.f_header(sTc,True)

#   === : generate test values
a = g.f_iRandom(5,1)    # 1..5
b = g.f_iRandom(8,3)    # 3..8
g.f_text("A:='%d' B:='%d'" % (a,b))


#   ===========================================================================
#   m:  if-then-elif-else
#   ===========================================================================

g.f_menu("condition.if-then-else")

x = 0
if a > b:
    x = 1
elif a < b:
    x = 2
elif a == b:
    x = 3
else:
    x = 4

g.f_text("(%d,%d) => if a>b :1 elif a<b :2 elif a==b :3 else :4 => '%d'"
    % (a,b,x))

#   s:  shorthand:if

g.f_menuS1("shorthand if")
if a > b: g.f_text("a:%d is greater than b:%d" % (a,b))

#   s:  shorthand:if-else
g.f_menuS1("shorthand if-else")
g.f_text("1: A>B") if a > b else g.f_text("1: !A>B")    # A>B
g.f_text("2: A<B") if a < b else g.f_text("2: !A<B")    # A<B

#   s:  shorthand:if-else-if-else
g.f_menuS1("shorthand if-else-if-else")
g.f_text("1:A") if a > b else g.f_text("2:=") if a == b else g.f_text("3:B")

#   ===========================================================================
#   m:  switch mit dictionary
#   ===========================================================================

g.f_menu("condition.switch.helper")

#   url: https://codegree.de/python-switch-case/

switch_mit_dictionary = {
    0: 'Null',
    1: 'Eins',
    2: 'Zwei',
    3: 'Drei'
}

v = random.randint(0,3)
g.f_text("v:='%d'" % (v))

s = switch_mit_dictionary.get(v, 'number is in [0..3]!')
g.f_text("Switch(%d) is: %s" % (v,s))


#   === :footer
g.f_footer(sTc)

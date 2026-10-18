#   ***************************************************************************
#   My Python Tutorial  :: variable && dataTypes [ohne library]
#   ***************************************************************************
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ-------$

#   url : https://www.w3schools.com/python/python_datatypes.asp

'''
    !content:
        m:  constants?
            s:  simple
            s:  byClass
        m:  variable
            s:  create
            s:  multi-assign
            s:  multi-output
            s:multi-init
'''

import LIB_inc as m


g = m.CLib()
sTc = "tcVariable"

#   === :header

g.f_header(sTc)

#   ===========================================================================
#   m:  constants?
#   ===========================================================================

#   url:https://stackoverflow.com/questions/2682745/how-do-i-create-a-constant-in-python

#   There's no const keyword as in other languages,
#   however it is possible to create a Property
#   that has a "getter function" to read the data,
#   but no "setter function" to re-write the data.
#   This essentially protects the identifier from being changed.
#   Here is an alternative implementation using class property:

g.f_menu("constant")

#   s:  simple
g.f_menuS1("simple")
C_CONSTVALUE   = 1234
g.f_text("CMAX:'%d'" % (C_CONSTVALUE))


#   s:  byClass
g.f_menuS1("class")
def f_constant(p_tValue):
    def fset(self, value):
        raise TypeError
    def fget(self):
        return p_tValue()
    return property(fget, fset)

class _CConst(object):
    @f_constant
    def f_FOO():
        return 0xBAADFACE
    @f_constant
    def f_BAR():
        return 0xDEADBEEF

CONST = _CConst()
s1 = hex(CONST.f_FOO)  # -> '0xbaadfaceL'
s2 = hex(CONST.f_BAR)  # -> '0xbaadfaceL'
g.f_text("CONST.FOO:'%s'" % s1)
g.f_text("CONST.BAR:'%s'" % s2)

#   ===========================================================================
#   m:  variable
#   ===========================================================================

#   Anm:
#   Der Datentyp wird in Python auch nicht an die Variable,
#       sondern an den Wert gebunden.
#   Dadurch ist eine Variable nicht auf einen Datentyp festgelegt und kann
#   zur Laufzeit Werte eines anderen Datentypes referenzieren.

#   s:  create
g.f_menu("variable")
i   = 5
s   = "peter"
g.f_text("ti:'%d' s:'%s'" % (i,s))

#   s:  multi-assign
g.f_menuS1("multi-assign")
i,s,f   = 77, 'hans', 3.1
g.f_text("i:'%d' s:'%s' f:'%f'" % (i,s,f))

#   s:  multi-output
g.f_menuS1("multi-output")
x = "Python "
y = "is "
z = "awesome in year:"
i = 2024
print('\t' + x + y + z + str(i))

#   s:  multi-init
g.f_menuS1("multi-list assign")

i,*LNum = 1,2,3,4,5,6,7,8,9     # !CRQ-240426: use i and not x, which is str()
g.f_text(F" i := {i} ")         # i:=1
g.f_text(F" L := {LNum} ")      # L:=2,3,4...m9

#   === :footer
g.f_footer(sTc)

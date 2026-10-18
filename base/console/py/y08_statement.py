#   ***************************************************************************
#   My Python Tutorial  :: statement
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    !content:
        •   m:  simple
        •   m:  nop
        •   m:  multiple.assign
                s:  assign
                s:  exchange
                s:  exchange2
                s:  packing
        •   m:  generated statements
                s:  eval
                s:  exec
                s:  compile

    !keyword:
        pass

    !function:
        eval() exec() compile()
'''

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = "tcStatement"
g.f_header(sTc)

#
#   m:  simple
#

g.f_menu("simple statements")
s = 'abc'
g.f_text("s = '%s'" % (s))

#
#   m:  nop
#

g.f_menu("nop statement")
pass
g.f_text("pass...")
pass

#
#   m:  multiple
#

g.f_menu("multiple statements")

#   = !s:assign
g.f_menuS1("assign")
x,y,z = 6.1,-4,'abc'
g.f_text("x,y,z => %f,%d,%s" % (x,y,z))

#   = !s:exchange
g.f_menuS1("exchange")
x,s = 123,'abc'
g.f_text("x,s => %d,%s" % (x,s))
s,x = x,s
g.f_text("x,s => %s,%d" % (x,s))

#   = !s:exchange2
g.f_menuS1("exchange like C")
x = 12; y = 34; x,y = y,x
g.f_text("x,y => %d,%d" % (x,y))

#   = !s:packing, unpacking  see:[16.9.3]
g.f_menuS1("packing/unpacking")
x, *y = 1,2,3,4,5,6,7,8,9
g.f_text("first,remainder => x=%d, y=%s" % (x,y))
x, *y       = 'A','B','C','D'
g.f_text("before,last => x=%s, y=%s" % (x,y))
x, *y, z    = 'a','b','c','d'
g.f_text("first,middle,last => x=%s, y=%s, z=%s" % (x,y,z))


#   ============================================================================
#   m:  generated statements
#   ============================================================================

#   compile(<pythonCodeStr>,"nameId",<cmdStr>)
#   with: <cmdStr> = {"exec","eval","single"}
#   So it takes python code, and returns on of those two things
#       +exec will execute the python code
#       +eval will evaluate an expression, which is less functional than exec
#       +ast allows you to navigate the Abstract Syntax Tree
#           that the code generates


#   from math import *      # implecitely access sqrt()

#   using compile/exec - evaluate statements later
g.f_menu("compile statements")

#   s:  eval
g.f_menuS1("eval")
i = 1
x = "i+1"
y = eval(x)
g.f_text("eval1(%d,%s) => (%s)" % (i,x,y))

F = "sqrt(x)"                                           # formula
g.f_text("myFormula =: 'y=%s'" % (F))
for x in (81, 100,3136):
    y = round(eval(F))      # F(81); F(100), F(3136)
    g.f_text("y(%d) => (y=%f)" % (x,y))

#   s:  exec
g.f_menuS1("exec")
P = 'y=sqrt(x); g.f_text("y(%d) => %s" % (x,y));'   # myProgram
g.f_text("PROGRAM =: 'P=%s'" % (P))
for _x in (81, 100,3136):
    exec(P)          # return 9.0; 10.0; 56.0

#   s:  compile
g.f_menuS1("compile")
yP = compile(P,'myCode1',"exec")
for _x in (81, 100,3136):
    exec(yP)          # return 9.0; 10.0; 56.0


#   === :footer
g.f_footer(sTc)

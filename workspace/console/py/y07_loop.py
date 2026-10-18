#   coding:UTF-8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   ***************************************************************************
#   My Python Tutorial :: loops  [!BP3:10]
#   ***************************************************************************
#   url:    https://www.w3schools.com/python/python_while_loops.asp
'''
    !content:
    •   m:  while
    •   m:  while <condition>
    •   m:  while,break,continue,else
            s:   break
            s:   continue
            s:   else
    •   m:  for
            s:  for.SET
            s:  for.TUPLE
    •   m:  for(foreach) in <dataType>
    •   m:  for RANGE
            s:  for range.N
            s:  for range.(FROM,To,StepSize)
    •   m:  for enumerate
'''

#   === :header
import random
import LIB_inc as m;    g = m.CLib();   sTc = 'TcLoops'
g.f_header(sTc)


#   ===========================================================================
#   m:  while
#   ===========================================================================

#
#   m:  while <condition>
#

g.f_menu("while")
i,n = 0,random.randint(0,5)
g.f_text("while '%d' < '%d'" % (i,n))
while i <= n:
    i += 1
    g.f_text("* while[%d]" % i)


#
#   m:  while,break,continue,else
#

g.f_menu("while2 with break,continue and else")

t = (1,2,3,4,5,77)
l = len(t)
g.f_text("t=%s(len=%d)" % (str(t),len(t)))

i = 0
while i <= 10:
    i += 1
    if i >= l:
        g.f_text("&&& doBreak at:%d" % i)
        break           # skip while-else
    if i < 2:
        g.f_text("&&& doContinue at:%d" % i)
        continue
    s = str(t[i])
    g.f_text("* find at [%d] value=(%s)" % (i,s))
else:   # 'else' belongs to 'while'
    g.f_text("...while-else exclaims :: loop is finished.")

#   http://stackoverflow.com/questions/3295938/else-clause-on-python-while-statement
#   The else clause is only executed when your
#       while condition becomes false. If
#   you break out of the loop, or if an exception is raised, it won't be
#       executed.
#   --- The else clause is executed if you exit a block normally,
#   by hitting the loop condition or falling off the bottom of a try block.
#   It is not executed if you 'break' or 'return' out of a block, or 'raise
#       an exception'.
#   It works for not only while and for loops, but also try blocks.
#   Oder: while-else, wenn
#       a) loop condition ends

#   ===========================================================================
#   m:  for
#   ===========================================================================

#
#   m:  for(foreach) in <dataType>
#

# Rem:In Python gibt es nur foreach
g.f_menu("for <dataType>")

#   s:  for.SET

g.f_menuS1("for.SET eFruit")
eFruit = {"apple", "banana", 4711, "cherry"}
g.f_text("e:=%s" % eFruit)
i = 0
for x in eFruit:
    i += 1
    g.f_text("\tFruit[%d] = : '%s'" % (i,x))


#   s:  for.LIST

g.f_menuS1("for.LIST lMammal")
lMammal = ['Monkey', "Elephant", 4711, "Rabbit"]
g.f_text("l:=%s" % lMammal)
i = 0
for x in lMammal:
    i += 1
    g.f_text("\tMammal[%d] = : '%s'" % (i,x))

#   s:  for.TUPLE

g.f_menuS1("for.TUPLE tCountry")
tCountry = ('Argentien','Brasilien','Camerun','Deutschland','England')
g.f_text("t:=%s" % str(tCountry))
i = 0
for x in tCountry:
    i += 1
    g.f_text("\tCountry[%d] = : '%s'" % (i,x))


#
#   m:  for RANGE
#

g.f_menu("for RANGE...")

t = ('Anton','Bert','Clara','Doris','Emil','Fritz','Gustav','Hans')
n = random.randint(0,len(t) - 1)
g.f_text("using: t=%s n=%d" % (str(t),n))


#   s:  for range.N

g.f_menuS1("range(n)")
i = 0
for i in range(n):  # i=0...n-1
    s = str(t[i])
    g.f_text("< for[%d]=:'%s'" % (i,s))


#   s:  for range.(FROM,To,StepSize)

g.f_menuS1("range(start,stop,step)")
n = random.randint(0,len(t) - 1)
g.f_text("using: t=%s;Stop=%d" % (str(t),n))
iStart,iStop,iStep = 1,n,1
for i in range(iStart,iStop,iStep):  # incl.iStart, excl.iStop,iStepSize
    s = str(t[i])
    g.f_text("for[%d]=:'%s'" % (i,s))

#
#   m:  for enumerate
#

g.f_menu("for ENUMERATION")

t = ('a1','b2','c3')
g.f_text("using: t=%s" % str(t))
for iIdx,tElem in enumerate(t):
    g.f_text("for idx=[%d] => element=:'%s'" % (iIdx,tElem))

#   === :footer
g.f_footer(sTc)

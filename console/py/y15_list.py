#   ***************************************************************************
#   My Python Tutorial  :: list
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   url:
#   https://www.w3schools.com/python/python_lists_copy.asp

#   Lists are used to store
#       multiple items in a single variable.

#   List items are :
#       +   ordered and
#       +   changeable
#       +   and allow duplicates.

#   List items are the most comfortable data type collection,
#       but they need time for it.

#   NOTE: The list variable is a pointer, not an object name.
#           pList1 = pList2 = [1,2,3]


'''
    !content:
        m:  define
        m:  init
            s:  empty
            s:  directly
            s:  convertedBy Tuple
            s:  mixed
            s:  mixed.annotated - removed
        m:  combound listComprehension
        m:  modify
            s:  add
            s:  sub
            s:  concatenator
            s:  repeat
            s:  unique&&sorted
        m:  slicing
            s:  simple
            s:  object
        m:  function
            s:  sum
            s:  check.IN()
            s:  check.ALL()
            s:  check.ANY()
        m:  method
            s:  append
            s:  insert
            s:  extend
            s:  pop
            s:  remove
            s:  count
            s:  index
        m:  sort.advanced
            s:  byFunction
            s:  byMethod
'''

#   === :header
import LIB_inc as m; g = m.CLib(); sTc = 'TcList'
g.f_header(sTc)

#   ===========================================================================
#   m:  define - no Object
#   ===========================================================================

g.f_menu("define only")

L: list[str]         # annotated define
bEc = False
sRc = '?'
try:
    sRc = L[0]
except NameError:
    bEc = True
g.f_text("? L isNot List  : %r" % bEc)
assert (bEc is True)

#   ===========================================================================
#   m:  create
#   ===========================================================================

g.f_menu("create")

#   s:  constructor
g.f_menuS1("construct")
L = list()
g.f_text("type(l)  : %s" % (type(L)))
assert (isinstance(L,list) is True)

#   s:  empty
g.f_menuS1("empty")
Lempty = []
bRc = isinstance(Lempty,list)
g.f_text("isList Lempty: %r" % bRc)

#   s:  annotated helper
Lnumber: list[int] = []
LRc: list[str] = []
g.f_text("LRc %s" % str(LRc))
r: list[str] = []


#   ===========================================================================
#   m:  init
#   ===========================================================================

g.f_menu("init")

#   s:  directly
g.f_menuS1("directly")
Li: list[int] = []
Li = [1,2,3]
g.f_text("bool(l)=%s" % bool(Li))          # False
g.f_text("type(l)=%s" % (type(Li)))  # class list
g.f_text("len(l)=%d" % (len(Li)))    # 3
assert (Li[0] == 1)
assert (len(Li) == 3)

#   s:  convertedBy Tuple
g.f_menuS1("create by Tuple")
T = ('hello','Python')
L = list(T)         # create a list
g.f_text("T      : %s" % str(T))
g.f_text("L.new  : %s" % str(L))
assert (L[0] == 'hello')

#   s:  mixed
g.f_menuS1("mixed List")
Lmixed = ['alpha','beta',True,'ceta','delta',123]
g.f_text("%s" % g.f_sList(Lmixed))
assert (Lmixed[2] is True)

#   ===========================================================================
#   m:  combound listComprehension
#   ===========================================================================
#   List comprehension offers a shorter syntax when you want
#       to create a new list based on the values of an existing list.
#   https://www.w3schools.com/python/python_lists_comprehension.asp

g.f_menu("combound listComprehension")

#   take all
LFruit = ["apple", "banana", "cherry", "kiwi", "mango"]
Ls = [x for x in LFruit if isinstance(x,str)]       # take only str
g.f_text("lFruit1 =:'%s'" % (Ls))
assert (Ls[2] == 'cherry')

#   take only Fruits with letter 'a'
Ls = [x for x in LFruit if "a" in x]
g.f_text("lFruit2 =:'%s'" % (Ls))     # ['apple', 'banana', 'mango']'
assert (Ls[2] == 'mango')

#   square all values in a list
LNumber5 = [1,2,3,4,5]
Li = [x**2 for x in LNumber5]
g.f_text("lValues =:'%s'" % (LNumber5))
g.f_text("lSquare =:'%s'" % (Li))     # [1, 4, 9, 16, 25]
assert (Li[2] == 9)

#   limit listSize
Li = [x for x in range(5) if (x < 3)]
g.f_text("lRange =:'%s'" % (Li))      # [0, 1, 2]
assert (Li[2] == 2)

#   change ListValues
Li = [i if i > 2 else -1 for i in range(5)]
g.f_text("lRange =:'%s'" % (Li))      # [-1, -1, -1, 3, 4]
assert (Li[2] == -1)

#   ===========================================================================
#   m:  modify
#   ===========================================================================

g.f_menu("list modify")

#   s:  add
g.f_menuS1("add")

#   add 1 element by l=l+x
i = 1
Li = []
Li = Li + [i]
g.f_text("l = l + %d \t=> %s" % (i,Li))
assert (Li[0] == 1)

#   add by l += x
i = 2
Li += [i]
g.f_text("l += %d \t=> %s" % (i,Li))
assert (Li[1] == 2)

#   add by l += x,y
i,j = 5,6
Li += [i,j]     # auch das geht
g.f_text("l += %d,%d \t=> %s" % (i,j,Li))
assert (Li[2] == 5)
assert (Li[3] == 6)

#   s:  sub
g.f_menuS1("sub")
L1 = [10707,90489,93215]
L2 = ['Antonia','Berta','Cleo']
L3 = [-10,-20,-30]
g.f_text("L1 \t=> %s" % (L1))
g.f_text("L2 \t=> %s" % (L2))
g.f_text("L3 \t=> %s" % (L3))

#   pack two lists
L = [L1,L2]
g.f_text("L \t=> %s" % (L))
iLen = len(L); g.f_text("len(L)=%d" % (len(L)))    # 2
assert (iLen == 2)
assert (L[0][1] == 90489)       # L= [ [a1,a2,23], [b1,b2,b3] ]
assert (L[1][1] == 'Berta')

#   add third list
L += L3
g.f_text("L \t=> %s" % (L))      # L= [ [a1,a2,23], [b1,b2,b3], c1,c2,c3 ]
iLen = len(L); g.f_text("len(L)=%d" % (len(L)))    # 5
assert (iLen == 5)
assert (L[4] == -30)


#   s:  concatenator

#   concatenation : with '+' or '+='
g.f_menuS1("concatenation")
L = []
L1 = ['red', 'green']
L2 = ['pink']
L3 = ['blue']

#   operation
L  = L1 + L2        # operator '+'
L += L3             # operator '+='
g.f_text("l=(%s+%s)+=%s\t=>%s" % (L1,L2,L3,g.f_sList(L,True)))
g.f_text("L =: %s" % str(L))    # L =: ['red', 'green', 'pink', 'blue']
assert (L[2] == 'pink')

#   s:  repeat
g.f_menuS1("repetition")

L = []
Li = [1,2,3]
n   = 2
L   = n * Li
g.f_text("with Lists: %d * %s \t=> <%s> " % (n,Li,L))  # <[1, 2, 3, 1, 2, 3]>
assert (L[1] == 2)
assert (L[4] == 2)

#   s:  unique&&sorted
g.f_menuS1("unique")
L = []
Li = [1,2,9,2,7,4,5,2,2,6,7,1,3]

g.f_text(("using l =: %s" % (Li)), g.C_COLOR_CYAN)

L   = list(dict.fromkeys(Li))
g.f_text("uniq   l =: %s" % (L))    # [1, 2, 9, 7, 4, 5, 6, 3]
assert (L[3] == 7)

L   = sorted(Li)
g.f_text("sorted l =: %s" % (L))   # [1, 1, 2, 2, 2, 2, 3, 4, 5, 6, 7, 7, 9]
assert (L[3] == 2)

#   ===========================================================================
#   m:  slicing
#   ===========================================================================

g.f_menu("list slicing")

L = ['a','b','c','d','e','f','g','h']
g.f_text("l = %s" % (L))

#   define list str return
r = []

#   s:  simpleSlice
g.f_menuS1("simple Slice")
s = L[0]
g.f_text("Slice l[0]    : %s" % r); assert (s[0] == 'a')    # a
r = L[1:3]
g.f_text("Slice l[1:3]  : %s" % r); assert (r[0] == 'b')    # ['b','c']
r = L[:3]
g.f_text("Slice l[:3]   : %s" % r); assert (r[0] == 'a')    # ['a','b','c']
r = L[:3:2]
g.f_text("Slice l[:3:2] : %s" % r); assert (r[1] == 'c')    # ['a','c']
r = L[:3:2]
g.f_text("Slice l[:3:2] : %s" % r); assert (r[1] == 'c')    # ['a','c']
r = L[6:1:-1]
g.f_text("Slice l[6:1:-1] : %s" % r); assert (r[0] == 'g')  # [g,f,e,d,c]

#   s:  objectSlice
g.f_menuS1("slicing with sliceObjects")

L = ['a','b','c','d','e','f','g','h','i','j']
g.f_text("l using = %s" % (L))  # ['a','b','c','d','e','f','g','h','i','j']

# Create a slice object attributes : ~.start, ~.stop, ~.step
iStart = 1
iStop = 8
iSkip = 2
pObj = slice(iStart, iStop, iSkip)

#   show
g.f_text("create tObj    = slicE(%d,%d,%d)"
    % (pObj.start,pObj.stop,pObj.step))
assert (pObj.start == iStart)
assert (pObj.stop == iStop)
assert (pObj.step == iSkip)

#  access
r = L[pObj.start:pObj.stop:pObj.step]
g.f_text("slicing l[tObj] \t=> %s" % (r))  # 'b', 'd', 'f', 'h',]
assert (r[1] == 'd')

#   ===========================================================================
#   m:  function
#   ===========================================================================

g.f_menu("list functions")

#   s:  sum - add all list members
g.f_menuS1("sum")
Li      = [1,2,3,4,5,6,7,8]
iSum    = sum(Li)
g.f_text("SUM(%s) \t=> <%d> " % (Li,iSum))   # 36
assert (iSum == 36)

#   s:  check.IN()
g.f_menuS1("check with IN")
L = ['a','b','c','d','e','f','g','h']
c = 'a'

#   check1
bRc     = (c in L)
g.f_text("IN(%s,%s) \t=> <%s> " % (c,L,bRc))
assert (bRc is True)

#   check2
c       = 'x'
bRc     = (c not in L)
g.f_text("not IN(%s,%s) \t=> <%s> " % (c,L,bRc))
assert (bRc is True)

#   s:  check.ALL()   : ? is 1 element of List L
g.f_menuS1("check with ALL")
b1,b2,b3 = True,False,True
bRc      = all([b1,b2,b3])
g.f_text("All(L) \t=> <%s> " % (bRc))
assert (bRc is False)

L = [1,True,1]
bRc      = all(L)
g.f_text("All(L=%s) \t=> <%s> " % (str(L),bRc))
assert (bRc is True)

#   s:  check.ANY()
g.f_menuS1("check with ANY")
#   any: Gibt es ein 'true' Element in der Liste ?
L = [1,False,1]
bRc      = any(L)
g.f_text("Any(L=%s) \t=> <%s> " % (str(L),bRc))
assert (bRc is True)

#   ===========================================================================
#   m:  method
#   ===========================================================================

g.f_menu("list methods")

L = ['a','b','c','d','e','f','g','h']
t = (1,2,3)
g.f_text("list L => %s" % (str(L)))
g.f_text("list T => %s" % (str(t)))
iLen = len(L); g.f_text("init len(L) => %d" % iLen)

#   define
L[0] = 'x'
g.f_text("l[0]=%d  \t=> %s" % (i,L))

#   s:  append       :: L.append()
L.append('x')
g.f_text("l.APPEND('x')   \t=> %s" % (L))
assert (len(L) == iLen + 1)

#   s:  pop          :: L.pop()
c = L.pop()
g.f_text("l.POP() = %s \t=> %s" % (c,L))
assert (len(L) == iLen)

i = 2
c = L.pop(i)
g.f_text("l.POP(%d) = %s  \t=> %s" % (i,c,L))
g.f_text("len(L) => %d" % len(L))
assert (len(L) == iLen - 1)

#   s:  extend       :: L.extend()
L.extend('y')
g.f_text("l.EXTEND(t=%s) \t=> %s" % (t,L))
assert (len(L) == iLen)

#   s:  remove       :: L.remove()
c = 'e'
L.remove(c)
g.f_text("l.REMOVE('%s') \t=> %s" % (c,L))
assert (len(L) == iLen - 1)

#   s:  insert       :: L.insert()
i = 2
c = 'xyz'
L.insert(i,c)
g.f_text("l.INSERT(%d,%s) \t=> %s" % (i,c,L))

#
#   s:  count       ::   iRc = L.count('c')
#

g.f_menuS1("count elements")
Li = [1,5,7,1,3,76,9,5,4,33,2,9,1,2,7,2,1,4]
g.f_text("l \t=> %s" % (Li))

#   how often is '1' in the list l
i = 1
iRc = Li.count(i)
g.f_text("l.COUNT(%d) \t=> %d" % (i,iRc))       # 4
assert (iRc == 4)

i = 2
iRc = Li.count(i)
g.f_text("l.COUNT(%d) \t=> %d" % (i,iRc))       # 3
assert (iRc == 3)

i = 7
iRc = Li.count(i)
g.f_text("l.COUNT(%d) \t=> %d" % (i,iRc))       # 2
assert (iRc == 2)

i = 6
iRc = Li.count(6)
g.f_text("l.COUNT(%d) \t=> %d" % (i,iRc))       # 0
assert (iRc == 0)

#
#   s:  index        ::   iPos = L.index('c')
#

g.f_menuS2("get index")
i = 7
Li = [1,5,7,1,3,76,9,5,4,33,2,9,1,2,7,2,1,4]
g.f_text("l \t=> %s" % (Li))

iVal = 7
iRc  = Li.index(iVal)
g.f_text("l.Index(%d) \t=> %d" % (iVal,iRc))     # 2
assert (iRc == 2)

iVal = 4
iRc  = Li.index(iVal)
g.f_text("l.Index(%d) \t=> %d" % (iVal,iRc))    # 8
assert (iRc == 8)

iVal = 76
iRc  = Li.index(iVal)
g.f_text("l.Index(%d) \t=> %d" % (iVal,iRc))    # 5
assert (iRc == 5)

iVal,iBeg,iEnd = 3,1,10
iRc  = Li.index(iVal,iBeg,iEnd)
g.f_text("l.Index(%d,fo=%d,to=%d) \t=> %d" % (iVal,iBeg,iEnd,iRc))  # 4
assert (iRc == 4)

iVal,iBeg = 3,5
iRc = -1
sEc = "oK"
bEc = False
try:
    iRc  = Li.index(iVal,iBeg)
except Exception as e:
    bEc = True
    sEc = str(e)
    iRc = -9
g.f_text("l.Index(%d,fo=%d) \t=> iRc=<%d> sEc=<%s>" % (iVal,iBeg,iRc,sEc))
assert (bEc is True)
assert (iRc == -9)

#   u:  insert
g.f_menuS2("insert")
iVal = -3
i = 5
Li = [1, 5, 7, 1, 3, 76, 9, 5]
Li.insert(i,iVal)
g.f_text("l.Insert(%d,f=%.1f) \t=> l=<%s> " % (i,iVal,Li))
assert (Li[5] == iVal)

#   ===========================================================================
#   m:  sort.advanced
#   ===========================================================================

g.f_menu("sort list for advanced")

L   = [1,5,7,1,3,76,9,5,4,33,2,9,1,2,7,2,1,4]   # numbers
g.f_text("using L = <%s> " % (L))

#   s:  byFunction
g.f_menuS1("sort by function")

LRc = sorted(L)
g.f_text("sorted(L) =: <%s>" % str(LRc))

#   different memory address ?
g.f_text("mem(L)    =: <%X>" % id(L))
g.f_text("mem(LRc)  =: <%X>" % id(LRc))
assert (id(L) != id(LRc))

#   s:  byMethod
g.f_menuS1("sort by method")

L.sort()
g.f_text("L.sort()  =: <%s>" % str(L))

L.sort(reverse=True)
g.f_text("L.sort(reverse) =: <%s>" % str(L))

#   === :footer
g.f_footer(sTc)

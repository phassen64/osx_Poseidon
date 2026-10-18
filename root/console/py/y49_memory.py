#   ***************************************************************************
#   My Python Tutorial  ::  memory !CRQ-240320:Py+
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   url
#   +   https://www.geeksforgeeks.org/mutable-vs-immutable-objects-in-python/
#   +   https://www.geeksforgeeks.org/inplace-vs-standard-operators-python/

#   --  InPlace :
#       InputObject changes after leaving a function
#       void quad(int *x) { *x ** 2 }
#       main() {int x=3; quad(x); } # x == 6

'''
    !content
        m:  memoryAddress(<var>)
        m:  reference to var
        m:  (im)mutability
        m:  InPlace
            s:  square
            s:  add
            s:  concat
        m:  Copy:ShallowVsDeep
            s:  direct
            s:  shallowCopy
            s:  deepCopy
'''


#   === :header
import sys
assert sys.version_info >= (3,9)
import copy     # shallow
import LIB_inc as m;    g = m.CLib();   sTc = 'tcMemory'
g.f_header(sTc)


#   ===========================================================================
#   m:  memoryAddress(<var>)
#   ===========================================================================

#
#
#   Python legt nach dem Starten bereits diverse
#       Variablen an.
#   +   Variablen der Datentypen { int, bool, None } werden
#       bevorzugt auf gleiche Speicherstellen gelegt.
#       Andere Datentypen werden woanders hingelegt
#   +   Listen hingegen bekommen immer andere Adressen
#

g.f_menu("memoryAddress")

#   integer
g.f_menuS1("mem(&integer)")
i   = 47
j   = 47
k   = 815
g.f_text("memAddress(i=%d) \t =: %04x" % (i,id(i)))
g.f_text("memAddress(j=%d) \t =: %04x" % (j,id(j)))  # &i == &j
g.f_text("memAddress(k=%d) \t =: %04x" % (k,id(k)))  # andere

#   bool
g.f_menuS1("mem(&bool)")
b1  = True
b2  = True
b3  = False
k   = 815
g.f_text("memAddress(b1=%r) \t =: %04x" % (b1,id(b1)))
g.f_text("memAddress(b2=%r) \t =: %04x" % (b2,id(b2)))  # =: b2
g.f_text("memAddress(b3=%r) \t =: %04x" % (b3,id(b3)))

#   None
g.f_menuS1("mem(None)")
n1  = None
n2  = None
g.f_text("memAddress(n1=%r) \t =: %04x" % (n1,id(n1)))
g.f_text("memAddress(n2=%r) \t =: %04x" % (n2,id(n2)))  # =: b2

#   List
g.f_menuS1("mem(List)")
l1  = ["a",2,"c"]
l2  = ["a",2,"c"]
g.f_text("memAddress(l1=%s) \t =: %04x" % (l1,id(l1)))
g.f_text("memAddress(l2=%s) \t =: %04x" % (l2,id(l2)))  # &l1 != &l2

#   ===========================================================================
#   m:  reference
#   ===========================================================================

#   Python versucht Speicherplatz zu sparen.
#   Bei Zuweisung einer Variablen zu einer
#       anderen, werden i.d.R. nur Referenzen verwendet-

g.f_menu("reference")

l1  = ["a",2,"c"]
l2  = l1
g.f_text("List l1='%s' &l1 \t =: %04x" % (l1,id(l1)))
g.f_text("List l2='%s' &l2 \t =: %04x" % (l2,id(l2)))   # &l1 == &l2

#   ===========================================================================
#   m:  (im)mutability
#   ===========================================================================

#   dataType
#   +   immutable   : { int, float, bool, str, tuple }
#   +   mutable     : { list, dict, set ... }

#   immutable :
#       variables corresponds to their <value>
#           and not to their <name>
#   mutable :
#       variables corresponds to their <name> only


g.f_menu("mutability")

#

#   s:  immutable
g.f_menuS1("immutable")

#   --- int
i   = 22
g.f_text("mem1(i=%d) \t =: %04x" % (i,id(i)))
i   = 33      # value different
g.f_text("mem2(i=%d) \t =: %04x" % (i,id(i)))   # mem2 != mem1

#   --- float
f   = 3.14
g.f_text("mem1(f=%f) \t =: %04x" % (f,id(f)))
f   = 6.28
g.f_text("mem2(f=%f) \t =: %04x" % (f,id(f)))   # mem2 != mem1

#   --- string
s   = "Peter"
g.f_text("mem1(s=%s) \t =: %04x" % (s,id(f)))
s   = "Harvey"    # other string => other memory
g.f_text("mem2(s=%s) \t =: %04x" % (s,id(f)))   # mem2 != mem1

#   s:  mutable
g.f_menuS1("mutable")
l = [1,2,3]
g.f_text("mem1(l=%s) \t =: %04x" % (l,id(l)))
l += [7]
g.f_text("mem2(l=%s) \t =: %04x" % (l,id(l)))   # mem2 == mem1

#   ===========================================================================
#   m:  InPlace
#   ===========================================================================

g.f_menu("InPlace")

def f_sqrList(l:list[int]) -> list[int]:
    l = [x**2 for x in l]
    return l        # local variable

#   NOK
def f_addList(l:list[int],i:int) -> None:
    for x in l:
        x = x + i

#   OK
def f_addList_inplace(l:list[int],i:int) -> None:
    for x in range(len(l)):
        l[x] = l[x] + i     # access direct

#   OK
def f_concatList(l1:list,l2:list) -> None:
    l1 += l2


#   define my list
L = [10,20,30]
g.f_text("L  =: %s" % (L))

#   store addess
iMem1 = id(L)
g.f_text("mem1:= &L =: %04x" % (iMem1))

#
#   s:  square
#
g.f_menuS1("sqrList")

#   using sqr
f_sqrList(L)                # L=[10,20,30] * unchanged !
g.f_text("L := %s" % (L))

#   using sqr with return
LTmp = f_sqrList(L)         # LTmp=[15,25,35] * only lTmp
g.f_text("LTmp := %s" % (LTmp))

#
#   s:  add
#

#   using add
g.f_menuS1("addList")
f_addList(L,5)
g.f_text("L := %s" % (L))   # L=[10,20,30] * unchanged !

#   using add.inplace
g.f_menuS1("addList.Inplace")
f_addList_inplace(L,5)
g.f_text("L := %s" % (L))   # L=[15,25,35]  * changed

#   Memory address unchanged ?
iMem2 = id(L)
g.f_text("mem1:= &L =: %04x" % (iMem2))
assert (iMem1 == iMem2)
g.f_text("mem(L1) == mem(L2)")

#
#   s:  concat
#
g.f_menuS1("concat with +=")

L       = [10,20,30]
LTmp    = ['Ernie','Bert']
g.f_text("L     =: %s" % (L))
g.f_text("LTmp  =: %s" % (LTmp))

f_concatList(L,LTmp)
g.f_text("L := %s" % (L))   # L = [10, 20, 30, 'Ernie', 'Bert']

iMem2 = id(L)


#   ===========================================================================
#   m:  Copy:ShallowVsDeep
#   ===========================================================================
#   eng:shallow deu:flach

g.f_menu("ShallowCopy vs DeepCopy")

L       = [[1, -2], [3, -4]]
g.f_text("L := %s \t =: %s" % (L,hex(id(L))))

#
#   s:direct
#

g.f_menuS1("direct")
LTmp    = L
g.f_text("LTmp = %s \t =: %04x" % (LTmp,id(LTmp)))     # same Object

#
#   s:shallowCopy
#

g.f_menuS1("copy")
LTmp    = copy.copy(L)
g.f_text("LTmp = %s \t =: %04x" % (LTmp,id(LTmp)))

#   change tmpList changes original List
i,j,x = 0,0,31
g.f_puts("\t--- change LTmp[%d][%d] := %d" % (i,j,x))
LTmp[i][j] = x
g.f_text("LTmp  = %s" % LTmp)   # [[31, -2], [3, -4]]

#   show original object
g.f_text("L     = %s" % L)      # [[31, -2], [3, -4]]

#
#   s:  deepCopy
#

g.f_menuS1("deepCopy")

L       = [[1, -2], [3, -4]]
g.f_text("L := %s \t =: %s" % (L,hex(id(L))))

#   doCopy
LTmp    = copy.deepcopy(L)
g.f_text("LTmp = %s" % (LTmp))

#   change
i,j,x = 0,0,31
LTmp[i][j] = x
g.f_puts("\t--- change LTmp[%d][%d] := %d" % (i,j,x))
g.f_text("LTmp = %s" % (LTmp))

#   show original object
g.f_text("L    = %s" % (L))

#   === :footer
g.f_footer(sTc)

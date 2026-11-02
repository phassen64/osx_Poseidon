#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   ***************************************************************************
#   My Python Tutorial  :: set
#   ***************************************************************************
#   url: https://www.w3schools.com/python/python_sets.asp
#   Sets are used to store multiple items in a single variable.
#   REMARK: The oldest implementation of data collection -
#           like C-enums
#   REMARK:
#           A set can contain different data types.
#   REMARK:
#       use as short the 'e' instead of 's' using by strings
#   •   Unordered
#       Sets are unordered,
#       so you cannot be sure in which order the items will appear !
#   •   Unchangeable
#       Set items are unchangeable,
#       meaning that we cannot change the items after the set has been created.
#       If the set is not a
#               Frozenset
#       you can remove items and add new items.
#   •   NoDuplicates possible


'''
    !content:
        m:  create
            s:  homogen
            s:  mixed
            s:  duplicates
        m:  functions
            s:  constructor
            s:  getLength
            s:  getType
            s:  getItems
            s:  test with 'in'
        m:  frozenSet
        m:  converted
            s:  E:=set(L)
            s:  E:=set(T)
        m:  methods
            s:  copy
            s:  clear
            s:  add
            s:  add.frozen
            s:  discard
            s:  remove
            s:  pop
            s:  update
            s:  union
            s:  difference
            s:  intersection
            s:  isdisjoint?
            s:  issubset?
            s:  issuperset?

    !keyword:
        set len type frozenset
'''


#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'TcSet'
g.f_header(sTc)

#   ===========================================================================
#   m:  create
#   ===========================================================================

g.f_menu("create")

#   s:  homogen
eCity = {'Hamburg','Muenchen','Berlin','Frankfurt'}
g.f_text("eCity:=%s" % eCity)

#   s:  mixed
eFruit = {5.13, "apple", "banana", "cherry", 4711, complex(2,-3)}
g.f_text("eFruit:=%s" % eFruit)

#   s:  duplicates
eNumber = {1, 2, 3}
g.f_text("eNumber:=%s" % eNumber)
#   <<< 1,2,3

#   ===========================================================================
#   m:  functions
#   ===========================================================================

#   s:  constructor set()
g.f_menuS1("constructor")
tPerson = ("Peter", "Nürnberg", 90489)
ePerson = set(tPerson)     # remark: NOT set({...})
g.f_text("ePerson:=%s" % ePerson)

#   s:  getLength
g.f_menuS1("getLenght")
iLen = len(eFruit)
g.f_text("len(eFruit) : <%d>" % (iLen))

#   s:  getType
g.f_menuS1("getType")
sType = type(eFruit)
g.f_text("type(eFruit) : <%s>" % (sType))

#   s:  getItems
g.f_menuS1("getItems")
i = 0
for x in eFruit:
    print("\t<<< eFruit[%d]:%s" % (i,x))
    i += 1

#   s:  test with 'in'
iVal = 90489
bRc = iVal in ePerson
g.f_text("? is '%s' in ePerson = %r" % (str(iVal),bRc))
assert (bRc is True)

#   ===========================================================================
#   m:  frozenSet
#   ===========================================================================

g.f_menu("frozenset")

lClub = ['Bayern','Dortmund','Wolfsburg']
g.f_text("use l := %s" % lClub)

#   s:  use frozenSet
g.f_menuS1("use frozenset function")
ezClub = frozenset(lClub)
g.f_text("ez=frozenSet(l): %s" % (ezClub))
g.f_text("Type(ez): %s" % (type(ezClub)))

#   ===========================================================================
#   m:  converted via other dataType
#   ===========================================================================

g.f_menu("convertedBy")

sRc = g.f_sSet(eCity)
g.f_text("test f_sSet(eCity) = %s" % (sRc))

bRc = 'Berlin' in eCity
sRc = g.f_sBool(bRc)
g.f_text("Berlin in eCity = %s" % (sRc))

#
#   s:  E:=set(L)   : convert list into set
#

g.f_menuS1("set <= list")
l = ['Antonia','Berta','Cleo',4711,'Elvira','Frauke','Gerlinde']
e = set(l)

#   show
g.f_text("show(l)    : %s" % (g.f_sList(l)))
g.f_text("e = Set(l) : %s" % (l))
g.f_text("show(e)    : %s" % (g.f_sSet(e)))
g.f_text("Type(e)    : %s" % (type(e)))

#
#   s:  E:=set(T)   : convert tuple into set
#

g.f_menuS1("set <= tuple")
t = ('alpha','beta','ceta')     # Tupel koennten doppelte Elemente enthalten

e = set(t)
g.f_text("show(t)    : %s" % (g.f_sTuple(t)))
g.f_text("e = Set(t) : %s" % (e))
g.f_text("Type(e)    : %s" % (type(e)))

#   REM: Nur die Ausgangs-Komponenten sind mixed, der set selbst
#       darf nicht indiziert werden, also s[0] ergibt einen Fehler


#   ===========================================================================
#   m:  methods
#   ===========================================================================

g.f_menu("using methods")

g.f_text("eCity=%s(Len=%d)" % (eCity,len(eCity)))

#
#   init
#

eName   = {'Albert','Bert','William'}
g.f_text("eName     := %s" % eName)
eCity   = {'Munic','Hamburg','NewYork'}
g.f_text("eCity     := %s" % eCity)
ezColor = frozenset({'red','yellow','green'})
g.f_text("ezColor   := %s" % ezColor)

#
#   s:  copy     ::  e2 := e1.copy()
#

g.f_menuS1("copy")
eTmp = eCity    # is only a link !
eTmp = eCity.copy()
g.f_text("eTmp=eCity.copy() = %s" % (eTmp))

#   test
bRc = 'Munic' in eTmp; assert (bRc is True)

#
#   s:  clear    :: e.clear()
#

g.f_menuS1("clear")
g.f_text("show eTmp      = %s"   % (eTmp))

eTmp.clear()

g.f_text("eTmp.clear()   => eTmp=<%s>"    % (eTmp))
g.f_text("eCity          => eCity=<%s>"   % (eCity))    # unchanged

#
#   s:  add      :: e.add(x)
#

g.f_menuS1("add")

g.f_text("eName %s" % (eName))
g.f_text("eCity %s" % (eCity))

x = 'Elizabeth'
eName.add(x)
g.f_text("eName.add<%s> => %s(Len=%d)" % (x,eName,len(eName)))
bRc = x in eName; assert (bRc is True)

x = 'LasVegas'
eCity.add(x)
g.f_text("eCity.add<%s>: %s(Len=%d)"    % (x,eCity,len(eCity)))
bRc = x in eCity; assert (bRc is True)

#
#   s:  add.frozen
#

g.f_menuS1("add.frozen")

bEc = False
sCol = 'white'
try:
    ezColor.add(sCol)
except AttributeError:
    bEc = True
    sEc = "!EXC:AttributeError"
except Exception:
    sEc = "!EXC:any Exception"

assert (bEc is True)
bRc = sCol in ezColor; assert (bRc is False)  # not added !
g.f_text("ezColor<%s>.add('%s') =: %s" % (ezColor,sCol,sEc), g.C_COLOR_YELLOW)

#
#   s:  discard      ::  e.discard(c) * remove an element
#

g.f_menuS1("discard")
e = {'A','B','C','D','E','F','G','H'}
g.f_text("show(e): %s(Len=%d)" % (e,len(e)))

x = 'F'
e.discard(x)
g.f_text("e.discard(%s) 1x: %s(Len=%d)" % (x,e,len(e)))
bRc = x in e; assert (bRc is False)

e.discard(x)      # 2.discard  has no effect
g.f_text("e.discard(F) 2x: %s(Len=%d)" % (e,len(e)))

#
#   s:  remove       :: e.remove(c)
#

g.f_menuS1("remove")
e = {'A','B','C','D','E','F','G','H'}
g.f_text("show(e): %s(Len=%d)" % (e,len(e)))

x = 'F'
e.remove(x)
g.f_text("e.remove(F) 1x: %s(Len=%d)" % (e,len(e)))
bRc = x in e; assert (bRc is False)

#   exception if no element
sRc = '?'
bEc = False
try:
    g.f_text("try e.remove(F) ...")
    e.remove(x)
except KeyError:
    bEc = True
    sEc = "!EXC:KeyError"
except Exception:
    sEc = "!EXC:any Exception"

assert (bEc is True)
g.f_text(("e.remove(F) 2x: rc=%s,ec=%s" % (sRc,sEc)),g.C_COLOR_YELLOW)

#
#   s:  pop          :: x := e.pop()
#

g.f_menuS1("pop")
e = {'A','B','C','D','E','F','G','H'}
g.f_text("show(e): %s(Len=%d)" % (e,len(e)))

x  = e.pop()
g.f_text("x=e.pop() = %s" % (x))
g.f_text("show(e.new): %s(Len=%d)" % (e,len(e)))

#   error with empty list
g.f_menuS2("generate error with empty list")
e.clear()   # empty list
g.f_text("e.clear => e=:<%s>,len(e)=:<%d>" % (str(e),len(e)))
sRc = '?'
sEc = '?e'
bEc = False
try:
    sRc = e.pop()
except Exception as x:
    bEc = True
    sEc = "EXC:["
    sEc += format(str(x))
    sEc += "]"
g.f_text("s.pop() rc=%s,ec=%s" % (sRc,sEc), g.C_COLOR_YELLOW)
assert (bEc is True)

#
#   s:  update       ::  e1.update(e2)
#

g.f_menuS1("update")
eLetter = {"a", "b", "c"}
eDigit  = {1, 2, 3}
g.f_text("eLetter :%s" % (eLetter))
g.f_text("eDigit  :%s" % (eDigit))
eLetter.update(eDigit)
g.f_text("eLetter.update(eDigit) => %s" % (eLetter))

#
#   s:  union        ::  e = e1.union(e2)
#

g.f_menuS1("union")

ePerson = {"Peter", "Nürnberg", 90489}
eFruit  = {5.13, "apple", "banana", "cherry", 4711, complex(2,-3)}
g.f_text("ePerson   :%s" % (ePerson))
g.f_text("eFruit    :%s" % (eFruit))

g.f_menuS1("different types")
e = eFruit.union(ePerson)
g.f_text("eFruit.union(ePerson)     \n\t:%s" % (e))

g.f_menuS1("duplicates")
eDigit1 = {1,2,3,4,5}
eDigit2 = {6,2,1,7,8}
g.f_text("eDigit1    :%s" % (eDigit1))
g.f_text("eDigit2    :%s" % (eDigit2))
e = eDigit1.union(eDigit2)
g.f_text("eDigit1.union(eDigit2)    :%s" % (e))


#
#   s:  difference   :: x := e1.difference(e2); e1>e2
#

g.f_menuS1("difference")
eTmp = eCity.copy()
eCity.add("Miami")
eCity.add("Chicago")
g.f_text("show(eCity): %s(Len=%d)" % (eCity,len(eCity)))
g.f_text("show(eTmp) : %s(Len=%d)" % (eTmp,len(eTmp)))
sRc = eCity.difference(eTmp)     # e2>e1
g.f_text("eCity.difference.eTmp =: '%s'" % (sRc))

#
#   s:intersection ::  e1.intersection(e2)
#

g.f_menuS1("intersection")
e = {'A','B','C','D','E','F','G','H'}
x = {'C','D'}

eTmp = e.copy()
eRc  = eTmp.intersection(x)     # eTmp not changed

g.f_text("show(e): %s(Len=%d)" % (e,len(e)))
g.f_text("show(x): %s(Len=%d)" % (x,len(x)))
g.f_text("eRc=s.interSection(x) => %s(Len=%d),(Type=%s)"
         % (eRc,len(eRc),type(eRc)))

assert (e == eTmp)
if e == eTmp:
    g.f_text("?(e is Unchanged) =: true",g.C_COLOR_MAGENTA)


#
#   s:  isdisjoint?  : Schnittmenge ist leer ?
#

g.f_menuS1("isdisjoint")
e = {'A','B','C','D','E','F','G','H'}
x = {'1','2'}
eTmp = e.copy()
bRc  = eTmp.isdisjoint(x)

g.f_text("show(e): %s(Len=%d)" % (e,len(e)))
g.f_text("show(x): %s(Len=%d)" % (x,len(x)))
g.f_text("bRc=s.disJoint(x) = %s" % (g.f_sBool(bRc)))
assert (bRc is True)


#
#   s:  issubset?    : Untermenge?
#

g.f_menuS1("issubset")
e = {'A','B','C','D','E','F','G','H'}
x = {'B','H'}
eTmp  = e.copy()
bRc1  = e.issubset(x)
bRc2  = x.issubset(e)
assert (bRc1 is False)
assert (bRc2 is True)

g.f_text("show(e): %s(Len=%d)" % (e,len(e)))
g.f_text("show(x): %s(Len=%d)" % (x,len(x)))
g.f_text("bRc=e.isSubSet(x) =: %r" % (bRc1))
g.f_text("bRc=x.isSubSet(e) =: %r" % (bRc2))

#
#   s:  issuperset?  : Obermenge?
#

g.f_menuS1("issuperset")
e = {'A','B','C','D','E','F','G','H'}
x = {'B','H'}

eTmp  = e.copy()
bRc1  = e.issuperset(x)
bRc2  = x.issuperset(e)
assert (bRc1 is True)
assert (bRc2 is False)

g.f_text("show(e): %s(Len=%d)" % (e,len(e)))
g.f_text("show(x): %s(Len=%d)" % (x,len(x)))
g.f_text("bRc=e.isSuperSet(x) =: %r" % (bRc1))
g.f_text("bRc=x.isSuperSet(e) =: %r" % (bRc2))

#   === :footer
g.f_footer(sTc)

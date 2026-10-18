#   ***************************************************************************
#   My Python Tutorial  :: tuple
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   Tuples are used to store mulTnumberple items in a single variable.
#   A tuple is a collecTnumberon which is ordered and unchangeable.
#   --- url:
#   https://www.w3schools.com/python/python_tuples.asp
#   https://www.programiz.com/python-programming/list-vs-tuples

'''
    !content:
        m:  define
        m:  create
            s:  constructor
            s:  empty
            s:  annotated
        m:  init
            s:  directly
            s:  convertedBy List
            s:  mixed
            s:  init with 1 element
        m:  add
            s:  tPlanet
            s:  tNumber
        m:  check
            s:  check.Len
            s:  check.Size
            s:  check.Type
        m:  concatenate     t = t1+t2
        m:  show
            s:  all
            s:  T[i+]
            s:  T[-i]
        m:  slice ':'
            s:  slice[i]
            s:  slice[i:j]  i...j-1
            s:  slice[:i]   0...i-1
            s:  slice[i:]   i...max
        m:  packing&unpacking
        m:  modify - fails
        m:  method
            s:  count         count 'c' in t
            s:  index         first index of 'c' in t

    !key:
        k   :__sizeof__

    !funcTnumberon:
        f:  len()
        f:  type()
'''

#   === :header
import LIB_inc as m; g = m.CLib(); sTc = 'TcSequences'
g.f_header(sTc)

#
#   m:  define  - no Object
#

g.f_menu("define only")
T: tuple[str]         # annotated define
bEc = False
sRc = '?'
try:
    sRc = T[0]
except NameError:
    bEc = True
g.f_text("? T isNot Tuple  : %r" % bEc)
assert (bEc is True)

#
#   m:  create
#

g.f_menu("create")

#   s:  constructor
g.f_menuS1("construct")
T = tuple()
g.f_text("type(t)  : %s" % (type(T)))
assert (isinstance(T,tuple) is True)

#   s:  empty
g.f_menuS1("empty")
Tempty = ()
bRc = isinstance(Tempty,tuple)
g.f_text("isTuple(Tempty: %r" % bRc)

#   s:  annotated
g.f_menuS1("annotated")
Tletter: tuple[str] = ()
Tnumber: tuple[int] = ()
bRc1 = isinstance(Tletter,tuple)
bRc2 = isinstance(Tnumber,tuple)
g.f_text("isTuple(Tletter): %r" % bRc1)
g.f_text("isTuple(Tnumber): %r" % bRc2)
assert (bRc1 is True)
assert (bRc2 is True)

#
#   m:  init
#

g.f_menu("init")

#   s:  directly
Tfruit = ("apple", "banana", "cherry")
g.f_text("t.ini     : %s" % (str(Tfruit)))
g.f_text("tYpe  t.ini   : %s" % (type(Tfruit)))
assert (Tfruit[0] == 'apple')

#   s:  convertedBy List
g.f_menuS1("create by List")
L = ['hello','DuDa']
T = tuple(L)        # create a tuple - list=>tuple
g.f_text("L      : %s" % (L))
g.f_text("T.new  : %s" % (str(T)))
assert (T[0] == 'hello')

#   s:  mixed
g.f_menuS1("mixed Tupel")
Tmixed = ('alpha','beta',True,'ceta','delta',123)
g.f_text("%s" % g.f_sTuple(Tmixed))
assert (Tmixed[2] is True)

#   s:  init with 1 element
g.f_menuS1("init 1 element")
Tnumber = (123,)
g.f_text("t        : %s" % (str(Tnumber)))
g.f_text("type(t)  : %s" % (type(Tnumber)))
g.f_text("len(t)   : %d" % (len(Tnumber)))
i = 0
for x in Tnumber:
    g.f_text("t[%d] : %s" % (i,str(x)))     # t[0]=123
assert (Tnumber[0] == 123)

#
#   m:  add
#

g.f_menu("add")

#   s:  tPlanet
g.f_menuS1("tPlanet")
T  = ('Sun',)           # tuple with 1 element
T += ('Earth',)
T += ('Moon',)
T += ('Jupiter',)
g.f_text("t.add         : %s" % (str(T)))
g.f_text("tYpe t.add    : %s" % (type(T)))
assert (T[0] == 'Sun')
assert (T[2] == 'Moon')
assert (T[3] == 'Jupiter')

#   s:  tNumber
g.f_menuS1("Tnumber")
T = tuple()         # empty
T = T + (4,)        # and 1 Element
g.f_text("t.add1    : %s" % (T))
g.f_text("Type(t)   : %s" % (type(T)))
T += T + (5,)        # and 2 Element
g.f_text("t.add2    : %s" % (g.f_sTuple(T)))
assert (T[0] == 4)
assert (T[1] == 4)
assert (T[2] == 5)
#
#   m:  check
#

g.f_menu("check")
Tmixeded = ('alpha','beta',True,'ceta','delta',123)
g.f_text("t =:'%s'" % str(Tmixeded))

#   s:  check.Size
g.f_menuS1("check.sizeof")
g.f_text('t.sizeof=%s' % Tmixeded.__sizeof__())

#   s:  check.Len : number of elements
g.f_menuS1("check.len")
iLen = len(Tmixeded)
g.f_text("len(t)     : %d" % iLen)      # => 6
assert (iLen == 6)

#   s:  check.Type
g.f_menuS1("check.type")
g.f_text("tYpe  t[1] : %s" % (type(Tmixeded[1])))  # str
g.f_text("tYpe  t[2] : %s" % (type(Tmixeded[2])))  # bool
g.f_text("tYpe  t[5] : %s" % (type(Tmixeded[5])))  # int
assert (isinstance(Tmixeded[1],str) is True)
assert (isinstance(Tmixeded[2],bool) is True)
assert (isinstance(Tmixeded[5],int) is True)

#
#   m:  concatenate
#

g.f_menu("concatenate")

Tnumber = (1,2,3)
Tletter = ('a','b','c')
T = Tnumber + Tletter

g.f_text("t1 : %s" % (str(Tnumber)))
g.f_text("t2 : %s" % (str(Tletter)))
g.f_text("T=t1+t2 : %s" % (str(T)))
assert (T[0] == 1)
assert (T[3] == 'a')

#
#   m:  show
#

g.f_menu("show")

Tfruit = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
g.f_text("Tfruit    : %s" % (str(Tfruit)))

#   s:  all - show all
g.f_menuS1("show.all")
i = 0
for x in Tfruit:
    g.f_text("Tfruit[%d] : %s" % (i,str(x)))
    i += 1
assert (Tfruit[4] == 'kiwi')

#   s:  T[i+]   : show with positive index
g.f_menuS1("show.index")
i   = len(Tfruit) // 2  # DIV 2 == 3
x   = Tfruit[i]
g.f_text("Tfruit[%d] => %s" % (i,str(x)))
assert (Tfruit[i] == 'orange')

#   s:  T[-i]   :  show with negative index
i   = -1
x   = Tfruit[i]
g.f_text("Tfruit[%d] => %s" % (i,str(x)))    # mango
assert (Tfruit[i] == 'mango')

#
#   m:  slice ':'    * slice-operator=':'
#

g.f_menu("slice")

Tletter = ('a','b','c','d','e','f','g','h')
g.f_text("Tletter : %s" % (str(Tletter)))

#   s:  slice[i]    i
i   = 3
T   = Tletter[i]
g.f_text("Tletter[%d] => %s" % (i,str(T)))          # d
iLen = len(T)
assert (T[0] == 'd')
assert (iLen == 1)

#   s:  slice[i:j]  i...j-1
i,j = 2,5
T   = Tletter[i:j]
g.f_text("Tletter[%d,%d] => %s" % (i,j,str(T)))     # c,d,e
assert (T[0] == 'c')
assert (T[1] == 'd')
assert (T[2] == 'e')
assert (len(T) == (j - i))

#   s:  slice[:i]   0...i-1
i = 4
T   = Tletter[:i]
g.f_text("Tletter[:%d] => %s" % (i,str(T)))         # a,b,c,d
assert (T[0] == 'a')
assert (T[3] == 'd')
assert (len(T) == i)

#   s:  slice[i:]   i...MAX
i = 4
T   = Tletter[i:]
g.f_text("Tletter[%d:] => %s" % (i,str(T)))         # e,f,g,h
assert (T[0] == 'e')
assert (T[3] == 'h')
assert (len(T) == 4)

#
#   m:  packing&unpacking
#

g.f_menu("packing && unpacking")

g.f_menuS1("unpacking")

Tmixed = ('alpha',3.14,True,123)
g.f_text("Tmixed  : %s" % (str(Tmixed)))

#   simple unpack mixed tuple
s,f,b,i = Tmixed
g.f_text("A:: s=%s; f=%f; b=%r; i=%d" % (s,f,b,i))
#   <<< s=alpha; f=3.140000; b=True; i=123
assert (s == 'alpha')
assert (f == 3.14)
assert (b is True)
assert (i == 123)

#   don't unpack all params
s,_,_,i = Tmixed
g.f_text("B:: s=%s; i=%d" % (s,i))  # s=alpha; i=123
assert (s == 'alpha')
assert (i == 123)

#   we need only the first 2 params
#   save into further tuple
g.f_menuS1("packing")
s,f,*TmixedEnd = Tmixed
g.f_text("C:: s=%s; f=%f" % (s,f))              # s=alpha; f=3.140000
g.f_text("TmixedEnd  : %s" % (str(TmixedEnd)))  # [True, 123]
assert (s == 'alpha')
assert (f == 3.14)
assert (TmixedEnd[0] is True)
assert (TmixedEnd[1] == 123)

#
#   m:  modify --- not allowed with tuples
#

#   rem: no direct access like
#       ... Tfruit[0] = 'Bismark'   => error

#
#   m:  method
#

g.f_menu("method")
Tprint      = (1,2,'$',4,5,'$',7,8,9,'$')
g.f_text("Tprint    : %s" % (str(Tprint)))

#   s:  count
#   The count() method returns the number of x in tuple T

c = '$'
iNumber = Tprint.count(c)
g.f_text("t.count('%c') =: %d" % (c,iNumber))  # 3
assert (iNumber == 3)

#   s:  index
#        at which X occurs first in the pattern
iIndex = Tprint.index(c)
g.f_text("t.index('%c') =: %d" % (c,iIndex))   # 2
assert (iIndex == 2)

#   === :footer
g.f_footer(sTc)

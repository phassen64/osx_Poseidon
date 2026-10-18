#   ***************************************************************************
#   My Python Tutorial  ::array
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   Arrays in Python sind Listen mit Elementen gleichen Typs.

'''
    !content:
        m:  define
        m:  access
            s:  accessByIndex
            s:  insertByIndex
        m:  method
            s:  m.append
            s:  m.insert
            s:  m.extend
            s:  m.fromlist
            s:  m.remove
            s:  m.pop
            s:  m.index
            s:  m.reverse
            s:  m.count

    !key:
    !function:
        f:array()
        f:type()
        f:len()
        f:str()
'''

#   http://www.thegeekstuff.com/2013/08/python-array/
#   b -> Represents signed integer of size 1 byte
#   B -> Represents unsigned integer of size 1 byte
#   c -> Represents character of size 1 byte   # ?PHA:removed?
#   u -> Represents unicode character of size 2 bytes
#   h -> Represents signed integer of size 2 bytes
#   H -> Represents unsigned integer of size 2 bytes
#   i -> Represents signed integer of size 2 bytes
#   I -> Represents unsigned integer of size 2 bytes
#   w -> Represents unicode character of size 4 bytes
#   l -> Represents signed integer of size 4 bytes
#   L -> Represents unsigned integer of size 4 bytes
#   f -> Represents floating point of size 4 bytes
#   d -> Represents floating point of size 8 bytes

# http://www.physik.uzh.ch/lectures/informatik/python/python-listen.php


# https://docs.python.org/2/library/array.html#module-array
from array import array

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'TcArray'
g.f_header(sTc,True)


#   ============================================================================
#   m:  define
#   ============================================================================

g.f_menu("define")

#   integer array
ai = array('i', [1, -2, 3, +4, 5])
g.f_menuS1("ar Integer")
g.f_text("ai => %s" % (ai))
g.f_text("check tYpe(ai) : %s" % (type(ai)))
g.f_text("check lEn(ai)  : %s"  % (len(ai)))

#   float array
af = array('f', [-5.4, 123.67, -9.09])
g.f_menuS1("ar Float")
g.f_text("af => %s" % (af))
g.f_text("check tYpe(af) : %s" % (type(af)))
g.f_text("check lEn(af)  : %s"  % (len(af)))

#   char array
# ac = array('c', ['a'])
# => ValueError: bad typecode (must be b, B, u, h, H, i, I, l, L, q, Q, f or d)

#   unsigned array
# au = array('u', u'hello \u2641')
g.f_menuS1("ar UniCode")
l  = [u"firstUni",u"second"]
au = array('u',l[1])
# s  = u"hello"
# au = array('u',s)
# g.f_text("check type(au) : %s" % (type(au)))
g.f_text("check lEn(au)  : %s"  % (len(au)))
g.f_print("show uniCodeStr=[")
for e in au:
    g.f_print(e)
g.f_print("]")

#   ============================================================================
#   m:  access
#   ============================================================================

g.f_menu("access")

#   define
aBase = array('i', [1, -2, 3,-4,5])      # my favourite array

#   copy
a = aBase[:]    # array hard copy
g.f_text("a=%s" % (a))

#   s:  accessByIndex
g.f_menuS1("acces by index")
i = 3
g.f_text("a[%d] = %d" % (i,a[i]))

#   s:  insertByIndex
g.f_menuS1("insert by index")
a = aBase[:]
i = 2
x = 4711
a[i] = x
g.f_text("a[%d]=%d => %s " % (i,x,a))

#   ============================================================================
#   m:methods
#   ============================================================================

g.f_menu("methods")

#   s:  m.append
g.f_menuS1("append by value")
a = aBase[:]
x = -4711
a.append(x)
g.f_text("a.Append('%d') => %s " % (x,a))

#   s:  m.insert
g.f_menuS1("inSert by indeX and value")
a = aBase[:]
i = 3
x = 987
a.insert(i,x)
g.f_text("a.Insert(%d,'%d') => %s " % (i,x,a))

#   s:  m.extend
g.f_menuS1("eXtend by : <ARRAY>")
a = aBase[:]
aTmp = array('i', [-91, -92, -93])
a.extend(aTmp)
g.f_text("a.Extend(%s) => %s " % (aTmp,a))

#   s:  m.fromlist
g.f_menuS1(":eXtend by : <LIST>")
a = aBase[:]
lTmp = [-81,-82]
a.fromlist(lTmp)  # only list
g.f_text("a.FromList(%s) => %s " % (lTmp,a))

#   s:  m.remove
g.f_menuS1("reMove by value")
g.f_menuS2("a")
a = aBase[:]
x = 3  # remove this value
g.f_puts("a:%s" % str(a))

a.remove(x)
g.f_text("a.reMove('%d') \t=> %s " % (x,a))
g.f_menuS2("b")
a = aBase[:]
g.f_puts("a:%s" % str(a))
x = -4
a.remove(x)
g.f_text("a.reMove('%d') \t=> %s " % (x,a))

#   s:  m.pop
g.f_menuS1("reMove by Pop")
a = aBase[:]
x = a.pop()
g.f_text("x:=a.Pop() => x==<%d>,a==<%s> " % (x,a))

#   s:  m.index
g.f_menuS1("get index of value x")
a = aBase[:]
i = 3
x = a.index(i)
g.f_text("x=a.index('%d') => x:='%s'" % (i,x))

#   s:  m.reverse
g.f_menuS1("reverse an array")
a = aBase[:]
a.reverse()
g.f_text("a.reVerse()=>'%s'" % (a))

#   s:  m.count
g.f_menuS1("count mmebers inside an array")
aTmp = array('i', [1, 5, 3,-45,5,4,5])
x = 5
n = aTmp.count(x)  # how many times is 'x' in a ?
g.f_text("n:==%s.count('%d')) => n='%d'" % (aTmp,x,n))


#   === :footer
g.f_footer(sTc)

#   ***************************************************************************
#   My Python Tutorial  :: dataTypes
#   ***************************************************************************
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ-------$

'''
    !content:
        m:  overview
            s:  define
            s:  show
            s:  checkDataType
            s:  getDataType
                u:  getCompoundType of function|class|object
            s:  sizeOf<var>
            s:  id(<var>) : get MemAddress
            s:  subclass
        m:  text
            s:  char
            s:  string
            s:  ascii
        m:  number
            s:  int
            s:  float
            s:  complex
        m:  logical
            s:  bool
            s:  None
        m:  sequence
            s:  range
            s:  list
            s:  set
            s:  frozenset
        m:  dictionary
        m:  byte
            s:  byte
            s:  byteArray
            s:  convert::list=>bytes
            s:  convert::int=>bytes
            s:  memoryView
'''

'''
    !keyword:
        True False
        str
        int float complex
        range list dict tuple
        set frozenset
        type()
        isinstance()
        None
'''

#   === :header
import LIB_inc as m
g = m.CLib(); sTc = "tcDataTypes"
g.f_header(sTc,p_bColor=True)

#   ===========================================================================
#   m:  overview : define/show/check/id dataType
#   ===========================================================================

# Types
g.f_menu("dataType overview")

#
#   s:  define
#

g.f_menuS1("define")

#   simple
i = 6               # integer
f = 1.23            # float
x = complex(6,-3)   # complex

#   derived class of int
b = True            # bool

#   string
c = 'c'             # string - no chars in Python
s = "otto"          # string
y = b'\xB1'         # Byte

#   combined
l = ['anton',1,'berta','cleo']
t = ('alpha',3,'beta','ceta')
e = {('anton','1'),('bert',2),('frida',6)}     # enum or set
z = frozenset(s)

#   dictionary or hash
h = {'de':'Deutschland','plz':'Postleitzahl'}

#   array
r = range(5)

#   none - no dataType
nDataType = None        # no dataType

#   function
def F():
    pass

#   class and create object X
class C:
    pass
X   = C()

#
#   s:  checkDataType(<var>,<dataType>)
#

g.f_menuS1("check <dataType>")

g.f_text("? isInstance(c,str)    =: %r"  % (isinstance(c,str)))
g.f_text("? isInstance(s,str)    =: %r"  % (isinstance(s,str)))
g.f_text("? isInstance(b,bool)   =: %r"  % (isinstance(b,bool)))
g.f_text("? isInstance(y,bytes   =: %r"  % (isinstance(y,bytes)))
g.f_text("? isInstance(i,int)    =: %r"  % (isinstance(i,int)))
g.f_text("? isInstance(f,float)  =: %r"  % (isinstance(f,float)))
g.f_text("? isInstance(x,complex)=: %r"  % (isinstance(x,complex)))
g.f_text("? isInstance(l,list)   =: %r"  % (isinstance(l,list)))
g.f_text("? isInstance(t,tuple)  =: %r"  % (isinstance(t,tuple)))
g.f_text("? isInstance(h,dict)   =: %r"  % (isinstance(h,dict)))
g.f_text("? isInstance(r,range)  =: %r"  % (isinstance(r,range)))
g.f_text("? isInstance(e,set)    =: %r"  % (isinstance(e,set)))
g.f_text("? isInstance(z,frozenSet)    =: %r "   % (isinstance(z,frozenset)))

#   special case NONE
b = False
if nDataType is None:
    b = True
g.f_text("?isInstance(nDataType==None)  =: %r "   % (b))


#
#   s:  getDataType(type<var>=><dataType>)
#

g.f_menuS1("get <dataType>)")

#   s:  getType
sType = type(c);    g.f_text("? type(c) =: <%s>" % (sType))    # class str
sType = type(s);    g.f_text("? type(s) =: <%s>" % (sType))    # class str
sType = type(b);    g.f_text("? type(b) =: <%s>" % (sType))    # class bool
sType = type(y);    g.f_text("? type(y) =: <%s>" % (sType))    # class bytes
sType = type(i);    g.f_text("? type(i) =: <%s>" % (sType))    # class int
sType = type(f);    g.f_text("? type(f) =: <%s>" % (sType))    # class float
sType = type(x);    g.f_text("? type(x) =: <%s>" % (sType))    # class complex
sType = type(l);    g.f_text("? type(l) =: <%s>" % (sType))    # class list
sType = type(t);    g.f_text("? type(t) =: <%s>" % (sType))    # class tuple
sType = type(h);    g.f_text("? type(h) =: <%s>" % (sType))    # class dict
sType = type(r);    g.f_text("? type(r) =: <%s>" % (sType))    # class range
sType = type(e);    g.f_text("? type(e) =: <%s>" % (sType))    # class set
sType = type(z);    g.f_text("? type(z) =: <%s>" % (sType))    # class frozenset

#   u:  getCompoundType of function|class|object
g.f_menuS2("get <comboundType> function|class|object")
sType = type(F);    g.f_text("? type(F) =: <%s>" % (sType))     # class function
sType = type(C);    g.f_text("? type(C) =: <%s>" % (sType))     # class 'type'
sType = type(X);    g.f_text("? type(X) =: <%s>" % (sType))     # ~'__main__.C'

#
#   s:  sizeof(<dataTyp>)
#

import sys


g.f_menuS1("sizeof <dataTyp>")

g.f_text("? sizeof(str)      =: %i"  % (sys.getsizeof(s)))  # 45
g.f_text("? sizeof(bool)     =: %i"  % (sys.getsizeof(b)))  # 28
g.f_text("? sizeof(bytes)    =: %i"  % (sys.getsizeof(y)))  # ( 34 ) tmp
g.f_text("? sizeof(int)      =: %i"  % (sys.getsizeof(i)))  # 28
g.f_text("? sizeof(float)    =: %i"  % (sys.getsizeof(f)))  # 24
g.f_text("? sizeof(complex)  =: %i"  % (sys.getsizeof(x)))  # 32
g.f_text("? sizeof(range)    =: %i"  % (sys.getsizeof(r)))  # 48
g.f_text("? sizeof(list)     =: %i"  % (sys.getsizeof(l)))  # 88
g.f_text("? sizeof(tuple)    =: %i"  % (sys.getsizeof(t)))  # 72
g.f_text("? sizeof(dict)     =: %i"  % (sys.getsizeof(h)))  # 184
g.f_text("? sizeof(enum)     =: %i"  % (sys.getsizeof(e)))  # 216
g.f_text("? sizeof(frozenset)=: %i"  % (sys.getsizeof(z)))  # 216


#
#   s:  id(<var>)    : get MemoryAddress
#

g.f_menuS1("memoryAddress of dataType with id()")

i = 4711
j = 10
g.f_text("iD(i=%d)   = $%04x" % (j,id(i)))
g.f_text("iD(j=%d)   = $%04x" % (j,id(j)))
i = 10
g.f_text("iD(i=%d)*now:$%04x" % (j,id(i)))  # ==id(j)
g.f_text("iD(l)      = $%04x" % (id(l)))
g.f_text("iD(t)      = $%04x" % (id(t)))

# Hash nicht mit Listen, Dictionaris
j = 33
g.f_text("hash(i=%d)   = $%04x" % (i,hash(i)))
g.f_text("hash(j=%d)   = $%04x" % (j,hash(j)))
i = 33
g.f_text("hash(j=%d)*now:$%04x" % (j,hash(j)))
g.f_text("hash(t)    = $%04x" % (hash(t)))
# g.f_text("hash(l)    = $%04x" % (hash(l)))
# g.f_text("hash(h)    = $%04x" % (hash(h)))


#
#   s:  subclass ?
#

g.f_menuS1("isSubClass")

g.f_text("?isSubClass(bool,int)     =: %r"  % (issubclass(bool,int)))   # true
g.f_text("?isSubClass(int,float)    =: %r"  % (issubclass(int,float)))  # false


#   ===========================================================================
#   m:  text:{char,string,ascii,unicode}
#   ===========================================================================

g.f_menu("text dataTypes")

#   s:  char
g.f_menuS1("char")
c   = 'A'
g.f_text("char:'%c'" % (c))

#   s:  string
g.f_menuS1("string")
s   = 'peter'
g.f_text("string:'%s'" % (s))

#   s:  ascii
g.f_menuS1("ASCii")
s   = ascii("Peter\nHassen\nStade\n")
g.f_text("ASCii(s) :%s" % (s))

#   ===========================================================================
#   m:  number:{integer,float,complex}
#   ===========================================================================

g.f_menu("numbers")

#   s:  int
g.f_menuS1("integer")
#   using format-specifier
x = 1234567890; g.f_text("iDec := %d" % (x))
x = 0o12345670; g.f_text("iOct := %o" % (x))
x = 0x1234abcd; g.f_text("iHex.lower := %x" % (x))
x = 0b10101010; g.f_text("iBin := %x" % (x))  # nicht als BIN darstellbar
#   using format-specifier upper-case
x = 0x1234abcd; g.f_text("iHex.upper := %X" % (x))

#   s:  float
g.f_menuS1("Float")
x = 2.1234; g.f_text("fVal := %f" % (x))
x = 3.14e2; g.f_text("fExp := %e" % (x))
x = -2.5E2; g.f_text("fExp := %E" % (x))  # Gross-Buchstaben

#   s:  complex
g.f_menuS1("complex")

x = 3.1 + 4.3j
g.f_text("complex.real := %f" % (x.real))
g.f_text("complex.imag := %f" % (x.imag))

x = -99.123 - 7.7j
g.f_text("complex.real := %f" % (x.real))
g.f_text("complex.imag := %f" % (x.imag))

#   ===========================================================================
#   m:  logical:{bool,None}
#   ===========================================================================

g.f_menu("logical")

#   s:  bool
g.f_menuS1("boolean")
x = True
g.f_text("bVal   := %s" % (g.f_sBool(x)))
x = False
g.f_text("bVal   := %r" % (x))

#   s:  None
g.f_menuS1("None")
x = None        # no dataType
b = False
if x is None:
    b = True
g.f_text("? x==NONE : <%r>"  % (b))

#   ===========================================================================
#   m:  sequence:{range,list,tuple,set,frozenset}  {4+1}
#   ===========================================================================

g.f_menu("sequence dataType")

#   s:  range
g.f_menuS1("range")

#   range from 0...Max-1
n = 6
g.f_menuS2("range(n)")
aRange = range(n)
g.f_text("iRange =: '%s'" % (aRange))
for i in aRange:    # i = 0...n-1
    s = str(i)
    g.f_text("range[%d]=:'%s'" % (i,s))     # 0,1,2,3,4,5

#   range from Min...Max-1
n,m = 5,8
aRange = range(n,m)
g.f_menuS2("range(n,m)")
g.f_text("iRange =: '%s'" % (aRange))
for i in aRange:    # i = n...m-1
    s = str(i)
    g.f_text("range[%d]=:'%s'" % (i,s))     # 5,6,7

#   range from Min...Max-1 StepSize i
n,m,q = 1,8,2
aRange = range(n,m,q)
g.f_menuS2("range(n,m,iStepSize)")
g.f_text("iRange =: '%s'" % (aRange))
for i in aRange:    # i = n, n+q, n+2*q...m-1 q=StepSize
    s = str(i)
    g.f_text("range[%d]=:'%s'" % (i,s))     # 1,3,5,7

#   range Negative from Min...Max-1 StepSize i
n,m,q = -3,1,1
aRange = range(n,m,q)
g.f_menuS2("range(-n,m,iStepSize)")
g.f_text("iRange =: '%s'" % (aRange))
for i in aRange:    # i = n, n+q, n+2*q...m-1 q=StepSize
    s = str(i)
    g.f_text("range[%d]=:'%s'" % (i,s))     # -3,-2,-1,0

#   s:  list
g.f_menuS1("list")
lFruitVal = ["apple","banana",4711,"cherry","strawberry", 3.1 + 4.3j]
g.f_text("lFruitVal =:'%s'" % (lFruitVal))
i = 0
for x in lFruitVal:
    s = str(x)
    g.f_text("list[%d]=:'%s'" % (i,s))
    i += 1

#   s:  tuple
g.f_menuS1("tuple")
tCar = ("audi", "mercedes", "ford", 1984, "toyota")
g.f_text("tCar =:'%s'" % (str(tCar)))
i = 0
for x in tCar:
    s = str(x)
    g.f_text("tuple[%d]=:'%s'" % (i,s))
    i += 1

#   s:  set
g.f_menuS1("set")
sColor = {"white", "green", 123, "red", "yellow", "black"}
g.f_text("sColor =:'%s'" % (sColor))
i = 0
for x in sColor:
    s = str(x)
    g.f_text("set[%d]=:'%s'" % (i,s))
    i += 1

#   s:  frozenset
g.f_menuS1("frozenSet")
sMovie_z = frozenset({"starWars",-5,"BigBangTheory", "Tom&Jerry", "HighNoon"})
g.f_text("sMovie_z =:'%s'" % (sMovie_z))
i = 0
for x in sMovie_z:
    s = str(x)
    g.f_text("frozenset[%d]=:'%s'" % (i,s))
    i += 1

#   ===========================================================================
#   m:  dictionary  {1}
#   ===========================================================================

g.f_menu("dictionary")

hPerson = {"Name": "John",
            "Age": 36,
            "City": "New York"}
g.f_text("hPerson =:'%s'" % (hPerson))

#   show one
g.f_menuS1("show single")
k = 'Name'
v = hPerson[k]
g.f_text("hPerson['%s']=:'%s'" % (k,v))

#   show all
g.f_menuS1("show all")
i = 0
for xKey,xVal in hPerson.items():
    sKey = str(xKey)
    sVal = str(xVal)
    g.f_text("hPerson[%d]=>('%s','%s')" % (i,sKey,sVal))
    i += 1

#   ===========================================================================
#   m:  byte and byteArrays
#   ===========================================================================

# http://www.dotnetperls.com/bytes

g.f_menu("Byte and ByteArrays")

#   s:  byte : dataType==bytes
g.f_menuS1("Byte")
ay = b'\xf9'    # direkte Zuweisung
g.f_text("check tYpe Byte (ay): %s" % (type(ay)))
i  = int(ay[0])
g.f_text("value(ay): %x" % (i))

#   s:  byteArray
g.f_menuS1("build ByteArray")
ay = b'\xa1\xb2\xc3'
g.f_text("check tYpe ByteArray (ay): %s" % (type(ay)))
i = 0
while i < len(ay):
    x = ay[i]
    g.f_text("ay[%d]={%x}" % (i,x))
    i += 1

#   s:  convert::list=>bytes
g.f_menuS1("convert list => ByteArray")
l  = [0, 200, 50]
ay = bytearray(l)   # convert list=>byteArray
g.f_text("list l=%s" % (l))
i = 0
for e in ay:
    g.f_text("byteArray ay [%d]=%d" % (i,e))
    i += 1
g.f_text("check Type(ay): %s" % (type(ay)))

#   s:  convert::int=>bytes
g.f_menuS1("convert int => Bytes")
i  = 0xA1
j  = 0xB2
ay = bytes([i,j])     # convert int=>bytes - value=0..255
g.f_text("i = %d" % (i))
k = 0
for e in ay:
    g.f_text("Bytes ay [%d]=%d" % (k,e))
    k += 1
g.f_text("check Type(i)  : %s" % (type(i)))
g.f_text("check Type(ay) : %s" % (type(ay)))

#   s:  memoryView of bytes
g.f_menuS1("memory view")
L  = [0xa1,0xb2,0xc3]   # Bytes !
g.f_text("use:L(dec)=%s" % (L))
ay = bytearray(L)       # convert list=>byteArray
p  = memoryview(ay)
g.f_text("memView()  = %s" % (p))
for i in range(len(L)):
    g.f_text("memView[%d](heX) = '%X'" % (i,p[i]))


#   === :footer
g.f_footer(sTc)

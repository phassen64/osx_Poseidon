#   ***************************************************************************
#   My Python Tutorial :: dictionary(hash)
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   Dictionaries are used to store data values in key:value pairs.
#   A dictionary is a collection of data...
#   •   Ordered
#   •   Changeable
#   •   without Duplicates


#
#   =:= content
#

'''
    !Content:
        m:  prepare hash
        m:  access|show - using methods
            s:  H.keys
            s:  list(H.keys)
            s:  list(H.values)
            s:  list(H.items)
        m:  access.fileMember
        m:  create
        m:  add&change
            s:  H.add
            s:  H.change
        m:  check
        m:  assign
        m:  merge
        m:  method
            s:  m.get
            s:  m.keys
            s:  m.values
            s:  m.items
            s:  dict()
            s:  m.clear
            s:  m.update
            s:  m.popitem
            s:  m.pop
            s:  m.copy
                u:  restore
                u:  doCopy
            s:  dict.fromkeys()
            s:  m.setdefault
                u:  add.SP
                u:  add.RU
                u:  chg.DE?
        m:  dict(zip())
'''

#   === :header
from __future__ import annotations      # using 2 val in hCar:dict[str,str|int]
import sys
assert sys.version_info >= (3,9)
import LIB_inc as m; g = m.CLib(); sTc = 'TcDictionary'
g.f_header(sTc)

#
#   =:= show some pathes
#

sHome       = g.f_sPwd()
sFilePath   = g.f_sFilePath(__file__)
g.f_puts("PWD:=%s"   % sHome,g.C_COLOR_YELLOW)
g.f_puts(("File:=%s" % sFilePath), g.C_COLOR_YELLOW)

#   ===========================================================================
#   m:  prepare hash 1-4
#   ===========================================================================

#   define hash for test

g.f_menu("prepare hash 1-4")

#   define simple hash
hCity:dict[str,str] = {
    "US": "USA",
    "DE": "Deutschland",
    "GB": "Great Britain",
    "ES": "Espania"}
hZip:dict[str,str]    = {'de':'Deutschland','plz':'Postleitzahl'}
hColor:dict[str,str]  = {"red":"rot","green":"gruen","blue":"blau"}

#   show h1
g.f_menuS1("hCity:print by function")
g.f_text("hCity:%s" % hCity)

#   show h1City,h2Zip,h3Color
g.f_menuS1("h1-h3:print by using strings")
g.f_text("hash1Cty=%s" % (g.f_sHash(hCity)))
g.f_text("hash2Zip=%s" % (g.f_sHash(hZip,True)))
g.f_text("hash3Col=%s" % (g.f_sHash(hColor,True)))

#   make and show combined hName {list[] ,tuple())
g.f_menuS1("hName:print a combined hash")
l:list[str] = ['Antonia','Berta','Cleo','Dorothea','Elvira','Frauke','Gerlinde']
t:tuple[str,str,str] = ('Hansen','Mueller','Schulze')
hName = {
    "VorName": l,
    "NachName": t}
g.f_text("hashName=l&&t=%s" % (g.f_sHash(hName)))

#   ===========================================================================
#   m:  create
#   ===========================================================================

g.f_menu("create")

#   create an empty hash
H_empty = {}
g.f_text("h={}:type(Dict(h))=>%s" % (type(H_empty)))

#   empty hash created with a function
H_dict = dict()
g.f_text("h=dict():type(Dict(h))=>%s" % (type(H_dict)))

#   using type annotaion - define only
H_str_str: dict[str,str] = {}
g.f_text("h=dict():type(Dict(h))=>%s" % (type(H_str_str)))

#   add 1 element into empty hash
H_int_str: dict[int,str] = {}
H_int_str[123] = "peter"
g.f_text("Dict(h)=>%s" % (H_int_str))

#   create hash with content and print
hCar: dict[str,str | int] = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
g.f_text(("hCar =: '%s'" % (hCar)), g.C_COLOR_CYAN)

#   ===========================================================================
#   m:  access|show - using methods
#   ===========================================================================

#   show hash components

g.f_menu("access")

x = 'brand'
s = hCar['brand']
g.f_text("hCar[%s]  =: '%s'" % (x,s))

#   s:  H.keys
g.f_menuS1("H.keys")
y = hCar.keys()     # returns dict_keys
g.f_text("hCar.keys =: '%s'" % (y))
g.f_text("type(y)  : %s" % (type(y)))   # dict_keys
assert (isinstance(y, type({}.keys())) is True)

#   s:  list(H.keys)
g.f_menuS1("list H.keys")
l = list(y)
g.f_text("l  : %s" % l)
g.f_text("type(l)  : %s" % (type(l)))   # l  : ['brand', 'model', 'year']
assert (isinstance(l,list) is True)
assert (l[0] == 'brand')
assert (l[1] == 'model')
assert (l[2] == 'year')

#   s:  list(H.values)
g.f_menuS1("list H.values")
l = list(hCar.values())
g.f_text("hCar.values =: '%s'" % (l))
assert (isinstance(l,list) is True)
assert (l[0] == 'Ford')
assert (l[1] == 'Mustang')
assert (l[2] == 1964)

#   s:  list(H.items)
l = list(hCar.items())
g.f_text("hCar.items =: '%s'" % (l))
assert (l[0][0] == 'brand')
assert (l[0][1] == 'Ford')

#   ===========================================================================
#   m:  access.fileMember
#   ===========================================================================

#   access using member

g.f_menu("access.fileMember")
bRc,hRc     = g.f_bhFilePath_member(__file__)

g.f_text("sPth := '%s'" % (hRc['m_sPth']))
g.f_text("sDir := '%s'" % (hRc['m_sDir']))
g.f_text("sNam := '%s'" % (hRc['m_sNam']))
g.f_text("sBdy := '%s'" % (hRc['m_sBdy']))
g.f_text("sExt := '%s'" % (hRc['m_sExt']))

#   ===========================================================================
#   m:  add&change
#   ===========================================================================

g.f_menu("add && change")

#   s:  H.add
g.f_menuS1("add")
k = 'color'
v = 'white'
hCar[k] = v
g.f_text("hCar[%s] := '%s'" % (k,v))
g.f_text(("hCar =: '%s'" % (hCar)), g.C_COLOR_CYAN)
assert (hCar[k] == v)

#   s:  H.change
g.f_menuS1("change")
k = 'year'
i: int = 2018
hCar[k] = i
g.f_text("hCar[%s] := '%d'" % (k,i))
g.f_text(("hCar =: '%s'" % (hCar)), g.C_COLOR_CYAN)
assert (hCar[k] == i)

#   ===========================================================================
#   m:  check
#   ===========================================================================

g.f_menu("check key")
g.f_text("hashName=l&&t=%s" % (g.f_sHash(hName)), g.C_COLOR_CYAN)

#   *** in KEY
s   = 'VorName'
bRc = (s in hName)
sRc = g.f_sBool(bRc)
g.f_text("? IS '%s' <in> H :%s" % (s,sRc))
assert (bRc is True)

s   = 'Antonia'
bRc = (s in hName)
sRc = g.f_sBool(bRc)
g.f_text("? IS '%s' <in> H :%s" % (s,sRc))
assert (bRc is False)

#   ===========================================================================
#   m:  assign
#   ===========================================================================

g.f_menu("assign")

#   create hash directly
hTmp: dict[int,int] = {}            # init
tKey        = (1,5,8,2,3)   # key-tuple     as hashKey
tVal        = (9,4,7,6,1)   # value-tuple   as hashValue
g.f_text("tKey  => %s" % (g.f_sTuple(tKey)))
g.f_text("tVal  => %s" % (g.f_sTuple(tVal)))

#   print("tKey  => %s" % (tKey))
for i in range(len(tKey)):
    iKey,iVal   = tKey[i], tVal[i]
    hTmp[iKey]  = iVal      # direct assign
g.f_text("hTmp => %s" % (g.f_sHash(hTmp)))
assert (hTmp[5] == 4)
assert (hTmp[3] == 1)

#   ===========================================================================
#   m:  merge dictionaries
#   ===========================================================================

g.f_menu("merge")

d1 = {"a": 1, "b": 2}
d2 = {"a": 3, "d": 4}
d3 = {"e": 5, "f": 6}

#   pre python 3.9
hMerge: dict[str,int] = {}
hMerge = {**d1, **d2, **d3}
g.f_text("hSum => %s" % (g.f_sHash(hMerge)))  # a=>3,b=>2,d=>4,e=>5,f=>6
assert (hMerge['a'] == 3)
assert (hMerge['f'] == 6)

#   since python 3.9
hMerge2: dict[str,int] = {}
hMerge2 = d1 | d2 | d3
g.f_text("hMrg => %s" % (g.f_sHash(hMerge2)))  # a=>3,b=>2,d=>4,e=>5,f=>6
assert (hMerge2['a'] == 3)
assert (hMerge2['f'] == 6)


#   ===========================================================================
#   m:  method
#   ===========================================================================

g.f_menu("methods")
g.f_text("hCity =: %s" % (g.f_sHash(hCity)), g.C_COLOR_CYAN)

#   s:  m.get      :: h.get(y) => elememt
g.f_menuS1("get")
k = 'DE'
x = hCity.get(k)
g.f_text("hCity.get('%s') =: <%s>" % (k,x))     # Deutschland
assert (isinstance(x,str) is True)
assert (x == 'Deutschland')

#   s:  m.key
g.f_menuS1("keys")
i = 0
for x in hCity.keys():
    g.f_text("[%d]:'%s'" % (i,x))
    i += 1

#   check
l = list(hCity.keys())
assert (l[2] == 'GB')

#   s:  m.values
g.f_menuS1("values")
i = 0
for x in hCity.values():
    g.f_text("[%d]:'%s'" % (i,x))
    i += 1

#   check
l = list(hCity.values())
assert (l[3] == 'Espania')

#   s:  m.items => key|value
g.f_menuS1("items")
i = 0
for xKey,yVal in hCity.items():
    i += 1
    g.f_text("[%d]:'%s' => '%s'" % (i,xKey,yVal))

#   check
l = list(hCity.items())
assert (l[0][1] == 'USA')
assert (l[1][0] == 'DE')

#   s:  dict()      : HASH.copy
g.f_menuS1("copy")
hTmp        = dict(hCity)
hCity_saved = dict(hCity)
g.f_text("hCity         =: %s" % (g.f_sHash(hCity)))
g.f_text("hCity.tmp     =: %s" % (g.f_sHash(hTmp)))

#   check with 'is'
bRc = (hTmp is hCity)
g.f_text("? <is>(hTmp,hCity) =: %r" % (bRc))
assert (bRc is False)

#   check with '=='
bRc = (hTmp == hCity)
g.f_text("? <==>(hTmp,hCity) =: %r" % (bRc))
assert (bRc is True)

#   s:  m.clear
g.f_menuS1("clear")
hTmp.clear()
iRc = len(hTmp)
g.f_text("len(hCity_tmp.clear): %d" % (iRc))
g.f_text("hCity_tmp =: %s" % (g.f_sHash(hTmp)))
g.f_text("hCity     =: %s" % (g.f_sHash(hCity)))
assert (iRc == 0)

#   s:  m.update    :: h.update({x,y})
g.f_menuS1("update")

#   add 1
k = 'FR'
v = 'Frankreich'
hCity[k] = v
g.f_text("hCity.add =: %s" % (g.f_sHash(hCity)))
assert (hCity[k] == v)

#   update
v = 'France'
hCity.update({k:v})
g.f_text("hCity.updated =: %s" % (g.f_sHash(hCity)), g.C_COLOR_CYAN)
assert (hCity[k] == v)

#   s:  m.popitem   * pop last added
g.f_menuS1("popitem")

#   popitem first
x = hCity.popitem()
g.f_text("hCity.popitem :%s \n\t\t=> %s" % (x,g.f_sHash(hCity)))
g.f_text("type(x)  : %s" % (type(x)))  # class tuple
assert (isinstance(x,tuple) is True)
assert (x[0] == 'FR')
assert (x[1] == 'France')

#   popitem second
x = hCity.popitem()
g.f_text("hCity.popitem :%s \n\t\t=> %s" % (x,g.f_sHash(hCity)))
assert (isinstance(x,tuple) is True)
assert (x[0] == 'ES')
assert (x[1] == 'Espania')

#   s:  m.pop
g.f_menuS1("pop")

#   pop1
k = 'US'
x = hCity.pop(k)
g.f_text("hCity.popitem :%s|%s" % (x,g.f_sHash(hCity)))
g.f_text("type(x)  : %s" % (type(x)))   # class str
assert (isinstance(x,str) is True)
assert (x == 'USA')

#   pop2
x = '?'
bEc = False
try:
    k = 'XE'
    x = hCity.pop(k)
except KeyError:
    bEc = True
    sEc = "!EXC:KeyError"
except Exception:
    sEc = "unknown key"
    g.f_warning(sEc)

g.f_text("H.pop(%s):rc=%s,ec=%s" % (k,x,sEc))
assert (bEc is True)

#
#   restore old hash
#

#   s:  m.copy
g.f_menuS1("copy")

#   u:  restore
g.f_menuS2("restore with dict")
hCity = dict(hCity_saved)
g.f_text("hCity.restored:%s" % str(hCity))
k = 'US'
v = 'USA'
assert (hCity[k] == v)

#   u:  doCopy - like dict()
g.f_menuS2("do copy")
hTmp = hCity.copy()
g.f_text("hCity.copied:%s" % str(hTmp))
assert (hTmp[k] == v)

#   s:  dict.fromkeys()
#   =*= :   HASH.dict.fromKeys (Tuple=>Hash)
g.f_menuS1("dict.fromkeys")

tNam: tuple[str,str,str] = ('Peter','Vika','Harvey')
tVal: tuple[int] = (90489)        # default is none
g.f_text("showTuple(tNam)   : %s" % str(tNam))
g.f_text("showTuple(tVal)   : %s" % str(tNam))

hTmp = dict.fromkeys(tNam,tVal)
g.f_text("dict.fromkeys(t)  : %s" % str(hTmp))
#   => {'Peter': 90489, 'Vika': 90489, 'Harvey': 90489}
assert (hTmp['Peter'] == 90489)
assert (hTmp['Vika'] == 90489)
assert (hTmp['Harvey'] == 90489)

#
#   s:  m.setdefault
#

hLanguage: dict[str,str] = {
    'en': 'English',
    'de': 'German',
    'fr': 'French'
}

g.f_menuS1("setdefault")
g.f_text("hLanguage:%s" % (str(hLanguage)))
hLng: dict[str,str]
hLng = hLanguage.copy()

#   u:  add.SP add key|val
g.f_menuS2("add.SP")
k   = "sp"
v   = "Spanish"
x   = hLng.setdefault(k,v)    # add a Key&&Value
g.f_text("hTmp.setdef(%s,%s) => \n\t%s=:<%s>" % (k,v,str(hLng),x))
assert (x == v)
assert (hLng[k] == v)

#   u:  add.RU add key
g.f_menuS2("add.RU")
k   = "ru"
v   = "Russian"             # not used
x   = hLng.setdefault(k)    # add a Key but no value
g.f_text("hTmp.setdef(%s,?) => \n\t%s=:<%s>" % (k,str(hLng),x))
assert (x is None)
assert (hLng[k] is None)

#   u:  chg.DE?     * change * notOK
g.f_menuS2("change.DE")
k   = "de"
v   = "Deutsch"
x   = hLng.setdefault(k,v)
g.f_text("hTmp.setdef(%s,%s) => \n\t%s=:<%s>" % (k,v,str(hLng),x))
assert (x != v)
assert (x == 'German')


#   ===========================================================================
#   m:  dict(zip())
#   ===========================================================================

g.f_menu("zip")

l1 = ['USA','Deutschland','England']
l2 = ['US','DE','GB']
g.f_text("l1:= <%s>" % str(l1))
g.f_text("l2:= <%s>" % str(l2))


#   H = dict(zip(l1,l2, strict=True))  # PyVer>=10
if sys.version_info >= (3,10):
    H = dict(zip(l1,l2, strict=False))  # kombiniere Einzelelemente l1 mit l2
    g.f_text("dict(zip<l1,l2>) => <%s>" % str(H))
    assert (H['USA'] == 'US')
    assert (H['Deutschland'] == 'DE')
    assert (H['England'] == 'GB')

#   === :footer
g.f_footer(sTc)

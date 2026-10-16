#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   ***************************************************************************
#   My Python Tutorial  :: integer
#   ***************************************************************************

'''
    !content:
        m:  numberSystem
            s:  bin(),oct(),hex()
            s:  hexString
                u:  dec,bin,oct,hex => hex-String
                u:  dec => {hex,bin,oct}-String
            s:  int(<string>,<base>)
        m:  convert::int<=>char
        m:  typeChange
        m:  casting
        m:  calc
'''


#   === :header
import LIB_inc as m; g = m.CLib(); sTc = "tcInteger"
g.f_header(sTc)

#   ===========================================================================
#   m:  numberSystem
#   ===========================================================================

g.f_menu("numberSystem")


#   s:  bin(),oct(),hex()
g.f_menuS1("Bin,Oct,Hex")

#   p:  binary
i = 0b10100101      # 0b10100101 =: 0xA5 = 165
s = bin(i)          # convert into str
g.f_text("biN(%d)  = %s " % (i,s))

#   p:  octal
i = 0o671       # octal number
s = oct(i)
g.f_text("ocT(%d)  = %s " % (i,s))

#   p:  hex
i = 0x20        # hex value
s = hex(i)
g.f_text("heX(%d)    = %s " % (i,s))        # 0x20
g.f_text("typE(i)    = %s"  % (type(i)))    # class 'int'
g.f_text("typE(s)    = %s"  % (type(s)))    # class 'str'

#   p:  try
i = 0xA1B2C3D4   # hex value
s = hex(i)       # convert into a str
g.f_text("heX2(%x)  = %s " % (i,s))


#   s:  hexString
g.f_menuS1("hexString")

#   u:  dec,bin,oct,hex => hex-String
g.f_menuS2("[dec,bin,oct,hex]=>hex-String")
i = 255;    s = hex(i);   s = "hex.dec(%d) => %s"     % (i,s); g.f_text(s)
i = 0b111;  s = hex(i);   s = "hex.bin(%x) => %s"     % (i,s); g.f_text(s)
i = 0o172;  s = hex(i);   s = "hex.oct(%03o) => %s"   % (i,s); g.f_text(s)
i = 0xA12;  s = hex(i);   s = "hex.hex(%x) => %s"     % (i,s); g.f_text(s)

#   u:  dec => {hex,bin,oct}-String
g.f_menuS2("dec => [bin,oct,hex]-String")
i = 100;    s = hex(i); s = "hex(%d) => %s" % (i,s);    g.f_text(s)
i = 100;    s = bin(i); s = "bin(%d) => %s" % (i,s);    g.f_text(s)
i = 100;    s = oct(i); s = "oct(%d) => %s" % (i,s);    g.f_text(s)

#   s:  int(<string>,<base>)
g.f_menuS1("make int()")
n = 100
b = 16
s = hex(n)
i = int(s,b);  s = "int(str:%s,bas:%d) => %d" % (s,b,i); g.f_text(s)

#   ===========================================================================
#   m:  convert::int<=>char
#   ===========================================================================

#   === Int<>Chr
g.f_menuS1("Int<>Chr")

c = 'A'
i = ord(c)
g.f_text("orD('%s')  = x%X" % (c,i))
g.f_text("tYpe(i)    = %s" % (type(i)))

i = 0x42
c = chr(i)
g.f_text("chR(x%X)   = '%s'" % (i,c))
g.f_text("tYpe(c)    = %s" % (type(c)))

#   ===========================================================================
#   m:  typeChange
#   ===========================================================================

# Types
g.f_menu("type change")

i   = 47
si  = str(i)
g.f_text("tYpe(i) = %s"      % (type(i)))
g.f_text("tYpe(si) = %s"     % (type(si)))

b   = True
ib  = int(b)
sb  = str(b)
g.f_text("tYpe(b) = %s"  % (type(b)))
g.f_text("tYpe(ib)=%s,ib=%d" % (type(ib),ib))
g.f_text("tYpe(sb) = %s" % (type(sb)))


#   ===========================================================================
#   m:  casting
#   ===========================================================================

g.f_menu("casting variables")

s = str(3); t = type(s)
g.f_text("x.string:<%s> type:<%s>" % (s,t))      # class 'str'
b = isinstance(s,str); assert (b is True)

i = int(3); t = type(i)
g.f_text("x.int:<%d> type:<%s>" % (i,t))        # class 'float'
b = isinstance(i,int); assert (b is True)

f = float(3); t = type(f)
g.f_text("x.float:<%f> type:<%s>" % (f,t))      # class 'float'
b = isinstance(f,float); assert (b is True)

#   ===========================================================================
#   m:  calc
#   ===========================================================================

#   Calc
g.f_menu("calculation")

ia      = 47
ib      = -5
ic      = 100
fTmp    = 1.4

#   --- basic arithmetics
g.f_menuS1("arithmentic")
iSum    = ia + ib; assert (iSum == 42)
g.f_text("%d + %d => Sum=%s"  % (ia,ib,iSum))

iSum    = ia + abs(ib); assert (iSum == 52)
g.f_text("%d + ABS(%d) => Sum=%s"  % (ia,ib,iSum))

iSum    = ia - ic; assert (iSum == -53)
g.f_text("%d - %d => Sum = %s"  % (ia,ic,iSum))

iSum    = ia * ib; assert (iSum == -235)
g.f_text("%d * %d => Sum = %s"  % (ia,ib,iSum))

fSum    = ia / ib; assert (fSum == -9.4)  # no auto trunc
g.f_text("%d / %d => Sum = %s"  % (ia,ib,fSum))

bEc = False
sEc = "oK"
try:
    fSum    = ia / 0    # Div by Zero
except Exception as e:
    bEc = True
    sEc = str(e)
g.f_text("fSum = %d/0 => sEc=<%s>" % (ia,sEc)); assert (bEc is True)

#   --- Pow/log
g.f_menuS1("power && log")

fTmp  = 5.5
ib    = 3
fSum  = pow(fTmp,ib)
g.f_text("fTmp = poW(%f,%d) => <%f>" % (fTmp,ib,fSum))
assert (fSum == 166.375000)

fTmp  = 100.0
ib    = -2
fSum  = pow(fTmp,ib)
g.f_text("fTmp = poW(%f,%d) => <%f>" % (fTmp,ib,fSum))
assert (fSum == 0.000100)

#   --- Mod/Div
g.f_menuS1("mod/div")
a = 20
b = 7

y = a // b      # Div
g.f_text("div:: y := %d // %d => %d" % (a,b,y)); assert (y == 2)


y = a % b       # Mod
g.f_text("mod:: y := %d %% %d => %d" % (a,b,y)); assert (y == 6)

fDiv,fMod   = 0.0,0.0
fDiv,fMod   = divmod(ic,ia)     # DivMod(x) => 2 return values
g.f_text("DivMod(%d,%d) => (%s,%s)"  % (ic,ia,fDiv,fMod))
assert (fDiv == 2)
assert (fMod == 6)

fDiv,fMod   = divmod(ia,ib)     # DivMod(x) => 2 return values
g.f_text("DivMod(%d,%d) => (%s,%s)"  % (ia,ib,fDiv,fMod))
assert (fDiv == -24)
assert (fMod == -1)

#   --- Float/Round
g.f_menuS1("float/round")
fSum    = float(ia + fTmp)
g.f_text("Float(%d + %f) => Sum=%s"  % (ia,fTmp,fSum))
assert (fSum == 147.0)

iSum    = ia + round(fSum)
g.f_text("%d + ROUND(%f) => Sum=%s"  % (ia,fTmp,iSum))
assert (iSum == 194)

#   --- MaxMin
g.f_menuS1("max/min")

y  = max(ia,ib)
g.f_text("MAX(%d,%d) => y=%s"  % (ia,ib,y)); assert (y == 47)

y  = min(ia,ib)
g.f_text("MIN(%d,%d) => y=%s"  % (ia,ib,y)); assert (y == -2)

#   Max/Min klappt auch mit Listen,
#   aber die Elemente muessen gleichen Typs sein

Li  = [-3,-8,100,1]
Ls  = ['anton','cleo', 'berta']

x  = max(Li)
g.f_text("MAX(%s) => x=%s"  % (Li,x))
assert (x == 100)

x  = min(Li)
g.f_text("MIN(%s) => x=%s"  % (Li,x))
assert (x == -8)

x  = max(Ls)
g.f_text(("MAX(%s) => x=%s"  % (Ls,x)),False)  # noColor
assert (x == 'cleo')

x  = min(Ls)
g.f_text(("MIN(%s) => x=%s"  % (Ls,x)))
assert (x == 'anton')


#   === :footer
g.f_footer(sTc)

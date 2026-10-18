#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#
#   ***************************************************************************
#   My Python Tutorial :: string
#   ***************************************************************************

'''
    !content:
    •   m:  defineString <standard>
            •   s:  simple
            •   s:  multiplicator
            •   s:  escapeChar
            •   s:  splitted String-Definition
            •   s:  multipleLine String-Definition
    •   m:  quoting a string
            •   s:  Apostrophe
            •   s:  QuotionMark
    •   m:  defineString <raw>
            •   s:  raw.r
            •   s:  raw.R
    •   m:  defineString <fString>
            •   s:  formatMethod
            •   s:  str.f
            •   s:  str.F
    •   m:  string buildIn functions
            •   s:  str()
            •   s:  repr()
    •   m:  len
    •   m:  slicing
    •   m:  string-check compare
    •   m:  split
        •   s:  spliT
        •   s:  rspliT
        •   s:  multiple
    •   m:  part-lines
    •   m:  join
        •   s:  join.char
        •   s:  join.removeSpace
        •   s:  join.replaceChar
    •   m:  find
        •   s:  finD.left
        •   s:  finD.right
    •   m:  indeX
        •   s:  indeX.left
        •   s:  indeX.right
    •   m:  count-chars
    •   m:  replace
    •   m:  Upper&Lower
    •   m:  Capitalize&Title
    •   m:  strip
        •   s:  strip.both
        •   s:  strip.left
        •   s:  strip.right
    •   m:  adjust
        •   s:  adjust.center
        •   s:  zerofill
        •   s:  adjust.left
        •   s:  adjust.right
    •   m:  myLib
        •   s:  stringTest
        •   s:  stringHandling
'''

'''
    !function:
        •   len
        •   split rsplit splitlines
        •   find rfind
        •   zfill
        •   ljust rjust
        •   strip rstrip
        •   join partition
        •   index
        •   count
        •   upper lower
        •   captitalize title
        •   strip lstrip rstrip
        •   center zfill ljust rjust
'''

'''
    !operator:
        •   ==
        •   in
'''

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcString'
g.f_header(sTc,True)

#   =================================================================
#   m:  defineString <standard>
#   =================================================================

g.f_menu("define string-variable")

#   s:  simple
s = 'Im Westen nichts neues'
g.f_text("s=%s" % (s))
s = 'Peter'
g.f_text("s=%s" % (s))

#   s:  multiplicator
s = 3 * 'Harvey'
g.f_text("s=%s" % (s))      # HarveyHarveyHarvey

#   s:  escapeChar   :: NewLine='\n' and TabChar '\t'
s = 'Peter\n\t\tHarvey'
g.f_text("s=%s" % (s))      # Peter Harvey

#   s:  splitted  String-Definition
#       Der Str wird zwar auf 2-Zeilen definiert, aber nur wie
#       ein 1-zeiliger String behandelt.

g.f_menuS1("splitted String-Definition")

#   open bracket '-NL-'
s   = 'Peter and \
        Harvey seperated'
g.f_text("SplitString_A := '%s'"   % (s))   #

#   close bracket '-NL-'
s   = "Peter " \
         "and Harvey " \
         "together."
g.f_text("SplitString_B := '%s'"   % (s))


#   s:  multipleLine String-Definition
g.f_menuS1("multipleLine String-Definition")

#   with: QuestionMark """
s = """s1:Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(s)

#   with: Apostrophe '''
s = '''s2:Peter geht
\tnicht mehr in Stade
\tin die Schule.'''
print(s)


#   =================================================================
#   m:  quoting a string
#   =================================================================

#   A string can be quoted with the letter '' <asc39> or ""<asc34>
#   Python allows multiple qouting like
#       '''john''' or """mike"""

#   https://theasciicode.com.ar/
#       ASCII code 34 = " ( Double quotes ; Quotation mark )
#       ASCII code 39 = ' ( Single quote or Apostrophe )

g.f_menu("quoting a string")

#   s:  Apostrophe {'}
g.f_menuS1("Apostrophe {'}")

#   u:  ap 1x
s = 'Antonia'
g.f_text("s<ap,1x>  = %s" % (s))

#   u:  ap 2x
#   s = ''Berta''  !error not allowed

#   u:  ap 3x
s = '''Cleopatra'''
g.f_text("s<ap,3x>  = %s" % (s))

#   s:  QuotionMark {"}
g.f_menuS1('QuotationMark {"}')

#   u:  qm 1x
s = "Anton"
g.f_text("s<qm,1x>  = %s" % (s))

#   u:  qm 2x
#   s = ""Berti""   ! error

#   u:  qm 3x
s = """Cleo"""
g.f_text("s<qm,3x>  = %s" % (s))

#   =================================================================
#   m:  defineString <raw>
#   =================================================================
#   RawString with 'r' or "R"

#   In Python, a raw string is a special type of string that allows
#   you to include backslashes (\) without interpreting
#   them as escape sequences. In this article,
#   we will see how to take care of a backslash combined with
#   certain alphabet forms literal characters which can change
#   the entire meaning of the string using Python.

g.f_menu(" m:defineString <raw>")

#   s:  raw.r   - little r
g.f_menuS1("raw.r")
s = r"I am a String with Esc-Chars =:{\n \t \r}"
g.f_text("r.RAW-String :<%s>" % (s))

#   s:  raw.R   - upper R
g.f_menuS1("raw.R")
s = R"And I am a String with Esc-Chars =:{\b}"
g.f_text("R.RAW-String :<%s>" % (s))


#   =================================================================
#   m:  defineString <fString>
#   =================================================================
#   F-String or formatted String

#   Python offers a powerful feature called f-strings
#   (formatted string literals) to simplify string
#   formatting and interpolation. f-strings is
#   introduced in Python 3.6 it provides a concise
#   and intuitive way to embed expressions and variables
#   directly into strings.
#   The idea behind f-strings is to make string interpolation simpler.

g.f_menu(" m:defineString <F>")

sNam    = 'Harvey'
iAge    = 9

#   s:  formatMethod
g.f_menuS1("old : using format-method")
g.f_text("Hello, My name is <{0}> and I'm <{1}> years old.".format(sNam,iAge))

#   s:  str.f    #   lowercases f
g.f_menuS1("using f-String : <F> || <f>")
g.f_text(f"f.fString:: I'm <{iAge}> years old.")

#   s:  str.F     #   uppercase F
g.f_menuS1("using F-String : <F> || <f>")
g.f_text(F"F.fString:: My name is <{sNam}>")

#   =================================================================
#   m:  string buildIn functions
#   =================================================================
#   url: https://www.geeksforgeeks.org/str-vs-repr-in-python/
#   In Python, the str() and repr() functions are used to obtain
#       string representations of objects.
#   While they may seem similar at first glance,
#   there are some differences in how they behave.

#   str(x)  :   to <cast> object <x> as string
#   repr(x) :   show a string x

g.f_menu("string buildIn functions")

import datetime


tDTM = datetime.datetime.now()

#   s:  str()
g.f_menuS1("function: str()")

#   a float
s = str(2.0 / 11.0)
g.f_text("str.x := <%s>" % s)       # 0.18181818181818182

#   prints readable format for date-time object
s = str(tDTM)
g.f_text("str.tDTM := <%s>" % s)    # 2024-04-10 10:41:33.855001

#   s:  repr()
g.f_menuS1("function: repr()")

#   the same output
s = repr(2.0 / 11.0)
g.f_text("repr.x := <%s>" % s)      # 0.18181818181818182

#   prints the official format of date-time object
s = repr(tDTM)
g.f_text("repr.tDTM := <%s>" % s)   # 2024, 4, 10, 10, 41, 33, 855001

#   =================================================================
#   m:  len  <strlen>
#   =================================================================

g.f_menu("string len")
sTxt = "abcdefghij"
g.f_text(("use s:='%s' with len='%d'" % (sTxt,len(sTxt))),g.C_COLOR_CYAN)
iLen = len(sTxt)
g.f_text("len('%s') => %d" % (sTxt,iLen))

#   =================================================================
#   m:  slicing
#   =================================================================

#   Test - ausschneiden, Teilbereich suchen

g.f_menu("string slicing{from,exclTo,stepSize}")

sBdy    = "abcdefghij"
sExt    = "xyz"
sTmp    = sBdy + "." + sExt
s       = sTmp
g.f_text(("use s:='%s' with len='%d' and ext='%s'" % (s,len(sTmp),sExt)),
    g.C_COLOR_CYAN)

#   Syntax : sliCe(from,exclusiceTo,step)
g.f_text("sliCe[::]:'%s'"    % (s[::]))
g.f_text("sliCe[0:1]:'%s'"   % (s[0:1]))
g.f_text("sliCe[0:5]:'%s'"   % (s[0:5]))
g.f_text("sliCe[1:len(s)]:'%s'"  % (s[1:len(s)]))    # erstes Zeichen l?schen
g.f_text("sliCe[2:5]:'%s'"   % (s[2:5]))
g.f_text("sliCe[5:2]:'%s'"   % (s[5:2]))
g.f_text("sliCe[5:2:-1]:'%s'"    % (s[5:2:-1]))
g.f_text("sliCe[1:7:2]:'%s'" % (s[1:7:2]))
g.f_text("sliCe[:0:-1]:'%s'" % (s[:0:-1]))
g.f_text("sliCe[:4:]:'%s'"   % (s[:4:]))
g.f_text("sliCe[4::-1]:'%s'" % (s[4::-1]))
g.f_text("sliCe[4:2:-1]:'%s'" % (s[4:2:-1]))
g.f_text("sliCe[8:10]:'%s'"  % (s[8:10]))
g.f_text("sliCe[8:]:'%s'"    % (s[8:]))

#   =================================================================
#   m:  string-check (string compare)
#   =================================================================

#   operator : { '==' , 'in' }

g.f_menu("compare and check strings")


sA  = 'peter'
sB  = 'peter'
bRc = ( sA == sB )
g.f_text("? ( a == b ) => ('%s','%s')= <%r>" % (sA,sB,bRc))
assert ( True == bRc )

sA  = 'peter'
sB  = 'PeTeR'
bRc = ( sA == sB )
g.f_text("? ( a == b ) => ('%s','%s')= <%r>" % (sA,sB,bRc))
assert ( False == bRc )

# use above defines
# so kann man das Ende vegleichen

sMsk    = sTmp[len(sTmp) - len(sExt):]
g.f_text("s = s[len(s)-len(Ext)] => '%s'" % (s))
bRc  = (sMsk == sExt)
if bRc:
    sRc = 'true'
else:
    sRc = 'false'
g.f_text("match('%s',s=%s) ==? => '%s'"    % (sMsk, sExt,sRc))

#   check
sTmp    = "ABCDE#xyz"
sMsk    = "#"
if sMsk in sTmp:
    sRc  = "Yes"
else:
    sRc  = "No"
g.f_text("match('%s',s=%s) IN? => '%s'"    % (sMsk, sTmp, sRc))

bRc = (sMsk not in sTmp)
g.f_text("match('%s',s=%s) NOT IN? => '%s'"    % (sMsk, sTmp, bRc))


#   =================================================================
#   m:  split
#   =================================================================

g.f_menu("string splitting")

#
#   s:  spliT
#

g.f_menuS1("split.STD")

#   u:  standard spliT => standard Sep == ' '
sTmp    = "A B C D"
lRc     = sTmp.split()  # returns list
g.f_text("spliT('%s') => '%s'" % (sTmp,lRc))

#   u:  use own separator c and save
sTmp    = "ABCDE=xyz"
cSep    = '='
(sKey,sVal) = sTmp.split(cSep)
g.f_text("spliT('%s';'%s') => sKey='%s',sVal='%s'"
    % (cSep,sTmp,sKey,sVal))

#   u:  empty spliT
cSep    = ','
sTmp    = "A,B,C,,E,,G,H"
lRc     = sTmp.split(cSep)  # returns list
g.f_text("spliT('%s'|'%s') => '%s'" % (cSep,sTmp,lRc))

#   u:  maximal n X spliT
sTmp    = "Land=Germany,Stadt=Erlangen,PLZ=91052,TEL=09181-908668-4"
cSep    = ','
g.f_text("use s:='%s'" % (sTmp))
for iMax in range(1,3):
    lRc = sTmp.split(cSep,iMax)
    g.f_text("spliT('%s';%d) => '%s'" % (cSep,iMax,lRc))

#   u:  use sep == None => use standard sep=' ' * blank
sTmp    = "red green blue yellow pink"
iMax    = 2
lRc = sTmp.split(None,iMax)
g.f_text("spliT(None;%d)('%s') => '%s'" % (iMax,sTmp,lRc))


#
#   s:  rspliT
#

g.f_menuS1("right-splitting")

#   u:  standard rsplit => standard Sep == ' '
sTmp    = "A;B;C;D"
cSep    = ';'
lRc     = sTmp.rsplit(cSep)  # returns list
g.f_text("rspliT('%s','%s') => '%s'" % (cSep,sTmp,lRc))

#   u:  rsplit => standard Sep == ' '
sTmp    = "red green blue yellow pink"
iMax    = 2
lRc     = sTmp.rsplit(None,iMax)  # returns list
g.f_text("rspliT(None;%d)('%s') => '%s'" % (iMax,sTmp,lRc))


#
#   s:  multiple-split
#

#   Nur die standard Separatoren Blank, NL, etc splitten mehrmals,
#   andere werden als 1 sep zusammengefasst.

g.f_menuS1("multiple splitting")

sTmp    = "red  green blue yellow  pink"    # multiple blanks
lRc     = sTmp.split()
g.f_text("spliT(<std>|'%s') =>\n:'%s'" % (sTmp,lRc))
#   Es werden mehrere Blanks als 1 Stringtrenner aufgefasst

sTmp    = "red;;green;blue;yellow;;pink"    # multiple semilcolon
cSep    = ';'
lRc     = sTmp.split(cSep)
g.f_text("spliT(<'%s'>|'%s') =>\n:'%s'" % (cSep,sTmp,lRc))
#   Es wird jedes Zeichen als Trenner aufgefasst, die Ergebnis-Elemente koennen
#   leer sein.


#
#   s:  spliT lines
#

g.f_menuS1("split lines")
# string with '\r\n' '\r' or '\n'
sLines  = "lineEins\r\nlineZwei\nlineDrei\r"
sTmp    = sLines
L       = sTmp.splitlines()
i   = 0
while i < len(L):
    sRc = L[i]
    g.f_text("splitLines[%d] =>'%s'" % (i,sRc))
    i += 1

#   manually
sRc = ""
for x in L:
    sRc += x
g.f_text("LineWithout NL=>'%s'" % sRc)

#   =================================================================
#   m:  part-lines
#   =================================================================

#   Es wird nur 1x gesplittet
#   Split(max=1) entspricht ungefaeahr der Partition, es wird jedoch eine Liste
#   und nicht ein Tupel erzeugt.

g.f_menu("partition lines :=> sLine => tBeforeSep,tSep,tAfterSep")
# Es werden 3 Komponenten geniert -
#   1) der Teil vor Sep,
#   2 )der Sep,
#   3) der Teil nach dem Sep

sTmp    = "Anton,Berta Cleo,David"
cSep    = ','
tRc     = sTmp.partition(cSep)
g.f_text("partiTion('%s'|'%s') => tRc='%s'" % (cSep,sTmp,tRc))
g.f_text("tRc[0] =: '%s'" % (tRc[0]))
g.f_text("tRc[1] =: '%s'" % (tRc[1]))
g.f_text("tRc[2] =: '%s'" % (tRc[2]))

sTmp    = "A;B;C;D"
cSep    = ';'
tRc     = sTmp.partition(cSep)
g.f_text("partiTion('%s','%s') => tRc='%s'" % (cSep,sTmp,tRc))
g.f_text("tYpe(tRc)  =: '%s'" % (type(tRc)))
g.f_text("tRc        =: '%s'" % (str(tRc)))


#   =================================================================
#   m:  join     : reverse split
#   =================================================================

g.f_menu("joiN")


#   s:  join.char
g.f_menuS1("join list")
cSep    = ';'
lTmp    = ["1=begin","2","3=end"]   # stringListe
sRc     = cSep.join(lTmp)
g.f_text("joiN(c='%s',ls='%s') => x='%s'" % (cSep,lTmp,sRc))
g.f_text("tYpe(x) =: '%s'" % (type(sRc)))

#   s:  join.removeSpace
g.f_menuS1("remove all spaces")
cSep    = ''                                # zeroSpace
sTmp    = " This text contains spaces "     # text
lTmp    = sTmp.split()
sRc     = cSep.join(lTmp)
g.f_text("joiN.spliT(c='%s',s='%s') => x='%s'" % (cSep,sTmp,sRc))

#   s:  join.replaceChar
g.f_menuS1("join.replace")
#   define my string
s  = "ABCDEFGH"; g.f_text("s=<%s>" % (s))   # => "ABCDEFGH"
#   change string
l       = list(s)       # convert str into list
l[2]    = 'x'           # position 2
# s     = str(l)        # not works
s       = "".join(l)    # put together
g.f_text("s=<%s>" % (s))        # => "ABxDEFGH"


#   =================================================================
#   m:  finD
#   =================================================================

g.f_menu("findStr")

sTmp    = "Anton, Berta, Cleo, David, Emil"
g.f_text(("use s:='%s'" % (sTmp)),g.C_COLOR_CYAN)

#
#   s:  finD.left
#

g.f_menuS1("left")

sMsk    = "ta"
iRc     = sTmp.find(sMsk)
g.f_text("finD('%s') => x='%d'" % (sMsk,iRc))       # 10

#   -1 if not found
sMsk    = "x"
iRc     = sTmp.find(sMsk)
g.f_text("finD('%s') => x='%d'" % (sMsk,iRc))       # -1

sMsk    = "o"
iRc     = sTmp.find(sMsk)
g.f_text("finD('%s') => x='%d'" % (sMsk,iRc))       # 3

sMsk    = "z"
iRc     = sTmp.find(sMsk)
g.f_text("finD('%s') => x='%d'" % (sMsk,iRc))       # -1

sMsk    = "l"
iBeg    = 20
iRc     = sTmp.find(sMsk,iBeg)
g.f_text("finD('%s',iBeg=%d) => x='%d'" % (sMsk,iBeg,iRc))  # 30

iBeg    = 10
iEnd    = 20
iRc     = sTmp.find(sMsk,iBeg,iEnd)
g.f_text("finD('%s',%d,%d)) => x='%d'" % (sMsk,iBeg,iEnd,iRc))  # 15

sTmp    = "ABCxDEFGHxIJ"
g.f_text(("use s:='%s'" % (sTmp)),g.C_COLOR_CYAN)

sMsk    = "x"
iRc     = sTmp.find(sMsk)
g.f_text("finD('%s') => x='%d'" % (sMsk,iRc))       # 3

iBeg    = 0
iEnd    = 8
iRc     = sTmp.find(sMsk,iBeg,iEnd)
g.f_text("finD('%s',%d,%d) => x='%d'" % (sMsk,iBeg,iEnd,iRc))   # 3

#
#   s:  finD.right
#

g.f_menuS1("right")

sTmp    = "ABCxDEFGHxIJ"
g.f_text(("use s:='%s'" % (sTmp)),g.C_COLOR_CYAN)

sMsk    = "x"
iRc     = sTmp.rfind(sMsk)
g.f_text("rfinD('%s') => x='%d'" % (sMsk,iRc))
# Ergebnis wie oben

iBeg    = 2
iEnd    = 8
iRc     = sTmp.rfind(sMsk,iBeg,iEnd)
g.f_text("rfinD('%s',%d,%d) => x='%d'" % (sMsk,iBeg,iEnd,iRc))
# Ergebnis wie oben

#   =================================================================
#   m:  indeX Strings - generate exceptions
#   =================================================================

g.f_menu("indeX str")

sTmp    = "ABCxDEFGHxIJ"
g.f_text(("use s:='%s'" % (sTmp)),g.C_COLOR_CYAN)

#
#   s:  indeX.left
#

g.f_menuS1("indeX.STD")
sMsk    = "x"
iRc     = sTmp.index(sMsk)
g.f_text("indeX('%s') => x='%d'" % (sMsk,iRc))      # 3

# generate exception, if not found
iRc = -999
try:
    sMsk    = "y"
    iRc     = sTmp.index(sMsk)
except Exception as e:
    sEc = str(e)
g.f_text("indeX('%s') => iRc=%d,sEc='%s'" % (sMsk,iRc,sEc))     # -999

#
#   s:  indeX.right
#

g.f_menuS1("indeX.RIGHT")
sTmp    = "ABCxDEFGHxIJxLMNOP"
g.f_text("use s:='%s'" % (sTmp))

sMsk    = "x"
iRc     = sTmp.rindex(sMsk)
g.f_text("rindeX('%s') => x='%d'" % (sMsk,iRc))

#   =================================================================
#   m:  count-chars
#   =================================================================

g.f_menu("countStr")

sTmp    = "ABCxDEFGHxIJxLMNOP"
g.f_text("use s:='%s'" % (sTmp))

#   how many 'x' are in sTmp?
sMsk    = "x"
iRc     = sTmp.count(sMsk)
g.f_text("counT(\"%s\") => iRc=%d" % (sMsk,iRc))    # =: 2

#   how many 'y' are in sTmp?
sMsk    = "y"
iRc     = sTmp.count(sMsk)
g.f_text("counT(\"%s\") => iRc=%d" % (sMsk,iRc))    # =: 0

#   =================================================================
#   m:  replace
#   =================================================================

g.f_menu("replaceStr")

sTmp    = "ABCxDEFGHxIJxLMNOP"
g.f_text("use s:='%s'" % (sTmp))

# n x replace
sSrc    = "x"
sObj    = "y"
sRc     = sTmp.replace(sSrc,sObj)
g.f_text("replaceT('%s','%s') => sRc='%s'" % (sSrc,sObj,sRc))

# maximal 2x replace
sSrc    = "x"
sObj    = "y"
iMax    = 2
sRc     = sTmp.replace(sSrc,sObj,iMax)
g.f_text("replaceT('%s','%s',%d) => sRc='%s'" % (sSrc,sObj,iMax,sRc))

# replace ?
sSrc    = "z"
sObj    = "y"
iMax    = 2
sRc     = sTmp.replace(sSrc,sObj,iMax)
g.f_text("replaceT('%s','%s',%d) => sRc='%s'" % (sSrc,sObj,iMax,sRc))

# replace 2 lettes
sSrc    = "AB"
sObj    = "QP"
iMax    = 2
sRc     = sTmp.replace(sSrc,sObj,iMax)
g.f_text("replaceT('%s','%s',%d) => sRc='%s'" % (sSrc,sObj,iMax,sRc))

#   =================================================================
#   m:  Upper&Lower
#   =================================================================

g.f_menu("Upper or Lower a Str")

sTmp    = "abCxDEFGHxIJxLMNOP qRstu vw"
g.f_text("use s:='%s'" % (sTmp))

# uppeR
sRc     = sTmp.upper()
g.f_text("uppeR() => sRc='%s'" % (sRc))

# loweR
sRc     = sTmp.lower()
g.f_text("loweR() => sRc='%s'" % (sRc))

#   =================================================================
#   m:  Capitalize&Title
#   =================================================================

g.f_menu("Capitalize vs Title")

sTmp    = "abCxDEFGHxIJxLMNOP qRstu vw"
g.f_text(("use s:='%s'" % (sTmp)),g.C_COLOR_CYAN)

sRc     = sTmp.capitalize()
g.f_text("capitaliZe() => sRc='%s'" % (sRc))

sRc     = sTmp.title()
g.f_text("titlE() => sRc='%s'" % (sRc))

#   =================================================================
#   m:  strip strings
#   =================================================================

#   *   removing white chars

g.f_menu("Strip strings")

sTmp  = "\t\nABC\t\n"
lTmp    = sTmp.split(';')   # take not included
g.f_text(("use s=> l=%s" % (lTmp)),g.C_COLOR_CYAN)

#   s:  strip.both: strip at both sides
g.f_menuS1("both")
sRc     = sTmp.strip()
lTmp    = sRc.split(';')    # convert into list
g.f_text("striP()  => sRc = '%s'" % (lTmp))

#   s:  strip.left
g.f_menuS1("left")
sRc     = sTmp.lstrip()
lTmp    = sRc.split(';')    # convert into list
g.f_text("lstriP() => sRc = '%s'" % (lTmp))

#   s:  strip.right
g.f_menuS1("right")
sRc     = sTmp.rstrip()
lTmp    = sRc.split(';')
g.f_text("rstriP() => sRc = '%s'" % (lTmp))

#   =================================================================
#   m:  adjust strings
#   =================================================================

#   adding spaces

g.f_menu("adjust strings")
s   = "ABC"
iLen    = 20

g.f_text("use : s='%s', len=%d" % (s,iLen))

#   s:  adjust.center
sRc     = s.center(iLen)
g.f_text("centeR(%d)    =>\t'%s'" % (iLen,sRc))

#   s:  zerofill
sRc     = s.zfill(iLen)
g.f_text("zFill(%d)     =>\t'%s'" % (iLen,sRc))

#   s:  adjust.left
sRc     = s.ljust(iLen)
g.f_text("lJust(%d)     =>\t'%s'" % (iLen,sRc))

#   s:  adjust.right
sRc     = s.rjust(iLen)
g.f_text("rJust(%d)     =>\t'%s'" % (iLen,sRc))

#   =================================================================
#   m:  myLib
#   =================================================================
g.f_menu("test string using myLibrary")

#   s:  stringTest
g.f_menuS1("stringTest")

sFct,c      = "isalpha",'A'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,s      = "isalpha",'Abcd'
bRc,iRc     = g.f_isFct(sFct,s)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "isalnum",'e'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "isalnum",'123A'
bRc,iRc    = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s,%d" % (sFct,c,bRc,iRc))
assert (bRc is True)

sFct,c      = "isdigit",c
bRc,iRc    = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s,%d" % (sFct,c,bRc,iRc))
assert (bRc is False)

sFct,c      = "isxdigit",'E'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "isupper",'E'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "islower",'E'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is False)

sFct,c      = "isgraph",'$'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "isgraph",' '
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is False)

sFct,c      = "isspace",' '
bRc,iIdx    = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "isprint",'$'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is True)

sFct,c      = "iscntrl",'$'
bRc,iRc     = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s" % (sFct,c,bRc))
assert (bRc is False)

# False
sFct,c      = "isANY",'$'
bRc,iRc    = g.f_isFct(sFct,c)
g.f_text("LIB.%s('%s') => %s,%d" % (sFct,c,bRc,iRc))
assert (bRc is False)

#   s:  stringHandling
g.f_menuS1("stringHandling")

#   u:  LIB.chomp
g.f_menuS2("chomp")
sText = "Peter und\r\n   Harvey sitzen \n zu Hause \r"
g.f_text("Text := <%s>" % sText)
sRc = g.f_sChomp(sText,False)
g.f_text("LIB.s.chomp<F> =>'%s'" % sRc)
sRc = g.f_sChomp(sText,True)
g.f_text("LIB.s.chomp<T> =>'%s'" % sRc)

#   u:  LIB.trim
g.f_menuS2("trim")
sRc = g.f_sTrim(sText,False)
g.f_text("LIB.s.trim<F> => '%s'" % (sRc))
sRc = g.f_sTrim(sText,True)
g.f_text("LIB.s.trim<T> => '%s'" % (sRc))

#   u:  LIB.replace
g.f_menuS2("replace")
sText = "Ernie und Bert"
g.f_text("Text := <%s>" % sText)
i = 4
c = 'x'
sRc = g.f_sReplace(sText,c,i)
g.f_text("LIB.s.replace(%s,%d) => '%s'" % (c,i,sRc))

#   === :footer
g.f_footer(sTc)

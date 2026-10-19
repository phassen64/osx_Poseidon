#   ***************************************************************************
#   My Python Tutorial  :: print formatted
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'TcPrintFormatted'
g.f_header(sTc)

#   === :content
'''
    content:
        m:  classic
        m:  buildIn function format()
        m:  str.format() method
        m:  hashStr.format()
        m:  further str.method
'''

#   ===========================================================================
#   m:  classic   12.3) print mit modulo operator  (C-like)
#   ===========================================================================

g.f_menu("print classic with '%'")

#
#   print("text %<FS>, %<FS>..." % (p1,p2,..)
#

#   FS ::= %[flags][width][.precision]type

#   http://www.python-kurs.eu/python3_formatierte_ausgabe.php
#   d   Vorzeichenbehaftete Ganzzahl (Integer, dezimal).
#   i   Vorzeichenbehaftete Ganzzahl (Integer, dezimal).
#   o   vorzeichenlose Ganzzahlen (oktal)
#   u   vorzeichenlose Ganzzahlen (dezimal)
#   x   vorzeichenlose Ganzzahlen (hexadezimal)
#   X   vorzeichenlose Ganzzahlen (hexadezimal), Uppercase
#   e   Fliesskommazahl im Exponentialformat (in Kleinbuchstaben).
#   E   Fliesskommazahl im Exponentialformat (in Grossbuchstaben).
#   f   wie e
#   F   wie E
#   g   Wie "e", wenn der Exponent groesser ist als -4 oder oder kleiner als
#       die Praezision.
#       Ansonsten wie "f"
#   G   wie "E" und analog zu "g"
#   c   ein Zeichen
#   s   Eine Zeichenkette (String); beliebige Python-Objekte
#       werden in String mittels der Methode str()) gewandelt.
#   r   siehe s
#   %   Es findet keine Argument-Konvertierung statt,
#       es wird ein "%"-Zeichen ausgegeben.


# integer
x,sFmt = 124,"%d"
g.f_text("Int(%d,%s) => %d" % (x,sFmt,x))

# float
x,sFmt = 1.2345,"%2f"
g.f_text("Float(%s,%s) => %.2f"  % (x,sFmt,x))

# exponent
x,sFmt = 1.2345,"%8.2e"
g.f_text("Exp(%s,%s) => %8.2e"   % (x,sFmt,x))

x,sFmt = 124,"%x"
g.f_text("Hex(%s,%s) => %x"   % (x,sFmt,x))

x,sFmt = 124,"%o"
g.f_text("Oct(%s,%s) => %o"   % (x,sFmt,x))

x,sFmt = "Hans im Glueck","%s"
g.f_text("Str(%s,%s) => %s"   % (x,sFmt,x))

#   ===========================================================================
#   m:  buildIn function format(<fmt>,<variable>)
#   ===========================================================================

g.f_menu("using builtin-function 'format'")

i = 123
c = 'x'
s = format(i,c)
g.f_text("formAt(%d,'%s') => %s" % (i,c,s))

f = 5.123
c = '.2f'  # nur 2 Nach-KommaStellen
s = format(f,c)
g.f_text("formAt(%f,'%s') => %s" % (f,c,s))


#   ===========================================================================
#   m:  str.format() method
#   ===========================================================================
#   !url: https://docs.python.org/3/library/stdtypes.html#str.format

#   example:
#       iAge = 59
#       str  = "peter is {0} years old".format(iAge)
#   DES:
#       print("text {0:<FS>} {1:<FS>} ...".format % (p0,p1,..)
#       Positions-Parameter Zuordnungen p0->{0},p1->{1}...
#       FS ::= {'s','d',...}


g.f_menu("using str.format() method")

# 2 Parameter {0}...{n} n=2
g.f_menuS1("frmStr")
g.f_text("Eins:{0} Zwei:{1}".format(1,2))   # parameter 0,1

g.f_menuS1("frmStrB")
sNam   = 'harvey'
iAge   = 9
g.f_text("Age:={1} Name:={0}".format(sNam,iAge))   # parameter 1,0

# str+integer
g.f_menuS1("str+integer")
s = "Erster:{0:s} Zwei:{1:d}"   # string und
g.f_text(s.format('Spam',4711))             # eigene Parameter-Maske s

# mehrmalige Parameter  - 1 parameter mehrmals ausgeben
g.f_menuS1("multiple parameter")
s = "Eins:{0:s} Zwei:{1:d} Drei={2:d} Vier={2:x}"
g.f_text(s.format('Spam',4711,64))

# leere Parameter
g.f_menuS1("empty parameter")
s = "Erster:{} Zwei:{}"     # Maske
g.f_text(s.format(47,1.234))

# Schluessel-Wort-Parameter -Bsp:x1,x2
g.f_menuS1("keyWord parameter")
s = "Erster:{x1:d} Zwei:{x2:3.2f}"
g.f_text(s.format(x1=987,x2=123.456))

# linksbuendig string
g.f_menuS1("left-sided")
s = "Erster={0:<10s} Zwei={1:6.2f}"
g.f_text(s.format('   peter',1.234))


#   ===========================================================================
#    m:  hashStr.format()
#   ===========================================================================
#   !doc:    12.5) hash string als print.format
#   !url:
#   https://www.geeksforgeeks.org/how-to-format-a-string-using-a-dictionary-in-python/

#   --- C: hash string
g.f_menu("hash string")

# Hash
hIdentityCountry = {
        "US": "USA",
        "DE": "Deutschland",
        "GB": "Great Britain",
        "ES": "Espania"}

i = 0
for p_sVal in hIdentityCountry:
    i += 1
    s = "{xId}=>{xName}".format(xId=p_sVal,xName=hIdentityCountry[p_sVal])
    g.f_text("[%d]=%s" % (i,s))

g.f_text("hIdentityCountry %s" % str(hIdentityCountry))

#   ===========================================================================
#   m:  further str.methods s.x(i,c) for formatting
#   ===========================================================================
#   x =: {center,rjust,ljust,fill,zfill}

g.f_menu("string methods to format")

sx = "!ABCDE$"
sl = "!left-Orientated      $"
sr = "!     right-Orientated$"

s = sx.center(40,'.')
g.f_text("sx.center:{0}".format(s))

s = sl.center(40,'.')
g.f_text("sl.center:{0}".format(s))

s = sx.rjust(40,'.')
g.f_text("sx.rjust:{0}".format(s))

s = sx.ljust(40,'.')
g.f_text("sx.ljust:{0}".format(s))

s = sx.zfill(40)
g.f_text("sx.zfill:{0}".format(s))

#   === :footer
g.f_footer(sTc)

#   ***************************************************************************
#   My Python Tutorial  :: F_string
#   ***************************************************************************
#   url: https://realpython.com/python-f-strings/
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    F_string
        m:  intro
        m:  flags:{!s,!r}
        m:  compare string-definitions
'''

import LIB_inc as m1;   g = m1.CLib();   sTc = 'TcFString'

#   === :header
g.f_header(sTc)

#   ===========================================================================
#   m:  intro
#   ===========================================================================

g.f_menu("F-string intro")

#       int and float with place holder
i       = 17
f       = 42.12345
s       = f"int:{i:5d}";   g.f_text(s)      # "....17"
s       = f"flt:{f:.8f}";   g.f_text(s)     # "42.12345000"

#   separator ','
iVal    = 1234
fVal    = 1234567.9876
cSep    = ','
s       = f"iVal := {iVal:{cSep}}"
g.f_text(s)     # <<< -1,234,567

#   separator '_'
cSep    = '_'
s       = f"iVal := {iVal:{cSep}}"
g.f_text(s)     # <<< -1_234_567

#   dateTime with tuple
tDTM    = (9, 6, 2023)
s       = f"date := {tDTM[0]:02}-{tDTM[1]:02}-{tDTM[2]}"
g.f_text(s)     # <<< 09-06-2023

#   dateTime by library
from datetime import datetime


tDTM    = datetime(2023, 9, 26)
s       = f"--- date := {tDTM:%m/%d/%Y}"
g.f_text(s)     # <<< 09/26/2023


#   ===========================================================================
#   m:  flags:{!s,!r}
#   ===========================================================================

g.f_menu("F-string flags {!s,!r}")

#   class person
class CPerson:
    def __init__(self, p_sName, p_iAge):
        self.m_sName = p_sName
        self.m_iAge  = p_iAge

    #   overwrite method '__str__'
    def __str__(self):
        return f"I'm {self.m_sName}, and I'm {self.m_iAge} years old."

    #   overwrite method '__repr__'
    def __repr__(self):
        sClassName = type(self).__name__        # => CPerson
        return f"{sClassName}(name='{self.m_sName}', age={self.m_iAge})"

#   object sheldon
X = CPerson("Sheldon Cooper", 31)

#   using __str__ with !s
#   <<< I'm Sheldon Cooper, and I'm 31 years old
s   = f"X::!s =: {X!s}";    g.f_text(s)

#   using __repr__ with !r
#   <<< CPerson(name='Sheldon Cooper', age=31)
s   = f"X::!r =: {X!r}";    g.f_text(s)

#   ===========================================================================
#   m:  compare string-definitions
#   ===========================================================================

g.f_menu("show")

class CPrint(CPerson):

    #   string concat with +
    def f_concat(self) -> str:
        s   = self.m_sName
        i   = self.m_iAge
        sRc = "Name :<" + str(s) + "> Age=<" + str(i) + ">."
        return sRc

    #   C-style
    def f_cStyle(self) -> str:
        s   = self.m_sName
        i   = self.m_iAge
        sRc = "Name :<%s> and Age:<%d>." % (s,i)
        return sRc

    #   format with position connection
    def f_formatPos(self) -> str:
        s   = self.m_sName
        i   = self.m_iAge
        sRc = "Name :<{0:s}> and Age:<{1:d}>.".format(s,i)
        return sRc

    #   format unformatted
    def f_formatAny(self) -> str:
        s   = self.m_sName
        i   = self.m_iAge
        sRc = "Name :<{}> and Age:<{}>.".format(s,i)
        return sRc

    #   F-String
    def f_fString(self) -> str:
        s   = self.m_sName
        i   = self.m_iAge
        sRc = f"Name :<{s}> and Age:<{i}>."
        return sRc

#   object elvis
X = CPrint("Elvis Presley", 48)

s = X.f_concat();   g.f_text("rc.concat:= %s" % (s))
s = X.f_cStyle();   g.f_text("rc.cStyle:= %s" % (s))
s = X.f_formatPos();g.f_text("rc.fmtPos:= %s" % (s))
s = X.f_formatAny();g.f_text("rc.fmtAny:= %s" % (s))
s = X.f_fString();  g.f_text("rc.fStr  := %s" % (s))


#   === :footer
g.f_footer(sTc)

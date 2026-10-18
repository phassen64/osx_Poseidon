#   ***************************************************************************
#   My Python Tutorial  ::  regExpr
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   MOD:    re

#   === :header
import re
import LIB_inc as m;    g = m.CLib();   sTc = 'tcRegExp'
g.f_header(sTc)

''' content
        m:  introduction
            s:  operator.IN
            s:  module.re
            s:  metaChar
            s:  predefined charClass
        m:  regEx.search
            s:  match:escape:{\\}
            s:  match:single.mandatory:{.}
            s:  match:single.optional:{?}
            s:  match:mandatory:{+}
            s:  match:optional:{*}
            s:  match:OR:{|}
            s:  match.multiplier:{m}
            s:  match.set:{[xyz]}
            s:  match.range:{[x-z]}
            s:  match:setFactor:[]{*,+,?}
                u:  setFactor
                u:  setRange
            s:  match:negation:{^}
            s:  match:position:{^,$}
            s:  match:predefinedCharClass
            s:  match:bracket:{[]}
            s:  methods: group,start,end
            s:  xml.example
        m:  regEx.findAll
        m:  regEx.compile
        m:  regEx.split
        m:  regEx.Substitute
'''

#   ===========================================================================
#   m:  Introduction
#   ===========================================================================

g.f_menu("Introduction")

#   s:  operator.IN
g.f_menuS1("operator: IN")
sVal    = "Peter ist in der Schule"
sMsk    = "er"
g.f_text("'%s' IN '%s' =: {%s}" % (sVal,sMsk,sMsk in sVal))

sMsk    = "sc"  # upperLowerCase
g.f_text("'%s' IN '%s' =: {%s}" % (sVal,sMsk,sMsk in sVal))
sMsk    = "Sc"
g.f_text("'%s' IN '%s' =: {%s}" % (sVal,sMsk,sMsk in sVal))

#
#   s:  module.re
#
g.f_menuS1("The module re")

#   *** MetaChars
#   https://docs.python.org/2/library/re.html#re-syntax
#       \   :   meta escape char
#               Its also used to escape all the metacharacters so you can
#               still match them in
#               patterns; for example, if you need to match a [ or \,
#                   you can precede
#               them with
#               a backslash to remove their special meaning: \[ or \\.
#       .   :   single char
#               (Dot.) In the default mode, this matches any character
#               except a newline. If the DOTALL flag has been specified,
#               this matches any character including a newline.
#       *   :   many char or no
#               Causes the resulting RE to match 0 or more
#               repetitions of the preceding RE, as many repetitions as are
#               possible. ab* will match "a", "ab", or "a" followed by any
#               number of "b"s.
#       ?   :   optional letter
#               Causes the resulting RE to match 0 or 1
#               repetitions of the preceding RE. ab? will match either "a"
#               or "ab".
#       +   :   mandatory
#       |   :   X or Y
#       ^   :   position: START
#       $   :   position: END
#       {m} :   Specifies that exactly m copies of the previous RE
#                   should be matched; fewer matches
#                   cause the entire RE not to match.
#               For example, a{6} will match exactly six 'a'
#                       characters, but not five.
#       []  :   character class
#       ()  :   group matches


#   s: example
g.f_menuS1("example")
sVal = 'The rain in Spain'
sMsk = '^The.*Spain$'
reRc = re.search(sMsk, sVal)
if reRc:
    g.f_text("YES! We have a match!")
else:
    g.f_text("No match")

g.f_text("reRc => %s" % reRc)     # class 're.Match'
g.f_text("type.reRc => '%s'" % type(reRc))     # class 're.Match'

#
#   s:  metaChar
#
g.f_menuS1("show meta-chars")
s = r"'\','.','+','?','*','^','$','[]','{}','()'"  # RAW-string
g.f_text("METACHARS={%s}" % s)


#
#   s:  predefined charClass
#

g.f_menuS1("show predefined char-classes")

#   a) positiv
#       \d: decimal number
#       \s: white space {\t,...' '}
#       \w: alnum
#       \b: blank - at begin or end
#   b) negative
#       \D: NOT \d
#       \S: NOT \s
#       \W: NOT \w
#       \B: NOT \b

s       = r"'\d','\D','\s','\S','\w','\W',\b','\B'"
g.f_text("CHAR-CLASSES={%s}" % s)


#   ===========================================================================
#   m:  regEx.search
#   ===========================================================================

g.f_menu("regExpr.search")


#
#   s:  match:escape:{\}
#

g.f_menuS1("match escape :{\\}")

# find ^$XY at string end - using backslash '\'
sVal,sMsk,bRc   = r"ABCD^$XY", r"\^\$XY$",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match:single.mandatory:{.}
#

g.f_menuS1("match single :{.}")

sVal,sMsk,bRc   = "ABCabcABCabcABCabc", r".BC", False
if re.search(sMsk,sVal):
    bRc = True
    g.f_text("RE.s('%s','%s') =: TRUE" % (sVal,sMsk))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABC?bcABCab\bABCabc", r".b",False
if re.search(sMsk,sVal):
    bRc = True
    g.f_text("RE.s('%s','%s') =: TRUE" % (sVal,sMsk))
assert (bRc is True)

sVal,sMsk   = r"ABC\bac", r".x"
bRc = bool(re.search(sMsk,sVal))  # PHA: using bool(re)
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,re.search(sMsk,sVal)))
assert (bRc is False)                   # False
#
#   s:  match:single.optional:{?}
#

g.f_menuS1("match single optional :{?}")

sVal,sMsk,bRc   = "ABCDEFGH", r"ABx?C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "ABxCDEFGH", r"ABx?C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "ABxxxCDE", r"ABx?C", False   # 3x 'x'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = "AxCDEFGH", r"A?CD", False    # no 'B'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)


#
#   s:  match:mandatory:{+}
#

g.f_menuS1("match many mandatory (at least 1) :{+}")

#   char Y is the optional one
sVal,sMsk,bRc   = "ABCDEFGH", r"ABx+C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = "ABxCDEFGH", r"ABx+C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "ABxxxCDE", r"ABx+C", False           # 3x 'x'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "AxCDEFGH", r"ABx+C", False       # no 'B'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#
#   s:  match:optional:{*}
#

g.f_menuS1("match many optional :{*}")
sVal,sMsk,bRc   = "ABCDEFGH", r"ABx*C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "ABxCDEFGH", r"ABx*C", False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "ABxxxCDE", r"ABx*C", False       # 3x 'x'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = "AxCDEFGH", r"ABx*C", False           # no 'B'
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#
#   s:  match:OR:{|}
#

g.f_menuS1("match inclusive OR :{|}")

#   X or Y
sVal,sMsk,bRc   = r"ABxC", r"ABx|yC",False   # inclusive OR
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"AByC", r"ABx|yC",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABxyC", r"ABx|yC",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABzC", r"ABx|yC",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#
#   s:  match.multiplier:{m}
#

g.f_menuS1("match mandatory multiplier :{<m>}")

#   X is [n} times mandatory
sVal,sMsk = r"AxxB", r"Ax{2}B"      # T: 2x X # PHA: using bool(re)
bRc = bool(re.search(sMsk,sVal))
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"AxxxB", r"Ax{2}B",False     # 3x x
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is False)                                   # False

sVal,sMsk,bRc   = r"AB", r"Ax{2}B",False        # no x
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)


#
#   s:  match.set:{[xyz]}     doc:[26.8]
#

#   Exakte Angabe der Werte im set [], maximal nur 1 Wert

g.f_menuS1("match single-set : {[xyz]}")

sVal,sMsk,bRc  = r"ABxCD", r"AB[xyz]CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc  = r"ABxxyzzzCD", r"AB[xyz]CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc  = r"ABzxyCD", r"AB[xyz]CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc  = r"AByzCD", r"AB[xyz]CD",False
if re.search(sMsk,sVal):   # FALSE
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc  = r"AByCD", r"AB[xyz]CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match.range:{[x-z]}
#

#   * Im Bereich suchen, aber nur 1x

g.f_menuS1("match single-range : {[x-y]}")

sVal,sMsk,bRc   = r"ABx1yCD", r"x[1-3]y",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABx1223yCD", r"x[1-3]y",False
if re.search(sMsk,sVal):    # FALSE: zuviele Werte
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = r"ABx5yCD", r"x[1-3]y",False
if re.search(sMsk,sVal):    # FALSE: falsche Zahl
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = r"AxB", r"A[a-z]B",False
if re.search(sMsk,sVal):    # TRUE
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match:setFactor:[]{*,+,?}
#

g.f_menuS1("match factor set- or range : []: <*,+,?,{n}>")

#
#   u:  setFactor
#
g.f_menuS2("setFactor")

#   {*}
sVal,sMsk,bRc  = r"ABxxyzzzCD", r"AB[xyz]*CD",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {*}
sVal,sMsk,bRc  = r"ABCD", r"AB[xyz]*CD",False
if re.search(sMsk,sVal):    # ok: no value
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABxxyzzzCD", r"AB[xyz]+CD",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABxCD", r"AB[xyz]+CD",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABCD", r"AB[xyz]+CD",False
if re.search(sMsk,sVal):    # NOK - no x
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   {?}
sVal,sMsk,bRc  = r"ABxCD", r"AB[xyz]?CD",False
if re.search(sMsk,sVal):    #
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {?}
sVal,sMsk,bRc  = r"ABCD", r"AB[xyz]?CD",False
if re.search(sMsk,sVal):    #
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {?}
sVal,sMsk,bRc  = r"ABxyzyCD", r"AB[xyz]?CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   {n}
sVal,sMsk,bRc  = r"ABxzzyCD", r"AB[xyz]{4}CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {n}
sVal,sMsk,bRc  = r"ABxCD", r"AB[xyz]{4}CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#
#   u:  setRange
#

g.f_menuS2("ranges...")

#   {*}
sVal,sMsk,bRc  = r"ABxxyzzzCD", r"AB[a-z]*CD",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABxxyzzzCD", r"AB[a-z]+CD",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABCD", r"AB[a-z]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   {+}
sVal,sMsk,bRc  = r"ABxzC912D", r"AB[a-z]+C[0-9]*D",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABxC9D", r"AB[a-z]?C[0-9]?D",False
if re.search(sMsk,sVal):    # ok
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   {+}
sVal,sMsk,bRc  = r"ABxyC975D", r"AB[a-z]?C[0-9]?D",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   {n}
sVal,sMsk,bRc  = r"ABxyC975D", r"AB[a-z]{2}C[0-9]{3}D",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match:negation:{^}
#

g.f_menuS1("match set/range-NEGATION")

#   NOT set
sVal,sMsk,bRc   = r"ABxCD", r"AB[^yz]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABzCD", r"AB[^yz]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   NOT range
sVal,sMsk,bRc   = r"ABxCD", r"AB[^1-4]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"AB1xCD", r"AB[^1-4]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = r"AB5xCD", r"AB[^1-4]+CD",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match:position:{^,$}
#
g.f_menuS1("match at POSITIONs : BEGIN=:{^} and/or END=:{$}")

#   seek BEGIN {^x}
sVal,sMsk,bRc   = r"xABC", r"^x",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"AxBC", r"^x",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = r"ABCx", r"^x",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#   seek END {x$}
sVal,sMsk,bRc   = r"ABCx", r"x$",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABCx", r"x$",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   seek BEGIN and END {x$}
sVal,sMsk,bRc   = r"xABCx", r"^x[A-Z]+x$",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#
#   s:  match:predefinedCharClass
#

g.f_menuS1("match with predefined char-classes")

#   alnum
sVal,sMsk,bRc   = r"AB123_", r"[\w]{5}[\w]",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   alnum
sVal,sMsk,bRc   = r"AB123.", r"[\w]{5}[\w]",False
if re.search(sMsk,sVal):   # '.' no AlNum
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is False)

#   alnum
sVal,sMsk,bRc   = r" 123", r"[\w]{3}",False
if re.search(sMsk,sVal):    # '.' no AlNum
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   decimal number (d), D: NOT d
sVal,sMsk,bRc   = r"AB1C", r"AB\d\D",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"AB$3", r"AB\D\d",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   white space : s=WhiteSpace S=NotWhitespace,
sVal,sMsk,bRc   = r"AB  C", r"AB\s\s\S",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   white space
sVal,sMsk,bRc   = r"ABxC ", r"AB\SC\s",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

#   blank   : b=blank B=notB
sVal,sMsk,bRc   = r"  ABC", r"\b\bABC",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"ABCD", r"AB\bC",False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)


#
#   s:  match:bracket:{[]}      doc:[26.13]
#

#   Klammern koennen um jeden Ausdruck erfolgen,
#   Im Verlauf des regExp kann mit (n) auf die n.te Klammer ein Bezug
#   gebildet werden.

g.f_menuS1("brackets")

#   Ein Zahlenmuster, soll sowohl innerhalb als auch ausserhalb stehen
#   Es wird rueckwaertig gesucht
sVal,sMsk,bRc   = r"AB4711xyz:4711", r"([A-Z]+)([1-9]+)([a-z]+):(\2)",False
reRc = re.search(sMsk,sVal)
if reRc:
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMsk,bRc   = r"PQ12ab:12", r"([A-Z]+)([1-9]+)([a-z]+):(\2)",False
tRc = re.search(sMsk,sVal)
if tRc:
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,bRc  = r"PQ21ab:12",False
tRc = re.search(sMsk,sVal)
if tRc:
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

sVal,sMsk,bRc   = r"ABC123DExyz", r"ABC([0-9]+)DE([a-z]?)",False
tRc = re.search(sMsk,sVal)
if tRc:
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
assert (bRc is True)

sVal,sMak,bRc = "ABC:18:ABC18", r"([A-Z]+):([0-9]+):(\1)(\2)", False
tRc = re.search(sMsk,sVal)
if tRc:
    bRc = True
g.f_text("RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))     # False
assert (bRc is False)

#
#   s:  methods: group,start,end
#

g.f_menuS1("methods: group,start,end")
sVal,sMsk,bRc   = r"ABC123DEFGH", r"[0-9]+",False
reRc = re.search(sMsk,sVal)
if reRc:
    bRc = True
assert (bRc is True)

g.f_text("tRc = RE.s('%s','%s') =: %s" % (sVal,sMsk,bRc))
g.f_text("tRc.group =: %s" % reRc.group())
g.f_text("tRc.start =: %s" % reRc.start())   # startPos
g.f_text("tRc.end   =: %s" % reRc.end())     # endPos
assert (bRc is True)

#
#   s:  xml.example
#

g.f_menuS1("xml example")

sVal        = r"<composer>Amadeus</composer>"
sMsk        = r"<([a-z]+)>(\w+)</(\1)"
#               ([a-z]*):   Buchstaben, beliebig oft - REM: [A-Z] means NOT ...
#               (.*)    :   mindestens 1 Zeichen
#               </(\1)> :   das erste Suchmuster x nochmal in </x>

g.f_text("sVal =: %s" % sVal)
bRc = False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s[%s:%s]=:%s" % (sVal,sMsk,bRc))
assert (bRc is True)

# Test1 : missing end-TAG id
sVal    = r"<composer>Amadeus<composer>"
bRc = False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s(%s,%s)=:%s" % (sVal,sMsk,bRc))
assert (bRc is False)

# Test2 : wrong end-TAG
sVal    = r"<composer>Amadeus</computer>"
bRc = False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s(%s,%s)=:%s" % (sVal,sMsk,bRc))
assert (bRc is False)

# Test3: no value => ?PHA: wird nicht erkannt
sVal    = r"<composer></composer>"
bRc = False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s(%s,%s)=:%s" % (sVal,sMsk,bRc))
assert (bRc is False)

# Test4: white spaces only => ?PHA: wird nicht erkannt
sVal    = r"<composer>  </composer>"
bRc = False
if re.search(sMsk,sVal):
    bRc = True
g.f_text("RE.s(%s,%s)=:%s" % (sVal,sMsk,bRc))
assert (bRc is False)

#   ===========================================================================
#   m:  regEx.findAll   doc:[26.15]
#   ===========================================================================

g.f_menu("regExpr.findAll")

bRc     = False
sVal    = r"A fat cat doesn't eat oat but a rat eats bats"
sMsk    = r"[force]at"   # 1 Buchstabe 'f','o','r','c','e' , danach 'at'
lRc     = re.findall(sMsk,sVal)     # returns list with matches
if lRc:
    bRc = True
g.f_text("y=RE.f(%s,%s) => \n\t{%s},{%s}" % (sVal,sMsk,bRc,lRc))
assert (bRc is True)

#   ===========================================================================
#   m:  regEx.compile   doc:[26.17]
#   ===========================================================================

g.f_menu("regExpr.compile")
bRc     = False
sVal    = r"<composer>Amadeus</composer>"
sMsk    = r"<([a-z]+)>(.*)</(\1)"
pReg    = re.compile(sMsk)

bRc = False
if pReg.search(sVal):
    bRc = True
g.f_text("sVal = %s" % sVal)
g.f_text("p->RE.s(sVal,%s)=:%s" % (sMsk,bRc))
assert (bRc is True)

#   ===========================================================================
#   m:  regEx.split     doc:[26.18]
#   ===========================================================================

#   siehe auch str.split [t19]
g.f_menu("regExpr.Split")
sVal    = "A;B;C;D"     # chaper[19]
sMsk    = ";"
lRc     = sVal.split(sMsk)  # returns list
g.f_text("s.split('%s','%s')=:%s" % (sVal,sMsk,lRc))

sVal    = "A B C D"
sMsk    = r"\W+"        # split if !isAlnum
sRc     = re.split(sMsk,sVal)
g.f_text("RE.split(%s,%s)=:%s" % (sVal,sMsk,sRc))

sVal    = r"A;;b,,C.\. D__"
lRc     = re.split(sMsk,sVal)
g.f_text("RE.split(%s,%s)=:%s" % (sVal,sMsk,lRc))

sTxt    = """Logik: Beschreibung
            Obersatz: obere These
            Untersatz: untere These
            Konklusion: Schlussfolgerung
            ."""
sMsk    = r"\w+: "
lRc     = re.split(sMsk,sTxt)
g.f_text("RE.split('%s',x) =: ... {...}" % sMsk)
g.f_text("{%s}" % (lRc))

#   ===========================================================================
#   m:  regEx.Substitute    doc:[26.19]
#   ===========================================================================

g.f_menu("regExpr.Substitute")

sTxt    = 'Yes, I said, "yes we can".'
sSrc    = r"[yY]es"
sObj    = r"NO"
reRc    = re.sub(sSrc,sObj,sTxt)
g.f_text("RE.sub('%s',src='%s',obj='%s') =>\n\t\t{%s}" %
    (sTxt,sSrc,sObj,str(reRc)))

#   === :footer
g.f_footer(sTc)

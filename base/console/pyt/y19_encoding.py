#   coding:UTF8
#   ***************************************************************************
#   My Python Tutorial  :: encoding
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    !content:
        m:  unicode
            s:  define
            s:  show
            s:  unicodeStr=>list
'''

#   === :header
import LIB_inc as m; g = m.CLib(); sTc = "tcEncoding"
g.f_header(sTc)

#
#   m:  unicode
#

# http://python.org/dev/peps/pep-0263/
g.f_menu("unicode")

#   s:  define
g.f_menuS1("define")
us = u'!???????$'      # uniCode-str
#  s_iso88591 = "Hallo ?sterreich"
#  s_unicode  = s_iso88591.decode("iso-8859-1")
#  s_utf8     = s_unicode.encode("utf-8")
g.f_text("typE(us): %s" % (type(us)))
g.f_text("leN(us) : %s" % (len(us)))
g.f_text("us=%s" % (us))

#   s:  show
g.f_menuS1("show")
i = 0
while i < len(us):
    g.f_text(("us[%d]=(%s") % (i,us[i]))
    i += 1
else:
    g.f_text("uniCode string print finished")

#   s:  unicodeStr=>list
g.f_menuS1("convert intoList")
us = u'!abc$'      # einfacher Str als uniCode
l: list[str] = []  # leere Liste
i = 0
while i < len(us):
    l.extend(us[i])
    i += 1
g.f_text("converted List=%s" % (str(l)))


#   === :footer
g.f_footer(sTc)

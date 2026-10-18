#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

import LIB_inc as m;  g = m.CLib();   sTc = 'TcDummy44'

#   === :header
g.f_header(sTc)

#   === :body
g.f_text("myDummy")
s = g.f_sNow()
g.f_text("Now : %s" % s)
g.f_sleep(3)
sDtm,sDif = g.f_sNowDiff()
g.f_text("sDtm.2 : %s" % sDtm)
g.f_text("fDtm.2 : %s" % sDif)

#   === :footer
g.f_footer(sTc)

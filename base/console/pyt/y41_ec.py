#   ***************************************************************************
#   My Python Tutorial  ::  error code
#   ***************************************************************************

#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    use the bash/dos error code
'''

import LIB_inc as m;    g = m.CLib();   sTc = 'TcEc'
import os
import sys


#   === :header
g.f_header(sTc)

sScp    = os.path.basename(sys.argv[0])
g.f_text("iEc.glb(%s):=<%d>" % (sScp,m.g_iEc))
g.f_text("iEc.std(%s):=<%d>" % (sScp,m.C_EC_OK))

#   === :footer
g.f_footer(sTc)

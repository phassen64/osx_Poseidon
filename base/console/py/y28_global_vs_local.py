#   ###########################################################################
#   My Python Tutorial  :: global && local
#   ###########################################################################
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   !FCT:globals,locals
#   !KEY:global

''' Content::
        h=globals() :  shows global defined variables - returns a hash
        h=locals()  :  shows all local defined variables - returns hash
        global      :  defines a reference-variable to a caller
'''

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcGlobalVsLocal'
g.f_header(sTc)

#
#   b:  function
#

def f_tmp(x,y):
    global a        # ike f_tmp(x,y,&a)
    a = 991         # change global a, changes caller 'a'
    x,y = y,x       # exchange locally
    b = 992         # set local
    g.f_trace("a=%d, b=%d, x=%d, y=%d" % (a,b,x,y))
    h = locals()    # replies x,y,b but not a
    g.f_trace("h.local=<%s>" % (h))
    return h

#
#   b:  body
#

g.f_menu("function statement locals()")

a,b,x,y = 1,2,3,4
g.f_text("fBdy1=: a=%d, b=%d, x=%d, y=%d" % (a,b,x,y))

hLoc = f_tmp(17,8)
g.f_text("fBdy2=: a=%d, b=%d, x=%d, y=%d" % (a,b,x,y))
g.f_text("h.local.RET=<%s>" % (hLoc))


g.f_menu("use function globalS of this module")
hGlb = globals()
g.f_text("typE(h)=%s" % (type(hGlb)))
g.f_text("leN(h)=%d"  % (len(hGlb)))

g.f_menuS1("show hash.globals")
g.f_text("h.global=<%s>" % (str(hGlb)))

#   === :footer
g.f_footer(sTc)

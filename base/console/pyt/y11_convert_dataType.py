#   ***************************************************************************
#   My Python Tutorial  :: dataType_converter
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    !content:
        m:  define
        m:  convert
            s:  convert::string<=>{l,t}
                u:  string<=>list
                u:  string<=>tuple
            s:  convert::list<=>{t,e,h}
                u:  list<=>tuple
                u:  list<=>enum
                u:  list<=>hash
            s:  convert::array
                u:  toArray
                u:  fromArray
'''

#   === :header
from array import array
import LIB_inc as m; g = m.CLib(); sTc = 'TcSequences'
g.f_header(sTc)


#   ===========================================================================
#   m:  define
#   ===========================================================================

g.f_menu("define")

#   buildIn:string
s = "ABCD"
g.f_text("s,type,len := <%s>,%s,<%d>" % (s,type(s),len(s)))

#   buildIn:list
l  = [1, "peter", 4.5, True]
lb,li,lf,ls = [True,False,False],[1,45, -5],[1.5, -2.3, 3.6],[u"abx",u"xyz"]
g.f_text("l,type,len => %s,%s,%d" % (l,type(l),len(l)))

#   buildIn:tuple
t = ("Ernie", 2e2, True, "Bert")
g.f_text("t,type,len => %s,%s,%d" % (t,type(t),len(t)))

#   buildIn:enum or set
e = {'A',4711,'C','D'}
g.f_text("enum e:=<%s>" % (e))

#   buildIn:hash or dictionary
h = {"red":"rot","green":"gruen","blue":"blau"}
g.f_text("hash h:=<%s>" % (h))

#   module:array
aI  = array('i', [1, 2, -3])
s='greek'   #   array('utf-8', ['g','r','e','e','k'])
aS_encode   = array('B',s.encode('utf-8'))  # !CRQ-261025
aS_decode   = aS_encode.tobytes().decode('utf-8')

g.f_text("ai        := <%s>" % (aI))
g.f_text("aS.enc    := <%s>" % (aS_encode))
g.f_text("aS.dec    := <%s>" % (aS_decode))

#   for later
aS = aS_decode 

#   ===========================================================================
#   m:  convert
#   ===========================================================================

g.f_menu("convert")

#
#   s:  convert::string<=>{l,t}
#

g.f_menuS1("convert String")

#   u:  string<=>list
g.f_menuS2("s <=> l")
g.f_text("String s:=<%s>" % (s))
g.f_text("List  L:=<%s>" % str(l))
bRc,x = g.f_move_s2l(s)
g.f_text("f.s2l('%s') \t=> {%s},{%s,%d}" % (s,x,type(x),len(x)))
bRc,x = g.f_move_l2s(l)
g.f_text("f.l2s<%s> \t=> {%s},{%s,%d}" % (str(l),x,type(x),len(x)))

#   u:  string<=>tuple
g.f_menuS2("s <=> t")
g.f_text("String s:=<%s>" % (s))
g.f_text("Tuple T:=<%s>" % str(t))
bRc,x = g.f_move_s2t(s)
g.f_text("f.s2t('%s') \t=> {%s},{%s,%d}" % (s,x,type(x),len(x)))
bRc,x = g.f_move_t2s(t)
g.f_text("f.t2s<%s> \t=> {%s},{%s,%d}" % (str(t),x,type(x),len(x)))

#
#   s:  convert::list<=>{t,e,h}
#

g.f_menuS1("convert LIST")

#   u:  :list<=>tuple
g.f_menuS2("l <=> t")
g.f_text("List  L:=<%s>" % str(l))
g.f_text("Tuple T:=<%s>" % str(t))
bRc,x = g.f_move_l2t(l)
g.f_text("f.l2t<%s> \t=> {%s},{%s,%d}" % (str(l),x,type(x),len(x)))
bRc,x = g.f_move_t2l(t)
g.f_text("f.t2l<%s> \t=> {%s},{%s,%d}" % (str(t),x,type(x),len(x)))

#   u:  list<=>enum
g.f_menuS2("l <=> e")
g.f_text("List  L:=<%s>" % str(l))
g.f_text("Enum  E:=<%s>" % str(e))
#   list=>enum
#   bRc,x = g.f_move_l2e(l)
e = set(l)
g.f_text("f.l2e<%s> \t=> {%s},{%s,%d}" % (str(l),x,type(x),len(x)))
bRc,x = g.f_move_e2l(e)
g.f_text("f.e2l<%s> \t=> {%s},{%s,%d}" % (str(e),x,type(x),len(x)))

#   u:  list<=>hash
g.f_menuS2("l <=> h")
g.f_text("List  L:=<%s>" % str(l))
g.f_text("Hash  H:=<%s>" % str(h))
bRc,x = g.f_move_l2h(l)
g.f_text("f.l2h<%s> \t=> {%s},{%s,%d}" % (str(l),x,type(x),len(x)))
bRc,x = g.f_move_h2l(h)
g.f_text("f.h2l<%s> \t=> {%s},{%s,%d}" % (str(h),x,type(x),len(x)))


#
#   s:  convert::array
#

g.f_menuS1("convert ARRAY")

#   u:  toArray
g.f_menuS2("to: ARRAY")
bRc,x = g.f_move_l2a(lb)
g.f_text("f.l2a<%s> \t=> {%s},{typ:%s,len=%d}" % (lb,x,type(x),len(x)))
bRc,x = g.f_move_l2a(li)
g.f_text("f.l2a<%s> \t=> {%s},{%s,%d}" % (li,x,type(x),len(x)))
bRc,x = g.f_move_l2a(lf)
g.f_text("f.l2a<%s> \t=> {%s},{%s,%d}" % (lf,x,type(x),len(x)))
bRc,x = g.f_move_l2a(ls)
g.f_text("f.l2a<%s> \t=> {%s},{%s,%d}" % (ls,x,type(x),len(x)))

#   u:  fromArray
g.f_menuS2("from ARRAY")
bRc,x = g.f_move_a2l(aI)
g.f_text("f.a2l<%s> \t=> {%s},{%s,%d}" % (aI,x,type(x),len(x)))
bRc,x = g.f_move_s2a(s)
g.f_text("f.s2a<%s> \t=> {%s},{%s,%d}" % (s,x,type(x),len(x)))
bRc,x = g.f_move_a2s(aS)
g.f_text("f.a2s<%s>) \t=> {%s},{%s,%d}" % (aS,x,type(x),len(x)))

#   === :footer
g.f_footer(sTc)

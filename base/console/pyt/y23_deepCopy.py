#   ***************************************************************************
#   My Python Tutorial  :: deepCopy
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :header
from copy import deepcopy
import LIB_inc as m;    g = m.CLib();   sTc = 'deepCopy'
g.f_header(sTc)

#   ===========================================================================
#   13.2) pure-Kopie einer Liste
#   ===========================================================================

#   per default werden nur pointer kopiert

g.f_menu("listCopy :pure")
# define
g.f_menuS1("define")
l1 = ["red","green"]
l2 = l1     # copy direct
g.f_text("l1=%s" % (g.f_sList(l1)))
g.f_text("l2=%s" % (g.f_sList(l2)))
g.f_text("id(l1)=%d, id(l2)=%d" % (id(l1),id(l2)))

# change
g.f_menuS1("change")
l1[1] = "blue"
g.f_text("l1.chg=%s" % (g.f_sList(l1)))
g.f_text("l2=%s" % (g.f_sList(l2)))     # changed, altough not touched

# add
g.f_menuS1("add")
l2.append("pink")
g.f_text("l1=%s" % (g.f_sList(l1)))     # changed, altough not touched
g.f_text("l2.add=%s" % (g.f_sList(l2)))


#   ===========================================================================
#   13.4) Kopie mit deepCopy
#   ===========================================================================

g.f_menu("listCopy with:deepCopy")
# define
l1 = ["red","green",[1,2,['x','y'],3],"blue",4711]
lx = deepcopy(l1)
g.f_text("lx=%s" % (lx))

e = "yellow"
l1.append(e)
g.f_text("l1.append(%s)=%s" % (e,l1))
g.f_text("lx =%s" % (lx))

#   ===========================================================================
#   13.5) deepCopy mit Directories
#   ===========================================================================

g.f_menu("deepCopy for: hashes")

h1 = {"US": "USA",
        "DE": "Deutschland",
        "GB": "Great Britain"}


g.f_text("h1.org=%s" % (h1))

g.f_text(">>> I do hx=deepcopy(h1)")
hx = deepcopy(h1)
g.f_text(">>>... and hx['DE']='Germany'")
hx["DE"] = "Germany"

g.f_text("h1=%s" % (h1))
g.f_text("hx.new=%s" % (hx))

#   === :footer
g.f_footer(sTc)

#   ***************************************************************************
#   My Python Tutorial  :: module.sub
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   DES:    shows the content of
#               --main--
#           during call direct | indirect

#   REM:    --name-- := --main--        by direct call
#           --name-- := y10_module_m1   by import by y10_module

#   ===========================================================================
#   b:  helper
#   ===========================================================================

def F_show(p_sStr:str) -> None:
    g.f_text("received : <%s>" % p_sStr)


#   ===========================================================================
#   b:  body
#   ===========================================================================

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcModuleM1'

sName = __name__
g.f_trace("--name-- is =: %s " % sName)     # "--main--" or  "y10_module_m1"

if __name__ == "__main__":
    g.f_text("context:isMain")
else:
    g.f_text("context:isSubm")

#   === :footer
#   no exit

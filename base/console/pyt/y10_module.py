#   ***************************************************************************
#   My Python Tutorial  ::  module
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   url:
#   +   https://docs.python.org/3/reference/import.html
#   +   https://docs.python.org/3/tutorial/modules.html

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcModule'
g.f_header(sTc)

#   import my sub.module
g.f_menu("import my Module")
import y10_module_m1 as p

#   import my sub.module
g.f_menu("using my Module")
p.F_show("Hello Amy")

#   === :footer
g.f_footer(sTc)

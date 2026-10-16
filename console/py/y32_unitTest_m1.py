#   ***************************************************************************
#   My Python Tutorial  ::  unitTest.m1
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :content
'''
    •   m:  begin
    •   m:  random
    •   m:  function F_test
    •   m:  call
    •   m:  show result
'''

if __name__ != "__main__":
    quit()

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcUnit.m1'
import y32_unitTest as u
g.f_textmode(True)

#   m:  begin
g.f_menu("beg:<%s>" % sTc)
g.f_trace("inside")

#   -----------------------------------------------------------------
#   === Modul-Test [32.3]
#   -----------------------------------------------------------------
#   Hilfe und Test werden nur beim direkten Starten des
#   Modules, jedoch nicht beim import ausgegeben.

#   m:  function F_test
def F_test():
    help(u.f_fib)  # Ausgabe der Hilfe
    lSrc = [0,10,15,20]
    lObj = [0,55,610,6765]
    for i in range(0,len(lSrc)):
        iRc = u.f_fib(lSrc[i])
        if (iRc != lObj[i]):
            return False
    return True

#   m:  call
bRc = F_test()

#   m:  show result
g.f_text("m1.resultOfTest := <%r>" % (bRc))

#   === :footer
g.f_text("endOf:<%s>" % sTc)
g.f_exit(m.C_EC_OK,sTc)

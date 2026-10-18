#   ***************************************************************************
#   My Python Tutorial  ::  unitTest.m3: using module unittest
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   REM: test: by class  - real unitTest

if __name__ != "__main__":
    quit()

#   === :content
'''
    •   m:  begin
    •   m:  random
    •   m:  class CFibTest
    •   m:  run
'''

#   === :header
import unittest
import LIB_inc as m;    g = m.CLib();   sTc = 'tcUnit.m3'
import y32_unitTest as u
g.f_textmode(True)

#   m:  begin
g.f_text("begin:<%s>" % sTc)

#   m:  random
iRnd = g.f_iRandom(10)
g.f_text("iRnd:=%d" % iRnd)

#
#   m:  class CFibTest
#
class CFibTest(unittest.TestCase):

    def setUp(self):        # hook-Function
        if (iRnd == 1):
            self.m_eElem = {(0,0),(1,1),(5,77),(10,55),(20,6765)}   # ERROR
        else:
            self.m_eElem = {(0,0),(1,1),(5,5),(10,55),(20,6765)}    # OK
        g.f_text("setUp ends")

    def tearDown(self):     # hook-Function
        self.m_eElem = None
        g.f_text("tearDown ends")

    def testFct(self):     # Name muss mit 'test' beginnen
        g.f_text("testFct")
        for (i,iVal) in self.m_eElem:
            self.assertEqual(u.f_fib(i),iVal)

#   m:  run
g.f_menu("run")
unittest.main()

#   === :footer
g.f_text("endOf:<%s>" % sTc)
g.f_exit(m.C_EC_OK,sTc)

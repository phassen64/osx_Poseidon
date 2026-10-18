#   ***************************************************************************
#   My Python Tutorial  ::  unitTest
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   using modules
#       m1: runs unit.f_fib
#       m2: docStr  >>> u.f_fib(0) 0    ...
#       m3: classTest

#   example
#   If a file containing this code was run directly on the Python runtime,
#       the code associated with the if condition
#   would execute.
#   If the file was imported as a module,
#       the code would not run.


""" Diese Funktion soll getestet werden """
def f_fib(n):
    """ help of FCT:fib function """
    a,b = 0,1
    for _i in range(n):
        a, b = b, a + b
    return a

#   === :header
import os
import pathlib
import LIB_inc as m;    g = m.CLib();   sTc = 'tcUnitTest'
bColor = False

if __name__ == "__main__":
    bColor = True
    g.f_header(sTc,p_bClear=bColor)

#   check called during batch ?
bBachRun,sRc = g.f_bsEnv('v_mode_bBat')
g.f_text("bIsBatch<%s> := <%r>" % (sRc,bBachRun))
sCompiler = g.f_sOsCompiler()

if __name__ == "__main__":
    F   = pathlib.Path(__file__)
    sFileBdy = str(F.stem)
    sFileExt = F.suffix
    sModId   = 'm'
    aFile = []
    for x in range(1,4):
        sFile = sFileBdy + '_' + sModId + str(x) + sFileExt
        aFile.append(sFile)
    g.f_text("aFile:=%s" % (aFile))
    g.f_text("sCompiler:=%s" % (sCompiler))
#
#   Dieses Script wird von den Sub-Scripts importiert,
#   damit die Test-fib-Funktion nur 1x implementiert werden muss.
#   Jedoch soll auch nur diese Fktn sichtbar sein.
#   Achtung: Die Funktion exit kann hier nicht verwendet werden -
#       sie wuerde auch den Importer beenden.

if __name__ != "__main__":
    g.f_trace("name:isSubm")

else:
    g.f_trace("name:isMain")

    #   -----------------------------------------------------------------
    #   === call sub modules
    #   -----------------------------------------------------------------

    #   a) module test
    #   Es die Funktion im module mit einer gesonderten Funktion
    #   ueberprueft.

    if bBachRun is True:

        g.f_trace("runMode:batch")

        # call modules by Batch
        # Die Sub-Module sollen nicht im Batch aufgerufen werden,
        # Sie werden direkt aufgerufen.

        g.f_text("run.batch")
        l = [0,5,10,15,20,25]
        for i in range(0,len(l)):
            n   = l[i]
            iRc = f_fib(n)
            g.f_text("fib(%d) => %d" % (n,iRc))

    else:

        # call modules by this script

        g.f_trace("runMode:main")
        g.f_text("I call sub-scripts now...")

        sHdr = 10 * "="
        t = ('Samba','Walzer','Tango')
        for i in range(0,len(aFile)):
            sFile = aFile[i]
            sText = "&&& main : test[%d][%s] by ['%s']" % (i + 1,sFile,t[i])
            g.f_text(sText)
            #   print("\n")
            os.system(sCompiler + ' ' + sFile + ' -v')

#   === :footer
if __name__ == "__main__":
    g.f_footer(sTc)

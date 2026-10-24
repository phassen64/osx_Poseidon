#   ***************************************************************************
#   My Python Tutorial  :: py2pyargParse
#   ***************************************************************************
#   encoding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   http://stackoverflow.com/questions/3781851/run-a-python-script-from-another-python-script-passing-in-args

#   Frage:
#
#       a) Wie kann ein Python-Script ein anderes aufrufen ?
#       b) Und wie weiss das Python-Script, dass es
#               direkt oder nicht aus einem anderen
#               Script aufgerufen wurde ?
#   Hinweis:
#
#       Der Aufruf kann durch
#               os.system
#       Aber dadurch führt die
#           Abfrage _~name_~ == "_~main_~" bringt nicht
#           zur Unterscheidung, ob der
#           Aufruf direkt oder indirekt erfolgte.
#       Denn os.system() ruft ein Script immer 'main' auf.
#
#   Loesung:
#       Beim Aufruf wird ein extra-Argument uebergeben.
#       Dadurch aendert sich die L?nge des argv,
#           was als Abbruch-Kriterium verwendet wird !


import LIB_inc as m;    g = m.CLib();   sTc = 'tcPy2Py'
import os
import sys


iLenArgs = len(sys.argv)
C_nMaxArgs = 3

#   === :header
if (iLenArgs == 1):
    g.f_header(sTc,True)    # implicitely setColor:=true
else:
    g.f_textmode(True)      # setColor:=true

#   using name not sufficient
#   checking the main expression
s = '_name_ ='
if __name__ == "__main__":
    #   osSystem always calls directly
    s += ':main'
    g.f_text(s,g.C_COLOR_BLUE)
else:
    #   this code never will be reached
    s += ':subr'
    g.f_text(s,g.C_COLOR_YELLOW)

#   show args
g.f_text("len.ArgvNow   =: %d" % (iLenArgs))
if (iLenArgs == 1):
    g.f_text("len.ArgvMax   =: %d" % (C_nMaxArgs))

#   show currently argv
s = g.f_sArgs()
if (iLenArgs == 1):
    s = 'main' + s
    g.f_text(s,g.C_COLOR_BLUE)
else:
    s = 'subr' + s
    g.f_text(s,g.C_COLOR_YELLOW)

#   compiler name
sCompiler = g.f_sOsCompiler()
g.f_text("compiler:%s" % sCompiler)

#   call Me again
if (iLenArgs <= C_nMaxArgs):
    sScp = g.f_sFile(__file__)
    sCmd = sCompiler + ' ' + sScp
    #   build command str for each arg
    i = 0
    while i < iLenArgs:
        i += 1
        sCmd += " " + "dummy" + str(i)
    #   call me
    g.f_text("call python cmd:<%s>" % sCmd)
    g.f_sleep(1)
    os.system(sCmd)

#   === :footer
if (iLenArgs == 1):
    g.f_footer(sTc)

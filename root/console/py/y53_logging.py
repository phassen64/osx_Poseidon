#   coding:UTF-8 no BOM
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   ***************************************************************************
#   My Python Tutorial :: logging
#   ***************************************************************************

'''
    !content:
        m:  test.logger
        m:  test.formatter
'''

import logging
#   from pathlib import Path
import LIB_inc as m

g = m.CLib()
sTc = "tcLogging"

#   :header
g.f_header(sTc)

#
#   m:  test.logger
#

g.f_menu("loggerTest")


#   my own logName
g_sLogname = 'y53_testLoggerAndFormatter.log'

#   Setup the logger
pLogger = logging.getLogger(__name__)
g.f_text(f"name:{__name__}")

#   set logLevel
pLogger.setLevel(logging.DEBUG)

# - Modes
#       DEBUG:      Detailed debug information
#       INFO:       Things working as intended
#       WARNING:    Something unexpected happened
#       ERROR:      The software cannot perform some function
#       CRITICAL:   Program crashes for example

#
#   m:  test.formatter
#

g.f_menu("formatterTest")

#    Formatter, FileHandler
pFormat = logging.Formatter(
    "%(asctime)s:%(levelname)s:%(funcName)s:%(message)s"
)

#   file
sDir  = g.f_sLogDirectory()
sFile = g.f_sJoinFilePath(sDir,g_sLogname)
g.f_text("using logfile: '%s'" % sFile)

#   delete, if exists
bRc,sRc = g.f_bFileDelete(sFile)
g.f_text(f"filePath:{sFile}")

#   get FileObject
X = logging.FileHandler(sFile)
X.setLevel(logging.INFO)
X.setFormatter(pFormat)

#   add FileObject to logger
pLogger.addHandler(X)

#   logging of a divide function
def F_divide(a: int, b: int) -> float:
    try:
        pLogger.info(f"a={a}, b={b}")
        result = a / b
        return result
    except ZeroDivisionError as e:
        pLogger.exception(f"Exception was raised: {e}")
        return 0.0

def F_logging() -> None:
    i = 100; j = 5; g.f_text("Divide(%d,%d) =: %s" % (i,j,F_divide(i,j)))
    i = 30;  j = 6; g.f_text("Divide(%d,%d) =: %s" % (i,j,F_divide(i,j)))
    i = 10;  j = 0; g.f_text("Divide(%d,%d) =: %s" % (i,j,F_divide(i,j)))

if __name__ == "__main__":
    F_logging()

#   :footer
g.f_footer(sTc)

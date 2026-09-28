#   coding:UTF-8 no BOM
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   ***************************************************************************
#   My Python Tutorial :: introduction [2015|2022|2024]
#   ***************************************************************************

#   rem: colorModewith ...
#       $>_runY -Color

#   content:
#   •   m:  comment
#   •   m:  import
#   •   m:  header
#   •   m:  version of python
#   •   m:  footer
#   •   m:  quit===exit

#   keywords:
#   •   import

#   functions:
#   •   f:print()
#   •   f:os.path.dirname()
#   •   f:sys.version()
#   •   f:quit()
#   •   f:exit()

#   url:
#   •   https://docs.python.org/3/tutorial/
#   •   https://www.w3schools.com/python/default.asp
#   •   https://www.geeksforgeeks.org/difference-between-list-vs-set-vs-tuple-in-python/

#   What is Python?
#       Python is a popular programming language.
#       It was created by Guido van Rossum, and released in 1991.
#       It is used for:
#           web development (server-side),
#           software development,
#           mathematics,
#       system scripting.

#   ===========================================================================
#   m:  comment
#   ===========================================================================

#   1)  this is a line comment

#   2)  end of line comment
#       declare a variable and set a coment
#       a = 5  # comment after code

#   3)  multi-line comment - not exist in python
#       but a not assigned string wil be ignored
#       url:https://www.w3schools.com/python/python_comments.asp

'''
    multi-line-string-used-as-comment-1
    multi-line-string-used-as-comment-2
    multi-line-string-used-as-comment-3
'''

#   simple output
print("*** Hello Python Introduction !")

#   ===========================================================================
#   m:  import
#   ===========================================================================

#   import my Library - the file LIB_inc.py as a module
#   internally: #   coding:iso-8859-1

import LIB_inc as m


#   run module globals
m.F_who()
print(m.F_hello())

#   the module contains a class CLib
g = m.CLib()

#   run header function inside my module
#   we retrieve the input environment
#   variable v_FWK_exitCode
#   we call the function with the parameter sTc
sTc = "tcIntro"

#   The header creates a logFile.
#   === :header
g.f_header(sTc)

#   show python version
s = g.f_version()
g.f_text("version : '%s'" % s)

#   run class.hello
g.f_hello()

#   ===========================================================================
#   m:  version
#   ===========================================================================

#   import important libraries
import os
import sys


#   ? Where is python located or installed ?
s = os.path.dirname(sys.executable)
print("installation DIR   : <%s>" % (s))

#   ? Which version of the python interpreter is used ?
s = sys.version
print("interpreter version: <%s>" % (s))

#   ? versionInfo
s = sys.version_info
s = s.__str__()
print("interpreter versionInfo.s: <%s>" % (s))
iMaj = sys.version_info.major
iMin = sys.version_info.minor
print("interpreter versionInfo.x: <%d><%d>" % (iMaj,iMin))

#   ===========================================================================
#   === :footer
#   ===========================================================================
#   The footer stops the script, not the following
#   quit or exit
#   The footer closes the logFile.

g.f_footer(sTc)


#   ===========================================================================
#   m:  quit===exit
#   ===========================================================================

#   ---unreached code

#   The functions 'quit' and 'exit' have the same
#   functionality


quit()  # or
exit()

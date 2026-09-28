#   coding:UTF-8
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ-------$

#   ***************************************************************************
#   My Python Tutorial :: I/O input and output
#   ***************************************************************************

#   content of this chapter:
#       •   m:  output  :   noLineFeed, TabSize
#       •   m:  input   :   with timout

#   functions:
#       •   f:  print()
#       •   f:  input()
#       •   f:  expandtabs()

#   url:    https://docs.python.org/3/tutorial/
#   url:    https://www.w3schools.com/python/default.asp

import msvcrt
import os
import time


#   ===========================================================================
#   m:  output
#   ===========================================================================

print("=*=  menu: print")

#   print text
print("Hello, World!")

#   print with integer
#   variable assignment
i = 4711
print("number output : %d" % (i))

#   print with string and integer
s = "Harvey lebt"
i = 2022
print("String: <%s> and Number: <%d> " % (s,i))

#   output a char with tabulator '\t'
#   treat in 1 line
c = 'A'; s = "character:\tc = %c"  % c; print("Text : <%s>" % (s))

print("=*=  menu: print.NoLineFeed")

#   2 strings in one line
s1 = "Harvey"
s2 = "lebt."
print("<%s>" % (s1),end="")  # Kein Zeilentrenner
print("<%s>" % (s2))

#   3 outputs with 1 space and no implicit newline
print("Anton ",end="")
print("",end="")    # 1 Space, no LF
print("ist da!")

#   output with newline '\n'
print("Thomas\n",end="")
print("ist am Ende!")


print("=*=  menu: print.ChangeTabsize")

#   test tabsize and change it
print("=== Test tabsize")
print("123456789012345678901234567890")
#   run1: standard
s = "\t:run1"; print("%s" % s)
#   run2: usetabsize method
s = "\t:run2".expandtabs(4); print("%s" % s)
#   rund3: standard again
s = "\t:run3"; print("%s" % s)


#   ===========================================================================
#   m:  input <windows>
#   ===========================================================================

#   url: https://thelearninglifetime.com/index.php/python-input-with-timeout/

print("=*=  menu: input")


if os.name == 'posix': print("<<< I leave os!=Windows"); exit()


sRc = ''
iWaitTime = 5
print("\t>>> Enter any text in <%s> seconds" % (iWaitTime))
tDtm = time.time()
while (time.time() - tDtm < iWaitTime):
    if msvcrt.kbhit():
        sRc = input()
        break
if sRc:
    print("\t<<< The input is :'" + sRc + "'")
else:
    print("\t<<< No input.")

#   end

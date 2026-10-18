#   encoding:UTF8
#   ***************************************************************************
#   My Python Tutorial  ::  unitTest.m2:docTest
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   https://docs.python.org/3.5/library/doctest.html#

#   Funktion: Python-DocString als Kommando-Input
#   fuer den Test verwendet.

#   Der Test setzt den Einsatz der interaktiven Python shell voraus.
#   DOS> python
#   Python>>> from t22_unitTest_m2 import f_fib
#   Python>>> f_fib(1) -v

#   ACHTUNG: Die myLib darf nicht verwendet werden.
#   import myLib as g => behindert den docTest

#   Die Methode testmod prueft nach docStr "" Kommentaren und sucht
#   nach Test-Anweisungen.

#   Das Module kann auf 3 verschiedene Arten aufgerufen werden
#   1) durch direkten Aufruf aus DOS
#   2) aus dem upper-Script t22~
#   3) aus dem Batch

"""
Test Beschreibungs
Hier werden die Aufrufe und ihre Ergebnisse eingetragen.
Dabei muss der Python-Prompt verwendet werden.
rem: m2 calls main module m.f_fib()
rem: y=fib(15)=:610 and not 611
>>> u.f_fib(0)
0
>>> u.f_fib(10)
55
>>> u.f_fib(15)
611
>>> u.f_fib(20)
6765
"""

#   === :content
'''
    •   m:  begin
    •   m:  run
'''

if __name__ != "__main__":
    quit()

#   === :header
import doctest
import LIB_inc as m;    g = m.CLib();   sTc = 'tcUnit.m2'
# import y32_unitTest as u
g.f_textmode(True)

#   m:  begin
g.f_text("begin:<%s>" % sTc)
g.f_trace('DTM:=<%s>' % g.f_sDateTime())

#   m:  run
doctest.testmod()

#   === :footer
g.f_text("endOf:<%s>" % sTc)
g.f_exit(m.C_EC_OK,sTc)

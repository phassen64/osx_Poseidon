#   ###########################################################################
#   My Python Tutorial  :: package && modules
#   ###########################################################################
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
#   !url:
#       https://www.geeksforgeeks.org/python-packages/
#       https://docs.python.org/3/tutorial/modules.html
'''
    === module =:
        A module is a single file (or files) that are imported under one
        import and used. e.g.
        https://docs.python.org/3/tutorial/modules.html
                A module is a file containing Python definitions and statements.
                The file name is the module name with the suffix .py appended.
                Within a module, the module name (as a string)
                is available as the value of the global variable "__name__".
    === package =:
        A package is a collection of modules in directories that give
        a package hierarchy.
        package Dir contains: __init__.py
        Packages are directories with modules as files
        dirName = pkgName
'''

#   === :header
import random
import LIB_inc as m;    g = m.CLib();   sTc = 'tcPackage'

#   === :content
'''
        b:  package
        b:  function
        b:  main
'''

#   ===========================================================================
#   b:  package
#   ===========================================================================

#   m:  package: p00
from pkg import y27_p00_info as p

#   m:  package: p01
from pkg.p01_hello import y27_p01_hello

#   m:  package: p02
from pkg.p02_hello_covered.printing import F_hello

#   m:  package: p03
from pkg.p03_hello_add.computations import F_addition
from pkg.p03_hello_add.computations import F_subtraction
from pkg.p03_hello_add.printing import F_hello_world

#   ===========================================================================
#   b:  function
#   ===========================================================================

def F_run_p00() -> None:

    g.f_menu("run:package:p00")

    #   random Number
    iRnd = random.randint(1,1000)   # 1...1000

    #   show call module.function inside the package
    s = F">>>run::pkg.mod.func INP: [ iRnd:<{iRnd}> ]"
    g.f_puts(s,g.C_COLOR_YELLOW)

    #   call the module inside the package
    #   input:   iRndNr
    #   output:  iRc=iRndNr+1 sRc=currentDateTime
    iRc,_sRc = p.F_info_stack(iRnd)

    #   check pkg.mod.func returnCode.iRc
    bRc = False
    if iRc == iRnd + 1:
        bRc = True

    #   show    results
    s = F"<<< get::pkg.mod.func OUT: iRc= <{iRc}> => status: {bRc}"
    g.f_puts(s,g.C_COLOR_YELLOW)


def F_run_p01() -> None:
    g.f_menu("run:package:p01")
    F_hello()

def F_run_p02() -> None:
    g.f_menu("run:package:p02")
    #   F_helloMe()

def F_run_p03() -> None:
    g.f_menu("run:package:p03")
    F_hello_world()
    print(F_addition(1, 1))
    print(F_subtraction(1, 1))

#   ===========================================================================
#   b:  main
#   ===========================================================================

if __name__ == "__main__":
    g.f_header(sTc)
    F_run_p00()
    F_run_p01()
    F_run_p02()
    F_run_p03()
    g.f_footer(sTc)

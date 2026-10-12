@goto L_BODY

:f_info
    @echo =i= info
    @echo vCompiler={%v_COMPILER%}
    @echo vExe={%v_EXE%}
    @echo vSrc={%v_SRC%}
    @echo vObj={%v_OBJ%}
@goto :EOF

:f_init
::  set
    @set v_MyTls=%v_My%\tools
    @set v_PATH=%path%
    @set v_PATH_GNU=%v_MyTls%\MinGW\BIN
    @set v_COMPILER_gpp=g++.exe
    @set v_COMPILER_gcc=gcc.exe
    @set v_EXE=%v_PATH_GNU%\%v_COMPILER_gcc%
    @set v_EXE=%v_COMPILER_gcc%
    @set v_GPP=%v_PATH_GNU%\%v_COMPILER_gpp%
    @set v_PP=-DUSE_EXTERN
    @set v_OPT=-std=c89 -DTEST1
    @set v_OPT=-std=c89 -Wall -ggdb -DTEST1
    @set v_EXT=exe
    @set v_REX="c??_*.c"
@goto :EOF

:f_compile
    @setlocal
    @set fExe=%1%
    @set fSrc=%2%
    @set fObj=%fSrc:~0,3%.%v_EXT%
    @set fObj=%fSrc:~0,-2%.%v_EXT%
    @echo off
    @set path=%path%;%v_PATH_GNU%
    %fExe% %v_OPT% %fSrc% -o %fObj%
    @set path=%v_PATH%
    @echo off
    @endlocal
@goto :EOF

:f_make
    @setlocal
    @set pSrc=%1%
    @call :f_compile %v_EXE% %pSrc%
    @endlocal
@goto :EOF

::  ---------------------------------------------------------------------------
::  body
::  ---------------------------------------------------------------------------

:L_BODY

@cls
@echo off
@call :f_init

@set v_SRC=%1%
:: @echo vSrc1={%v_SRC%}

@echo on
gcc %v_SRC% %v_OPT%
@echo off

::  @call :f_make %v_SRC%



@goto L_END




:L_END
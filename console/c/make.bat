::  *****************************************************************
::  PROGRAM: make <C>  date:190825
::  *****************************************************************

::  program:={!body,!labels,!functions,!doc,!url}
::  usage:= <script> <opt>|<srcfile>
::  example:
::      DOS $> make c01_hello.c   # make an exe-file 'c01_hello.exe'
::      DOS $> make !       # make all
::      DOS $> make x       # make extended (TEST)
::  !url
::  https://www.computerhope.com/forhlp.htm

::  prompt
::  https://learn.microsoft.com/de-de/windows-server/administration/windows-commands/prompt

::
::  =m= !body
::

@cls
@echo off

::
::  =*= :args
::

@call :f_init

@if "%1%" == ""   @goto f_help
@if "%1%" == "?"  @goto f_help
@if "%1%" == "h"  @goto f_help
@if "%1%" == "c"  @goto f_clean
@if "%1%" == "p"  @goto f_prompt
@if "%1%" == "q"  @goto f_rePrompt
@if "%1%" == "i"  @goto f_info
@if "%1%" == "x"  (
    @call :f_make_extended
    @goto L_END
)
@if "%1%" == "o" (
    @call :f_exeShow
    @goto L_END
)

::
::  =*= :init
::

@call :f_scp_info vScpFile vScpDtTime
@call :f_scp_menu !hdr

@set v_SRC=%1%
@if "%v_SRC%" == "!" (
    @call :f_clean
    @for %%i in (%v_REX%) do @call :f_make %%i
) else (
    @echo vSrc1={%v_SRC%}
    @call :f_make %v_SRC%
)

@echo main.vSrc={%v_SRC%}
@call :f_exeShow %v_SRC%
@call :f_scp_menu !ftr

@goto L_END

::
::  =m= !functions
::

:f_clean
    @echo =i= clean...
    @timeout 1 >null
    @echo off
    @if exist "*.obj" del "*.obj" /s
    @if exist "*.exe" del "*.exe" /s
    @if exist "log.txt" del "*.txt" /s
    @if exist "c??.txt" del "c??*.txt" /s
    @if exist "TUTOR_FILE*.txt" del "TUTOR_FILE*.txt" /s
@goto :EOF

:f_info
    @echo =i= info
    @echo vCompiler={%v_COMPILER%}
    @echo vExe={%v_EXE%}
    @echo vSrc={%v_SRC%}
    @echo vObj={%v_OBJ%}
@goto :EOF

:f_help
    @echo =i= help
    @echo make {opt}=
    @echo {h}             ::  help
    @echo {c}             ::  clean
    @echo {i}             ::  info
    @echo {o}             ::  output of all exe files
    @echo {p}             ::  set MYPrompt
    @echo {q}             ::  reSet MYPrompt
    @echo {x}             ::  make extended
    @echo {!}             ::  make all
::
    echo =i= current my drive :{%cd%}
    @goto L_END
@goto :EOF


:f_init
    @set v_MyTls=%v_My%\tools
    @set v_PATH=%path%
    @set v_PATH_GNU=%v_My%\tools\MinGW\BIN
    @set v_COMPILER_gpp=g++.exe
    @set v_COMPILER_gcc=gcc.exe
    @set v_EXE=%v_PATH_GNU%\%v_COMPILER_gcc%
    @set v_GPP=%v_PATH_GNU%\%v_COMPILER_gpp%
    @set v_PP=-DUSE_EXTERN
    @set v_OPT=-std=c89 -DTEST1
    @set v_OPT=-std=c89 -Wall -ggdb -DTEST1
    @set v_EXT=exe
    @set v_REX="c??_*.c"
@goto :EOF

:f_prompt
    :: @set prompt=$p$g
    :: @set prompt $$$c$d;$t$f$g
    :: @set prompt $$[$d;$t]$g
    :: @set prompt $$[$t]$g
    :: @set prompt=--$g
    @prompt [$t]$g
@goto :EOF

:f_rePrompt
    @prompt=$p$g
@goto :EOF

:f_compile
    @setlocal
    @set fExe=%1%
    @set fSrc=%2%
    @rem cut letters : a) first 3 or b) last 2 ?
    @set fObj=%fSrc:~0,3%.%v_EXT%
    @set fObj=%fSrc:~0,-2%.%v_EXT%
::  @echo *** compile:{ exe=%fExe%, src=%fSrc%, obj=%fObj% }
    @echo on
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

:f_exeShow
    @setlocal
    @echo.
    @echo =*= show output executables of:{%v_EXT%}...
    @echo.
::  @set fSrc=%1%
::  @echo fSrc={%fSrc%}
::  @set fObj=%fSrc:~0,3%.exe
::  @set fObj=%fSrc:~0,-2%.%v_EXT%
::     @if "%fSrc%" == "!" (
::         echo +++ showAll
::         @dir *.%v_EXT%
::     ) else (
::         echo +++ showSingle
::         @echo fObj={%fObj%}
::         @dir %fObj%
::    )
    @dir *.%v_EXT%
    @echo =*= end:OfShow
    @endlocal
@goto :EOF

:f_scp_info ( &p1:scpPath; &p2:scpDateTime )
::  reply fileName || filePath
    @set vScpPath=%~nx0
    @set vScpPath=%~f0
    @set vScpPath=%~n0
::  @set vScpDTime=%date%:%time%
    @set vScpDTime=%time%
::  @echo =i= I am in :{%vScpPath%} DT={%vScpDTime%}
    @set "%~1=%vScpPath%"
    @set "%~2=%vScpDTime%"
@goto :eof

:f_scp_menu (p1:sId)
    @set v_sId=%1%
    @echo.
    @echo === %v_sId%:{%vScpFile%}:[%vScpDtTime%]
    @echo.
@goto :eof

::
::  =m= !make extended
::

::  %COMPILER_C%    -c %FILE%.c -o %OBJ1% "-std=c89" -Wall -ggdb  %PP%
::  %COMPILER_C%    -c %FILE%_a.c   -o %OBJ2% "-std=c89" -pedantic -Wall -ggdb  %PP%
::  %COMPILER_CPP%  -c %FILE%_b.c  -o %OBJ3% "-ansi" -Wall -ggdb  %PP%
::  %COMPILER_CPP%  -c %FILE%_c.cpp -o %OBJ4% -Wall -ggdb  %PP%
::  %COMPILER_CPP%  -o %EXE% %OBJ1% %OBJ2% %OBJ3% %OBJ4% -mconsole

:f_make_extended
    @setlocal
    @echo make extended
    @set v_OPT=-std=c89 -Wall -ggdb %v_PP%
    @call :f_compile %v_EXE% c__10_module_a.c
    @set v_OPT=-ansi
    @call :f_compile %v_EXE% c__10_module_b.c
    @set v_OPT=%v_PP%
    @call :f_compile %v_GPP% c__10_module_c.cpp
    @endlocal
@goto :EOF

::
::  =m= !footer
::

:L_END
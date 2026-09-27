@cls

::
::  =m= !main
::

echo *** main

@set v_REX="c??_*.exe"

@call :f_scp_info vScpFile vScpDtTime


@set v_PATH=%path%
@set v_MyTls=%v_My%\tools
@set v_PATH_GNU=%v_MyTls%\MinGW\BIN

@set vLOGFILE=%vScpFile%.log

@call :f_menu HDR
@echo === Run:START:%vScpFile%:%vScpDtTime% > %vLOGFILE%

@for %%i in (%v_REX%) do @call :f_run %%i

@call :f_scp_info vScpFile vScpDtTime
@echo === Run:!ENDE:%vScpFile%:%vScpDtTime% >> %vLOGFILE%
@echo I created local FILE: '%vLOGFILE%'

@call :f_menu END

@goto :eof

::
::  =m= !functions
::

:f_run
    @setlocal
    @set fExe=%1%
    @echo =x= run:{%fExe%}
    @set path=%path%;%v_PATH_GNU%
    ::  @echo %path%
    @call %fExe% >> %vLOGFILE%
    @set path=%v_PATH%
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

:f_menu (p1:sId)
    @set v_sId=%1%
    @echo === %v_sId%:{%vScpFile%}:[%vScpDtTime%]
@goto :eof

:L_END

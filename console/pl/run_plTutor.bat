::
::  =*= :   Tutorial 2019 <RUBY>
::
:: !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿß

@cls
@echo off

::
::  =*= :01 header
::

@if "%1%" == "h"    (
    @call :f_help
    @goto L_END
)
@if "%1%" == "c"    (
    @call :f_clean
    @goto L_END
)
@if "%1%" == "i" (
    @call :f_info
    @goto L_END
)

::
::  =*= :02 body
::

:L_BDY
@set v_ARG_FILE=%1%
::%
@set v_SCP_FILE=%~n0
@set v_SCP_VER=2019-08

::  legacy
@set v_MyTls=%v_FWK_tools%
@set v_COMPILER=%v_MyTls%\perl\bin\perl.exe
@set v_SCP_REG=p??_*.pl
@set v_LOG_ID=logPL

::  logging
@set v_DIR_LOG=%USERPROFILE%%v_USR_scratch_relPath%
@set v_TMPFILE=%v_DIR_LOG%\tmp.txt

:: !CRQ-190825 add tmpLog dir
@if not exist %v_DIR_LOG% (
	@echo *** create tmpLog dir:{%v_DIR_LOG%}
	@mkdir %v_DIR_LOG%
)
@set v_LOG_COMMON=false
@set v_LOG_COMMON=yes
@set v_TC_SUITE_NAME=runTc(PYTHON)

::
@call :f_setDateTime
@set v_SCP_DATETIME=%v_DT_DATE%;%v_DT_TIME%

::
::  =*= :03 program
::


@echo === STRT:  runTc:%v_TC_SUITE_NAME% [%v_SCP_DATETIME%]

::  set my ENV
@call :f_setLogFileNames
@call :f_setEnv

::  show my log and exit codes
echo.
echo +++ DATETIME={%v_DATETIME%} and EXITCODE={%v_FWK_exitCode%}

@call :f_main

@echo.
@echo ==== END!:  runTc:%v_TC_SUITE_NAME% [%v_SCP_DATETIME%]
@goto L_END

::
::  =*= :04 functions
::

:f_main
@if not "%v_ARG_FILE%" == "" (
    @call :f_runTc_single %v_ARG_FILE%
) else (
    @set /A v_CTR_FILE=0
    @set /A v_CTR_ERROR=0
    @echo *** RUN:%v_SCP_VER%:[%v_SCP_DATETIME%] >%v_LOG_FILE_BAT%
    @for %%i in (%v_SCP_REG%) do @call :f_runTc_multi %%i
    @echo.
    @echo + found FILEs={%v_CTR_FILE%} and ERRORs={%v_CTR_ERROR%}
    @echo *** STP:%v_SCP_VER%:[%v_SCP_DATETIME%] >>%v_LOG_FILE_BAT%
)
@call :f_logCopy
@goto :EOF

:f_exe
::  logging into 1 or n files?
@if "%v_LOG_COMMON%" == "yes" (
    %v_COMPILER% %v_FILE% %v_DATETIME% >>%v_LOG_FILE_BAT%
) else (
    %v_COMPILER% %v_FILE% >>%v_LOG_FILE_BAT%
)
@goto :EOF

:f_runTc_multi
@set v_FILE=%1%
@echo.
@echo =*= fRunTc-Multi
@set /A v_CTR_FILE += 1
@echo ... FILE={%v_FILE%}...DATE={%v_DATETIME%}...CTR={%v_CTR_FILE%}
::  show file
:: @dir /B  %v_FILE%
@echo. >>%v_LOG_FILE_BAT%
@echo -*- testFile:%v_FILE% [%time%] >>%v_LOG_FILE_BAT%
::  multi needs sleep - otherwise noexplicit logfile
@call :f_sleep 1
@call :f_exe
@call :f_rc_check
@goto :EOF

:f_runTc_single
@setlocal
@set  v_FILE=%1%
@echo =** fRunTc-Single (%v_FILE%)
@call :f_exe
@call :f_rc_check
@endlocal
@goto :EOF

:f_setEnv
@set v_VERBOSE=true
@set v_COLOR=true
@color 0F
::  define special exit code
@set v_FWK_exitCode=%v_DATETIME:~-4%
@set v_FWK_exitCode=%RANDOM%
@goto :EOF

:f_setDateTime
@set v_DT_DATE=%date%
@set v_DT_TIME=%time%
@set v_DATE_YEAR=%v_DT_DATE:~-4%
@set v_DATE_YEAR_YY=%v_DT_DATE:~-2%
@set v_DATE_MONTH=%v_DT_DATE:~3,2%
@set v_DATE_DAY=%v_DT_DATE:~0,2%
@set v_TIME_HOUR=%v_DT_TIME:~0,2%
@set v_TIME_MINUTE=%v_DT_TIME:~3,2%
@set v_TIME_SECONDS=%v_DT_TIME:~6,2%
@set v_DATETIME=%v_DATE_YEAR_YY%%v_DATE_MONTH%%v_DATE_DAY%
@set v_DATETIME=%v_DATETIME%%v_TIME_HOUR%%v_TIME_MINUTE%%v_TIME_SECONDS%
::  replace chars => Zero
::  http://znil.net/index.php/Windows:Batch_/_DOS-Box:_aktuelles_Datum_und_Uhrzeit_für_Datei-_oder_Verzeichnisnamen_verwenden
setlocal enabledelayedexpansion
@set v_DATETIME=!v_DATETIME:^ =0!
setlocal disabledelayedexpansion
@goto :EOF

:f_setLogFileNames
@set v_TMP=%v_DIR_LOG%\%v_LOG_ID%_%v_DATETIME%
@set  v_LOG_FILE_BAT=%v_TMP%.log
@set  v_LOG_FILE_SRC=%v_TMP%_uno.log
@set  v_LOG_FILE_BAT_COMMON=%v_DIR_LOG%\%v_LOG_ID%.log
@set  v_LOG_FILE_SRC_COMMON=%v_DIR_LOG%\%v_LOG_ID%_all.log
@goto :EOF

:f_logCopy
if exist %v_LOG_FILE_BAT% (
    @echo ... copy.BAT {%v_LOG_FILE_BAT%} TO: {%v_LOG_FILE_BAT_COMMON%}
    @copy %v_LOG_FILE_BAT% %v_LOG_FILE_BAT_COMMON% >> %v_TMPFILE%
)
if exist %v_LOG_FILE_SRC% (
    @if "%v_LOG_COMMON%" == "yes" (
        @echo ... copy.RBY {%v_LOG_FILE_SRC%} TO: {%v_LOG_FILE_SRC_COMMON%}
        @copy %v_LOG_FILE_SRC% %v_LOG_FILE_SRC_COMMON% >> %v_TMPFILE%
    )
)
@goto :EOF

:f_rc_check
@if %ERRORLEVEL% == %v_FWK_exitCode% (
    echo =!= ok:retCode:={%ERRORLEVEL%}
    @goto :EOF
)
@if %ERRORLEVEL% == 100 (
    echo =?= warning:retCode=={100} not {%ERRORLEVEL%}
    @goto :EOF
)
@set /A v_CTR_ERROR += 1
echo ?=? ko:retCode:={%ERRORLEVEL%}
@goto :EOF

:f_sleep
::  sleep.exe at PATH
Timeout %1%
@goto :EOF

:f_clean
@setlocal
@echo *** run clean
@set v_REX=%v_DIR_LOG%\%v_LOG_ID%
@del %v_REX%*.txt
@del %v_REX%*.log
@endlocal
@goto :EOF

:f_info
@echo *** Info
@echo vCompiler=%v_COMPILER%
@echo viEcCode=%v_FWK_exitCode%
@echo vDateTime=%v_DATETIME%
@echo vDirLog=%v_DIR_LOG%
@echo vLogFILE_TC=%v_LOG_FILE_TC%
@echo vLogFILE_BAT=%v_LOG_FILE_BAT%
@goto :EOF

:f_help
@echo *** HELP of Tutorial(%v_SCP_FILE%) [%v_SCP_VER%]
@echo runTc {}              ::  all "%v_SCP_REG%" files will be called
@echo runTc {singleFile}    ::  only one file will be called
@echo runTc {h}             ::  help
@echo runTc {c}             ::  clean
@echo runTc {i}             ::  info
@goto :EOF

::
::  =*= :05 footer
::

:L_END
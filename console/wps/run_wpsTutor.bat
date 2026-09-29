::
::  run windows-psh Tutorial   March-2019 - updt:190822
::

::  usage:
::      PSH>run_shTutor.bat

@cls
@echo off

@set v_CMD_DOS="TRUE"
@set v_ARG_FILE=%1%
::%
@set v_SCP_FILE=%~n0
@set v_SCP_REX=w??_*.ps1
@set v_SCP_VER=2019-08
@set v_LOG_ID=logTutor
@set v_PSH=powershell.exe

@if "%1%" == "h" @goto L_HELP
@if "%1%" == "c" @goto L_CLEAN
@if "%1%" == "l" @goto L_SLEEP_TEST
@if not "%1%" == "" @goto L_ARG_FILE_CHECK
@goto L_RUN

:L_ARG_FILE_CHECK
if not exist %1% (
    @echo The FILE:{%1%} not exists
    @goto L_HELP
)
@goto L_RUN

:L_HELP
@echo *** HELP of Powershell Tutorial(%v_SCP_FILE%) [%v_SCP_VER%]
@echo runPsh {}              ::  all "%v_SCP_REX%" files will be called
@echo runPsh {singleFile}    ::  only one file will be called
@echo runPsh {h}             ::  help
@goto L_END

:L_CLEAN
@echo *** runPsh clean
@del %TMP%\%v_LOG_ID%*.txt
@del %TMP%\%v_LOG_ID%*.log
:: @del %TMP%\%v_SCP_FILE%*.bat
@goto L_END

:L_SLEEP_TEST
@echo *** sleepTest %v_DELAY%
@call :f_sleep 1
@goto L_END

:L_RUN

::
@call :f_setDateTime
@set v_SCP_DATETIME=%v_DT_DATE%;%v_DT_TIME%
@set v_LOG_COMMON=false
@set v_LOG_COMMON=yes
@set v_TMPFILE=%TMP%/tmp.txt

@echo === STRT:  runPSH[%v_SCP_DATETIME%]


::  set my ENV
@call :f_setLogFileNames
@call :f_setEnv

::  show my log and exit codes
echo.
echo +++ DATETIME={%v_DATETIME%} and EXITCODE={%v_FWK_exitCode%}

@call :f_main

@echo.
@echo ==== END!:  runPSH[%v_SCP_DATETIME%]  log={%v_LOG_FILE_BAT%}
@goto L_END

::  ===========================================================================
::  functions
::  ===========================================================================

:f_main
@if not "%v_ARG_FILE%" == "" (
    @call :f_runPsh_single %v_ARG_FILE%
) else (
    @set /A v_CTR_FILE=0
    @set /A v_CTR_ERROR=0
    @echo *** RUN:%v_SCP_VER%:[%v_SCP_DATETIME%] >%v_LOG_FILE_BAT%
    @for %%i in (%v_SCP_REX%) do @call :f_runPsh_multi %%i
    @echo.
    @echo + found FILEs={%v_CTR_FILE%} and ERRORs={%v_CTR_ERROR%}
    @echo *** STP:%v_SCP_VER%:[%v_SCP_DATETIME%] >>%v_LOG_FILE_BAT%
)
@call :f_logCopy
@goto :EOF

:f_exe
:: logging into 1 or n files?
:: echo run File:{%v_FILE%}
@if "%v_LOG_COMMON%" == "yes" (
    %v_PSH% %v_FILE% %v_DATETIME% >>%v_LOG_FILE_BAT%
) else (
    %v_PSH% %v_FILE% >>%v_LOG_FILE_BAT%
)
@goto :EOF

:f_sleep
@set  v_DELAY=%1%
sleep.exe %v_DELAY%
@goto :EOF

:f_runPsh_multi
@set v_FILE=%1%
@echo.
@echo --- fRunPsh-Multi
@set /A v_CTR_FILE += 1
@echo ...FILE={%v_FILE%}...DATE={%v_DATETIME%}...CTR={%v_CTR_FILE%}
::  show file
:: @dir /B  %v_FILE%
@echo. >>%v_LOG_FILE_BAT%
@echo === testFile:%v_FILE% [%time%] >>%v_LOG_FILE_BAT%
::  multi needs sleep - otherwise noexplicit logfile
@call :f_sleep 1
@call :f_exe
@call :f_erl
:: @echo.
@goto :EOF

:f_runPsh_single
@set  v_FILE=%1%
@echo --- fRunPsh-Single (%v_FILE%)
@call :f_exe
@call :f_erl
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
@set  v_LOG_ID=logTutor
@set  v_LOG_FILE_BAT=%TMP%\%v_LOG_ID%_%v_DATETIME%.txt
@set  v_LOG_FILE_PSH=%TMP%\%v_LOG_ID%_%v_DATETIME%.log
@set  v_LOG_FILE_BAT_COMMON=%TMP%\%v_LOG_ID%.txt
@set  v_LOG_FILE_PSH_COMMON=%TMP%\%v_LOG_ID%.log
@goto :EOF

:f_logCopy
if exist %v_LOG_FILE_BAT% (
    @echo ... copy.BAT {%v_LOG_FILE_BAT%} TO: {%v_LOG_FILE_BAT_COMMON%}
    @copy %v_LOG_FILE_BAT% %v_LOG_FILE_BAT_COMMON% >> %v_TMPFILE%
)
if exist %v_LOG_FILE_PSH% (
    @if "%v_LOG_COMMON%" == "yes" (
        @echo ... copy.PSH {%v_LOG_FILE_PSH%} TO: {%v_LOG_FILE_PSH_COMMON%}
        @copy %v_LOG_FILE_PSH% %v_LOG_FILE_PSH_COMMON% >> %v_TMPFILE%
    )
)
@goto :EOF

:f_erl
::  !PHA:Problem
::  The powerShell-scripts got the correct exitCode(%v_FWK_exitCode%),
::      but they are not able to return it like:
::  PSH> exit ($env:v_FWK_exitCode) ... or
::  PSH> exit "$env:v_FWK_exitCode"
::  <<<     This BATCH will got only %ERRORLEVEL%:=1
@if %ERRORLEVEL% == %v_FWK_exitCode% (
    echo !!! ok:retCode:=%ERRORLEVEL%
) else (
    @if %ERRORLEVEL% == 1 (
        echo !=? KK:retCode==1
    ) else (
        @set /A v_CTR_ERROR += 1
        echo ??? ko:retCode:={%ERRORLEVEL%}
    )
)
@goto :EOF

::  ===========================================================================
:L_END
::sleep 1

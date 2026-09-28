@cls

@if "%1" == "" @goto L_HELP
@if "%1" == "d" @goto L_DEBUG

@call :f_clrEnv
@call :f_setEnv
@goto :L_MAIN

:f_clrEnv
@set v_VERBOSE=
@set v_COLOR=
@set v_FWK_exitCode=
@goto :EOF

:f_setEnv
@set v_VERBOSE=true
@set v_COLOR=true
@set v_FWK_exitCode=79
@set v_EXE=ruby.exe
@goto :EOF

:L_MAIN
%v_EXE% %1 %2 %3 %4 %5 %6 %7 %8 %9
:%
@goto L_END

:L_DEBUG
%v_EXE% -rdebug %2.rb %3 %4 %5 %6 %7 %8 %9
@goto L_END

:L_HELP
: @echo DOS: rb <FILE> ["d"]
@echo.
@echo usage :: DOS rb {d} script {p1} {p2} {p3}
@echo.
@goto L_END

:L_END
:: echo ready

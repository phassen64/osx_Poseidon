#   ***************************************************************************
#   TUTORIAL PowerShell:   chapter::introduction            ###:[2024-11-11
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url:https://learn.microsoft.com/de-de/powershell/?view=powershell-7.4

<#
    overview tutorial
        •   p:  intro               •   p:  rex
        •   p:  dataType            •   p:  integer
        •   p:  operator            •   p:  math
        •   p:  condition           •   p:  dateTime
        •   p:  looping             •   p:  file
        •   p:  function            •   p:  csv
        •   p:  class               •   p:  process
        •   p:  array               •   p:  dummy
        •   p:  hash                •   p:  system
        •   p:  string              •   p:  misc
#>

<#
    content:

    •   b:  prepare
        •   m:  function
        •   m:  include

    •   b:  body
        •   m:  header
        •   m:  comment
            •   s:  comment.single.Line
            •   s:  comment.multi.Line
        •   m:  output
            •   s:  Write-Output
            •   s:  Write-Host
        •   m:  run.myFunction
        •   m:  show.thisScriptInfo
            •  s:  scp.member
                •   u:  scp.version
        •   m:  show.thisScriptParameter
            •   s:  para.directly
            •   s:  para.via.function
        •   m:  variable
            •   s:  define.var
            •   s:  check.dataType.var
            •   s:  EnvironmentVariable write&&read
        •   m:  show.debugInfo
        •   m:  show.logFile
        •   m:  executionPolicy
        •   m:  footer
#>

#   ###########################################################################
#   b:  prepare
#   ###########################################################################

#   m:  function

function f_helloWorld {
    puts "helloWorld"
}

#   m:  include

.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


#   ###########################################################################
#   b:  body
#   ###########################################################################


#
#   m:  header
#

f_lib_header(__LINE__)

<#
 #  This function starts in the tutorial.
 #  It generates start date, logfile , etc.
 #>

#   write a multi-line string
Write-Host @"
=== :   PSH intro
        m:  comment
        m:  output
        m:  run.myFunction
        m:  show.thisScriptInfo
        m:  show.thisScriptParameter
        m:  variable
        m:  EnvironmentVariable write&&read
        m:  show.debugInfo
        m:  show.logFile
"@

#
#   m:  comment
#

#   s:  comment.single.Line

#   single-line with '#'

#   s:  comment.multi.Line
<#
    multi-line with '<#' ... '#>''
#>


#
#   m:  output
#

<#
    Write-Output vs  Write-Host
        �   writing into stream
        �   writing to screen
#>

#   s:  Write-Output
<# Write-Output
     [-InputObject] <PSObject[]>
     [-NoEnumerate]
     [<CommonParameters>]
    --- Writes the specified objects to the pipeline.
        If Write-Output is the last command in the pipeline,
            the objects are displayed in the console.
#>

Write-Output "The psh tutorial 2024"

#   s:  Write-Host
<#  Write-Host
     [[-Object] <Object>]
     [-NoNewline]
     [-Separator <Object>]
     [-ForegroundColor <ConsoleColor>]
     [-BackgroundColor <ConsoleColor>]
     [<CommonParameters>]
    --- The Write-Host cmdlet's primary purpose is to produce
            for-(host)-display-only output,
            such as printing colored text like when prompting the user
            for input in conjunction with Read-Host.
        Write-Host uses the ToString() method to write the output.
            By contrast, to output data to the pipeline,
            use Write-Output or implicit output.
#>

Write-Host "`twritten by Peter.`n" -ForegroundColor 'Yellow'

#
#   m:  run.myFunction
#

#   show trace, if option verbose
trace(__LINE__)(__FILE__) 'helloWorld'

#   call my Function
f_helloWorld

#   perform a delay
delay(1)

#
#   m:  show.thisScriptInfo
#

#   menu entry
f_lib_menu "showScp" (__LINE__)

puts "`tshow some script data" $C_sColor_info

#   s:  scp.member
f_lib_menuS1 "member" (__LINE__)
$s = $script:g_hScpMem.m_cDrv; f_lib_text "scp.Drv:{$s}"
$s = $script:g_hScpMem.m_sDir; f_lib_text "scp.Dir:{$s}"
$s = $script:g_hScpMem.m_sPth; f_lib_text "scp.Pth:{$s}"
$s = $script:g_hScpMem.m_sNam; f_lib_text "scp.Nam:{$s}"
$s = $script:g_hScpMem.m_sExt; f_lib_text "scp.Ext:{$s}"

#   u:  scp.version
f_lib_menuS2 "lib version" (__LINE__)
$sDtm = f_lib_dtm 'yyyy-MM-dd HH:mm:ss'
text "dtmLib   :   {$sDtm}"


#
#   m:  show.thisScriptParameter
#

f_lib_menu "parameter" (__LINE__)

#   s:  para.directly
f_lib_menuS1 "directly" (__LINE__)
text "para.sScp       :{$p__sScp}"
text "para.bVerbose   :{$o__bVerbose}"
text "para.bColor     :{$o__bColor}"

#   s:  para.via.function
f_lib_menuS1 "via function" (__LINE__)
$sRc = f_lib_script_getParamter
text "scpPara:{$sRc}"


#
#   m:  variable
#

f_lib_menu "variable" (__LINE__)


#
#   s:  define.var
#

f_lib_menuS1 "define" (__LINE__)

#   define simple
$x = 123                #   variable of type integer
[int] $i = 1            #   using dataType specifier for integer
[string] $s = 'peter'   #   string
[bool] $b = $true
[array] $a = 1,'a'      #   array

#   show this variables
f_lib_text "x: <$x>"
f_lib_text "i: <$i>"
f_lib_text "s: <$s>"
f_lib_text "b: <$b>"
f_lib_text "a: <$a>"

#
#   s:  check.dataType.var
#

f_lib_menuS1 "checkDataType" (__LINE__)

$sRc = f_lib_getType($x);           f_lib_text "type(x)     :   '$sRc'"
$bRc = f_lib_isType_boolean($b);    f_lib_text "isBoolean   :   {$b}"
$bRc = f_lib_isType_int($i);        f_lib_text "isInt       :   {$i}"
$bRc = f_lib_isType_array($a);      f_lib_text "isArray     :   {$a}"
$bRc = f_lib_isType_string($a);     f_lib_text "isString    :   {$s}"

#
#   s:  EnvironmentVariable write&&read
#

f_lib_menuS1 "show.environmentVariable" (__LINE__)

#   create and write an Environment-Variable
$s = $(Get-Date).ToString('yyMMdd')         # year-month-day
$env:v_test_sVal = 'WpsTutorial:' + $s

#   readIt
$v = $env:v_test_sVal

#   showIt
$s = '$env:v_test_sVal' + '=: <' + $v + '>'
text $s (__LINE__)

#   test with
<#
    ps7$>   gci env:v* |sort
#>

#
#   m:  show.debugInfo
#

f_lib_menu "showDebugInfo" (__LINE__)

$i = (__LINE__)
text "debug.__LINE__:{$i}"
$s = (__FILE__)
text "debug.__FILE__:{$s}"
$s = (__FUNCTION__)
text "debug.__FUNCTION__:{$s}"

#
#   m:  show.logFile
#

f_lib_menu "logging" (__LINE__)
text "mode.logMode:<$p__iLogMode>"
if ($p__iLogMode -gt 0) {
    $s  = $global:g_pLogTranscript
    puts "`tlogFile:<$s>" $C_sColor_file
}

#
#   m:  executionPolicy
#

#   https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.5

f_lib_menu "executionPolicy" (__LINE__)
$s = Get-ExecutionPolicy
text "ExecutionPolicy := <$s>"    # <RemoteSigned>

#   show
Get-ExecutionPolicy -List

#
#   m:  footer
#

#   always at end
f_lib_footer(__LINE__)


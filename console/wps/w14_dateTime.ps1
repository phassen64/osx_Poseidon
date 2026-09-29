#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::dateTime               ###:[2024-11-27]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url:    https://powershellbyexample.dev/post/time-and-date/
#   !CRQ-241130:PS5.noUnixTime    : !PS7.unixTime

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  DateTime (DTM)
            •   s:  GetDtm
            •   s:  GetUnixDtm
            •   s:  DTM.parse::(s)
            •   s:  DTM.parse::(s,fmt)
            •   s:  DayOfYear
            •   s:  LeapYear
        •   m:  timer
            •   s:  TimeSpan
    •   b:  footer
#>
<#
    DateTime Formate (US)
    *   long        DD/MM/YYYY      example: 06/28/2021 => 28.Juni 2021
    *   short       DD/MM/YY        example: 06/28/21
    *   very short  DD/MM           example: 06/28
    *   hour:min    DD/MM/YYYY HH:mm     example: 06/28/2021 15:45
    *   hour:min    HH:mm           example: 15:45 => 07.Juli2021 15:45
#>

#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


#
#   b:  function
#

function F_iTimeSpan2Sec([TimeSpan]$p_tRunTime) {
    #   calc
    $iSec   =   $p_tRunTime.Seconds
    $iSec   +=  $p_tRunTime.Minutes * 60
    $iSec   +=  $p_tRunTime.Hours   * 60 * 60
    $iSec   +=  $p_tRunTime.Days    * 60 * 60 * 24
    #   return
    return $iSec
} # F~iTimeSpan2Sec

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH dateTime
        m:  define
        m:  timer
'@

#   menu
$g_sColor_text  =       $C_sColor_std
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'
$g_hMenuTabulator['out'] =  $g_hMenuTabulator['spc']


#   ===========================================================================
#   m:  define
#   ===========================================================================

f_lib_menu("define.DateTime")(__LINE__)

#   s:  GetDtm
$t = Get-Date
text("dtm = <$t>") (__LINE__)

#   dateTime.raw
$t = Get-Date -UFormat "%A %m/%d/%Y %R %Z"
text("dtm = <$t>") (__LINE__)

#   s:  GetUnixDtm
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.unixTime

    #   sec.0
    $t = Get-Date -UnixTimeSeconds 0
    text("dtm.unix = <$t>") (__LINE__)

    #   sec.max
    $t = Get-Date -UnixTimeSeconds 1577836800
    text("dtm.unix = <$t>") (__LINE__)
}

#   formatted dtm
$F = 'yyMMdd_HHmmss'
$s = Get-Date -Format $F
text("dtm ('$F') : <$s>") (__LINE__)

#   format stored dtm-object into string
$F = 'yyyy-MM-dd_HH:mm:ss'
$p = Get-Date
$s = $p.ToString($F)
text("dtm ('$F') : <$s>") (__LINE__)

#   s:  DTM.parse::(s)
$s = '26-Nov-1985 19:30:10'
$p = [DateTime]::Parse($s)
assert($p -is [DateTime])(__LINE__)
$F = 'MMM-yyyy-dd HHmm'
$s = $p.ToString($F)
text("dtm.parse ('$s')") (__LINE__)

#   s:  DTM.parse::(s,format)
$s = '1964_09_07_09_00_00'
$F = 'yyyy_MM_dd_HH_mm_ss'
$p = [DateTime]::ParseExact($s,$F,$null)
assert($p -is [DateTime])(__LINE__)
$F = 'yyMMdd-HHmmss'
$s = $p.ToString($F)
text("dtm.parseExact ('$s')") (__LINE__)

#   s:  DayOfYear
$i = (Get-Date).DayOfYear
text("dtm DayOfYear =: <$i>") (__LINE__)

#   s:  LeapYear
$s = '01-Jan-1964 19:30:10'; $p = [DateTime]::Parse($s)
$s = $p.ToString('yyyy')
$bLeapDayYear = [DateTime]::IsLeapYear($p.year)
text("dtm leapDayYear<$s> =: <$bLeapDayYear>") (__LINE__)
$s = '01-Jan-2024 19:30:10'; $p = [DateTime]::Parse($s)
$s = $p.ToString('yyyy')
$bLeapDayYear = [DateTime]::IsLeapYear($p.year)
text("dtm leapDayYear<$s> =: <$bLeapDayYear>") (__LINE__)

#   ===========================================================================
#   m:  timer
#   ===========================================================================

f_lib_menu("timer")(__LINE__)

#   timer.start
$tStart = Get-Date

text("runDelay") (__LINE__)
f_lib_delay(1)

#   timer.stop
$tStopp = Get-Date

#   s:  TimeSpan
$tRunTime   =    $(New-TimeSpan $tStart $tStopp)

#   calc into integer
$iRunTime   =    F_iTimeSpan2Sec($tRunTime)

#   show
text("runTime:<$iRunTime>") (__LINE__)


#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

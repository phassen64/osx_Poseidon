<#
    PROGRAM     :   Python-Tester <PY>

    Author      :   P.Hassen
    Organization:   mATe64 UG
    Date        :   08.12.2024

    encoding    :   UTF8-noBOM
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

    rem :   run.logging:=true is default - to disable with : mode.raw:=true
    pyenv:  https://realpython.com/intro-to-pyenv/
            $>_pyVer -v311
    usage  :
        $>  <scp> -p_sCmd <parameter> [<option>]
        <parameter>  =    {
            -p_sCmd     =:  <src> | <flag> | *<rex>
            -p_iRepeat  <nCount>
        }
        <scp>       :=  $MyInvocation.MyCommand.Name
        <src>       :=  exact source file name
        <flag>      :=  {'!','+','?','c','e'}
                            !           :   take all objects
                            +           :   random amount of objects
                            *           :   rex starter
                            ?           :   show usage
                            c|e         :   clear/erase scratch
        <rex>       :=  RegularExpressionn like 'y??.py'
        <nCount>    :=  [1..99] :  run found objects n times
        <option>
            -o_raw      :   output directy to screen && disable run.logging
            -o_logging  :   src.logging logMode=1
            -o_auto     :   src.logging logMode=2 autonamed src.logFile
            -o_verbose  :   src.verbose
            -o_color    :   src.color - affects mode:raw
            -o_debug    :   debug run of this script(trace&&info)
            -o_reset    :   reset EnvironmentVariables after run
            -o_use__vpy :   try vpython <=> python
            -o_help     :   show help

    example :
        $>  <scp> -o_help           :   show usage
        $>  <scp> c                 :   clear scratch
        $>  <scp> -p_sCmd 'y01.py'  :   run this object
        $>  <scp> -p_sCmd '!' -p_iRepeat 2 -p_sRex 'y1*.py'
                            :   run all objects matches
        $>  <scp> !         :   run all
        $>  <scp> ! 5       :   run all 5 times
        $>  <scp> + 3       :   run [2,..n] objects 3 times
        $>  <scp> ! 1 'y*.py'  :   run match  'y*.py' run all 1 time
        $>  <scp> -p_sCmd '*y1?*.py'   # use all y?3

    scratch directory :
        "$env:UserProfile\temp"

    streaming:
        Window STREAMs
            1:output/success
            2:error
            3:warning
            4:verbose
            5:Debug
            6:Progress
            7:Output
#>

<#
    content:

    •   b:  parameter
        •   s:  define.parameter
        •   s:  copy.parameter
        •   s:  adjust.parameter
    •   b:  function
        •   f:  usage
        •   f:  scratch
            •   s:  scratch.clear
            •   s:  scratch.validate
        •   f:  location
        •   f:  library
            •   s:  lib.host
            •   s:  lib.isString, lib.isFile, lib.isDrive
            •   s:  lib.dateTime
            •   s:  lib.timer
            •   s:  lib.exit
            •   s:  lib.print
        •   f:  environment
        •   f:  logging
            •   s:  log.prepare
            •   s:  log.perform
        •   f:  debug.log.information
            •   s:  debug.log.info
            •   s:  debug.log.info
        •   f:  menu
            •   s:  menu.ec
            •   s:  menu.show
            •   s:  menu.header
            •   s:  menu.footer
            •   s:  menu.menu
        •   f:  compile
        •   f:  command.mode
    •   b:  body
        •   m:  !key
        •   m:  debug
        •   m:  constant
            •   s:  const.os
            •   s:  const.color
            •   s:  const.menu
            •   s:  const.program
        •   m:  alias
            •   s:  alias.location
            •   s:  alias.control
            •   s:  alias.exit
        •   m:  global
            •   s:  glob.scp
            •   s:  glob.scratch
                •   u:  scratch.dir
                •   u:  scratch.space
            •   s:  glob.exitCode
            •   s:  glob.program
            •   s:  glob.EnvironmentVariable
        •   m:  program
            •   s:  do.read.parameter.cmd
            •   s:  do.set
            •   s:  do.run.prepare.logging
            •   s:  do.menu.header
            •   s:  do.prepare
                •   u:  fetch.pGci
                •   u:  handle.mode : aSrc => aObj
                •   u:  info.show.objects
            •   s:  do.show.body
            •   s:  do.perform.test
            •   s:  do.menu.footer
    •   b:  end
#>
#   ###########################################################################
#   b:  parameter
#   ###########################################################################

#   s:  define.parameter
param(  # 10 para
    [string]    $p_sCmd,                #   e:{'+','!','c'} or <src> or <rex>
    [int]       $p_iRepeat  = 1,        #   stress counter
    [switch]    $o_raw,                 #   run.raw only - run.logging:=false
    [switch]    $o_logging,             #   src.logging logMode = 1
    [switch]    $o_auto,                #   src.logging logMode = 2
    [switch]    $o_verbose,             #   TC.bVerbose
    [switch]    $o_color,               #   TC.bColor - for run.raw
    [switch]    $o_debug,               #   mode:debugThisScript
    [switch]    $o_reset,               #   mode:resetEnviromentVariableAfterRun
    [switch]    $o_use__vpy,            #   try vpython
    [switch]    $o_help                 #   run usage
)

#   s:  copy.parameter
[string]    $v__sCmd            =   $p_sCmd
[string]    $v__sRex            =   $C_sRexStd
[int]       $v__iRepeat         =   $p_iRepeat

#   s:  adjust.run.stress
$C_iRepeat_max = 80
if ($v__iRepeat -gt $C_iRepeat_max) {
    $v__iRepeat = $C_iRepeat_max
}

#   s:  adjust.run.logging
$v__bLogging = ! $o_raw

#   ###########################################################################
#   b:  function
#   ###########################################################################

#   f:  usage
function f__usage() {
    _show "begin of usage"
    $s = "`$> .\'$g_sScpFnm' <parameter> <option>"
    $d = $script:g_sScratchDir
    Write-Host $s
    Write-Host @"
    <parameter>  =    {
        -p_sCmd     =:  <src> | <flag> | *<rex>
        -p_iRepeat  =:  1..$C_iRepeat_max repeat tc <n> times =: 'StressCounter'
    }
    <src>           =:  $C_sSrcUno
    <flag>          =:  !:all +:some c:clear *:IsRexPrefix
    <rex>           =:  {'$C_sRexStd'} ...
    <option>  =    {
        -o_logging  =:  mode.log : logging into dir:'$d'
        -o_auto     =:  mode.log and autonaming of logFiles
        -o_raw      =:  mode.raw : output to screen - instead of logging
        -o_verbose  =:  set TC.verbose
        -o_color    =:  set TC.colored  - affects mode.run
        -o_debug    =:  debug thisScript '$g_sScpFnm' and reset
        -o_reset    =:  reset environment after run
        -o_use__vpy =:  using vpython
        -o_help     =:  print this text
    }
    *   my scratch directory is =:
                '$d'
"@
    _show "end of usage." ($true)

} # f~~usage

#   f:  scratch

#   s:  scratch.clear
function f_runTmp_scratchClear() {
    $x = $script:g_sScratchDir
    if (Test-Path $x  -PathType 'Container') {
        $pGci = Get-ChildItem $x
        $iGci = $pGci.Length
        if ($iGci -eq 0) {
            _puts "<<< scratch already empty:<$x>"
        } else {
            try {
                Remove-Item $x -Recurse
                _puts "<<< cleared:<$x>"
            } catch {
                _puts "--- tried.clear:<$x>"
            }
        }
        Start-Sleep 1
    } else {
        _puts "<<< scratch not found:<$x>"
    }
} # f~scratch~Clear

#   s:  scratch.validate
function f_runTmp_scratchCreateIfNotExist() {
    $x = $script:g_sScratchDir
    if (!(Test-Path $x -PathType Container)) {
        $script:sRc = New-Item $x -ItemType 'Directory'
        _puts "--- created:<$x>"; Start-Sleep 2
    }
    $bExist = Test-Path $x -PathType 'Container'
    if (! $bExist ) {
        _bug("scratchCreate")(__LINE__); exit
    }
} # f~scratch~CreateIfNotExist
#   ============================================================================
#   f:  location
#   ============================================================================

function f_runLoc_getScriptName {
    $MyInvocation.MyCommand.Name
}

function f_runLoc_getCurrentFileName {
    $MyInvocation.ScriptName
}

function f_runLoc_getCurrentLineNumber {
    $MyInvocation.ScriptLineNumber
}

#   ============================================================================
#   f:  library
#   ============================================================================

#
#   s:  lib.host
#

function f_runLib_setHost([string]   $p_sForegroundColor = 'White',
                     [string]   $p_sBackgroundColor = 'Black')
{
    if ( ($C_aHostColor -contains $p_sForegroundColor) -and `
         ($C_aHostColor -contains $p_sBackgroundColor) -and `
         ($p_sForegroundColor -ne $p_sBackgroundColor) )
    {
        if ( $o_debug ) {
            Write-Host "resetHost"
            Start-Sleep 1
        }
        $host.UI.RawUI.ForegroundColor = $p_sForegroundColor
        $host.UI.RawUI.BackgroundColor = $p_sBackgroundColor
        #   Clear-Host  # clears screen
    }
} # f~lib~reset

#
#   s:  lib.isString, lib.isFile, lib.isDrive
#

function  f_runLib_isString([string] $p_sString) {
    if ( ( $p_sString -eq $null) `
                -or ( [string]::IsNullOrEmpty($p_sString) ) `
                -or ( [string]::IsNullOrWhiteSpace($p_sString) ) )
    {
            return ($false)
    }
    return $true
} # f~lib~isString

function  f_runLib_isFile([string] $p_sString) {
    if (!(f_runLib_isString($p_sString)))  {
        return ($false)
    }
    if (!(Test-Path $p_sString -PathType Leaf)) {       # mustExist
        return ($false)
    }
    return $true
} # f~lib~isFile

function f_lib_isDriveLetter([string] $p_sString) {
    if (!(f_lib_isString($p_sString)))  {
        return ($false)
    }
    $cDrv = $p_sString[0]
    $aDrv = (Get-Volume).DriveLetter
    foreach ($xDrv in $aDrv) {
        if ($xDrv -eq $cDrv) {
            return $true
        }
    }
    return $false
} # f~lib~isDrive


#
#   s:  lib.dateTime
#

function f_runLib_sDateTime([string]$p_sFmt='yyMMddHHmmss',
                            [DateTime]$p_tDateTime) {
    if ( $p_tDateTime -eq $null ) {
        $sDate = Get-Date -Format $p_sFmt
    } else {
        $sDate = $p_tDateTime.ToString("$p_sFmt")
    }
    return $sDate
} # f~lib_sDateTime

#
#   s:  lib.timer
#

function f_runLib_delay($p_iDelay = 0) {
    if ( $o_debug ) {
        Write-Host "--- continue in <$p_iDelay>"
    }
    for ( $i = 0; $i -lt $p_iDelay; $i++) {
        Start-Sleep 1
        Write-Host '.' -ForegroundColor $C_sColor_status -NoNewLine
    }
    Write-Host ';'
} # f~lib~delay

#
#   s:  lib.exit
#

function f_runLib_exit(   [string] $p_sText,
                        $p_iLineNr = -1)
{
    $sFct = (Get-PSCallStack)[1].FunctionName
    $s = '&&& '
    $s += "bug:[$sFct]"
    $s += ":'$p_sText'"
    if ($p_iLineNr  -gt 0) {
        $s += " at:[$p_iLineNr]"
    }
    Write-Host $s -ForegroundColor $C_sColor_exit
    Write-Host "... leave!"
    f_runLib_delay(1)
    exit -($p_iLineNr)

} # f~bug


#
#   s:  lib.print
#

function  f__print( [string] $p_sString,
                    [string] $p_sColor = $C_sColor_std,
                    [switch] $o_NoNL) {
    if (!(f_runLib_isString($p_sString))) {
        _bug("printStringEmpty")(__LINE__); exit
    }
    if ($script:g_bColor) {
        Write-Host $p_sString -ForegroundColor $p_sColor -NoNewLine:$o_NoNL
    } else {
        Write-Host $p_sString -NoNewLine:$o_NoNL
    }
} # f~~print

function  f_runLib_print([string] $p_sString, [string] $p_sColor = $C_sColor_std)
{
    f__print -p_sString $p_sString -p_sColor $p_sColor -o_NoNL
} # f~lib~print

function  f_runLib_puts(    [string] $p_sString,
                            [string] $p_sColor =  $C_sColor_std )  {
    f__print -p_sString $p_sString -p_sColor $p_sColor
} # f~lib~puts



#
#   f:  environment
#

function f_runEnv_setPath( [bool] $p_bEnabled = $false ) {
    $aPath = @()
    #   path.WindowsSystem
    $x = Get-ChildItem env:SystemRoot;      $aPath += $x.Value
    $x = "$env:SystemRoot\system32";        $aPath += $x
#   $x = "$env:ProgramFiles\Powershell\7";  $aPath += $x     # not needed
    $x = "$PSHOME";                         $aPath += $x
    #   path.local
    $x = '.';                               $aPath += $x
    #   PATH:=new - save
    $sPath  = [system.String]::join(';', $aPath)
    #   using this new path
    if ($p_bEnabled) {
        $env:path = $sPath
    }
    return $null
} # f~path


#
#   f:  logging
#

<#
    s:  log.prepare

    ---  used input and output-parameter
    i   :  g_sDtmPostfix
    i/o :  g_bLogging
    i   :  g_sScpPth
    i   :  g_sScratchDir
    i   :  g_hScratch.m_pLog
#>
function f_runLog_prepare (
        [string] $p_sFix = $script:g_sDtmPostfix )  {

    #   check logging state
    if ( $script:g_bLogging ) {
        return $false
    }

    #   simple usage
    $dLog = $script:g_sScratchDir

    #   create Scratch, if not exists
    if (! (Test-Path $dLog -PathType 'Container')) {
        return $false
    }

    #   fetch Scp
    $pScp = $script:g_sScpPth
    $sBdy = (Get-Item $pScp).Basename        #   'peter'
    $sExt = '.log'

    #   build logFile       'x:\peter.txt'
    $sBdy = $sBdy + '_'
    if ( $v__bAutoNaming ) {
        $sBdy += $p_sFix
    } else {
        $sBdy += $script:g_sPSH_id
    }
    $sNam = $sBdy + $sExt
    $pLog = $dLog + $C_cSepDirectoryPath + $sNam

    #   save logFilePath into scratchSpace
    $global:g_hScratch.m_pLog = $pLog

    #   set to logging to TRUE
    $script:g_bLogging  =  $true

    #   everything is fine
    return $true

} # f~log~prepare


#
#   s:  log.perform
#
function  f_runLog_perform(  [string] $p_sString,
                        [string] $p_sColor =  $C_sColor_std,
                        [switch] $o_visible,
                        [switch] $o_create) {
    if ($o_visible) {
        f__print -p_sString $p_sString -p_sColor $p_sColor
    }
    if ($script:g_bLogging) {
        $pLog = $global:g_hScratch.m_pLog
        if ($o_create) {
            $sDtm = $script:g_sDtmPostfix = f_runLib_sDateTime('yyMMdd_HHmmss')
            "### created:<$sDtm>:'$pLog'" | Out-File $pLog
            $p_sString | Out-File $pLog -Append
        } else {
            $p_sString | Out-File $pLog -Append
        }
    }
} # f~log~perform




#
#   f:  debug.log.information       only if o_debug:=true
#

#   s:  debug.log.info
function  f_runBug_info([string] $p_sText,
                [int]    $p_iLine   = - 1,
                [string] $p_sColor  = $C_sColor_silent,
                [bool]   $p_bEnable = $script:g_bInfo,
                [switch] $o_Beauty)
{
    $s = $g_hMenuTabulator['men'] + "i:`t"
    $s += $p_sText
    if ($o_Beauty) {
        $sColor  = $C_sColor_info
    } else {
        $sColor = $p_sColor
    }
    if ($p_iLine -gt 0) {
        $s += " at:[$p_iLine]"
    }
    f_runLog_perform -p_sString $s -p_sColor $sColor -o_visible:$p_bEnable
} # f~bug~info


#   s:  debug.log.trace
function f_runBug_trace (
        $p_iLine  = -1,
        $p_sFile  = $null,
        $p_sText  = '?',
        $p_bTrace = $script:g_bTrace )
{
    if (!$p_bTrace) {
        return
    }
    $bStr   = $false
    $s      = $p_sFile
    if ( (!([string]::IsNullOrEmpty($s))) -or (!([string]::IsNullOrWhiteSpace($s))) ) {
        $bStr = $true
    }
    if ($bStr) {
    #   $sFnm = [io.path]::GetFileName($p_sFile)
        $sFct = (Get-PSCallStack)[1].FunctionName
    }
    $s = "$C_sMenuMarker T:`tTRACE:[$sFct"
    if ($p_iLine -ge 1) {
        $s += ";$p_iLine"
    }
    $s += "]"
    $s += ":'$p_sText'"
    f_runLog_perform $s $C_sColor_trace -o_visible:$g_bTrace
} # f~bug_trace

#   ============================================================================
#   f:  menu
#   ============================================================================

#   s:  menu.ec
function f_runMen_putEc() {
    $sEc = $Error[0]
    $iEc = $LastExitCode
    if ($sEc.length -eq 0) {
        $sEc = 'NONE'
    }
    $s = "$C_sMenuMarker e:`tEc($iEc) := <$sEc>"
    f_runLib_puts $s $C_sColor_info
} # f~lib_putEc


#   s:  menu.show
function  f_runMen_show([string] $p_sString,[bool] $p_bReverse = $false) {
    if ($p_bReverse) {
        $s = "<<< "
    } else {
        $s = ">>> "
    }
    $s += $p_sString
    f_runLog_perform -p_sString $s -p_sColor $C_sColor_result -o_visible
} # f~lib~show


#   s:  menu.header
function f_runMen_header($p_iLineNr)   {
    #   $F = "{0}" -f $MyInvocation.MyCommand     # this __FUNCTION__
    $sMod = $script:g_sMod
    $global:g_tDTM = (Get-Date) # usedByFooter
    $sDtm = f_runLib_sDateTime('yyMMddHHmmss')($global:g_tDTM)
    #   $sWhoAmI = $(whoami)
    $sScp = [io.path]::GetFileName($script:g_sScpPth)
    $s =  $g_hMenuTabulator['tab'] + "SCP.beg:{'$sScp'}('$sMod')"
    #   clear allways old errors
    $Error.clear()  # clear all errors
    #   output
    $i =  $env:v_FWK_exitCode
    $s +=  ":{$i}"
    $s +=  ":{$sDtm}"
#   $s +=   " at:[$p_iLineNr]`n"
    f_runLog_perform "$s" $C_sColor_menu -o_create -o_visible:$true
    puts ""
} # f~lib_header


#   s:  menu.footer
function f_runMen_footer($p_iLineNr = -1) {
    $sMod = $script:g_sMod
    $sScp = [io.path]::GetFileName($script:g_sScpPth)
    $sFmt = 'yyMMddHHmmss'; $sDtm = f_runLib_sDateTime($sFmt)
    $t1     = $global:g_tDTM
    $t2     = Get-Date
    $tRunTime   =  $(New-TimeSpan $t1 $t2)
    $iRunTime   =   $tRunTime.Seconds
    $iRunTime   +=  $tRunTime.Minutes * 60
    $iRunTime   +=  $tRunTime.Hours   * 60 * 60
    $iRunTime   +=  $tRunTime.Days    * 60 * 60 * 24
    $s  =  $g_hMenuTabulator['tab'] + "SCP.end:{'$sScp'}('$sMod')"
    $s +=  ":{$sDtm}"
    #   quit
    $s +=  " = <$iRunTime> sec"
#   $s += " at:[$p_iLineNr]`n"
    f_runLog_perform "$s" $C_sColor_menu -o_visible:$true
    Start-Sleep 1
    exit $script:v_iLibExitCode             # exit() sets => $LastExitCode
} # f~lib_footer


#   s:  menu.menu
function f_runMen_menu ([string] $p_sText, [int] $p_iLine = -1) {
    $iLine = $p_iLine
    $iCtr  = $script:g_iMenuCtr    += 1
    $s =  $g_hMenuTabulator['tab'] + "m:`t" + "[$iCtr]:" + $p_sText
    if ($iLine -ne -1) {
        $s += " at:[$iLine]"
    }
    f_runLog_perform "$s" $C_sColor_menu -o_visible:$script:g_bInfo
}

#   ---------------------------------------------------------------------------
#   f:  compile
#   ---------------------------------------------------------------------------

function f_runCpl_compileTc($p_sTc) {
    if ($o_raw) {           #   mode: run.raw
        Write-Output .      #   extra line
        Invoke-Expression "$C_sCompiler $p_sTc"
    } else {                #   mode: run.log : stream
        $fLog = $global:g_hScratch.m_pLog
        Invoke-Expression "$C_sCompiler $p_sTc" | Out-File $fLog -Append
    }
}

#   ---------------------------------------------------------------------------
#   f:  command.mode
#   ---------------------------------------------------------------------------

#   des :   parse input cmdStr
#   out :   [array] $aRcObj

function f_runCmd_handleMode(
                    [array]     $p_aSrc,
                    [string]    $p_sMode,
                    [switch]    $o_FnmOnly )
{

    #   show
    [array] $aRcObj = @()
    #   _trace (__LINE__) (__FUNCTION__) "mode:<$p_sMode>"

    #   calc obj using MODE
    switch ( [string] $p_sMode ) {
        $C_sMod_uno  {      #  cmd:<single>=:'.\w13_math.ps1'
            _trace (__LINE__) (__FUNCTION__) "uno"
            if ($p_aSrc.Length -gt 1) {
                _bug("aSrc!=1")(__LINE__)
            }
            $f = $p_aSrc[0]
            if (!(f_runLib_isFile($f))) {
                _bug("plausi")(__LINE__)
            }
            $pFile = Resolve-Path $f
            $aRcObj  += $pFile
        }
        $C_sMod_rnd  {      #   cmd:'+'
            _trace (__LINE__) (__FUNCTION__) "rnd"
            $aTmp   = $p_aSrc | Sort-Object { Get-Random }
            $aRcObj = $aTmp     # default, take all
            $iLen   = $aTmp.Length
            if ( $iLen -gt $C_iObj_divisor ) {
                [int] $n = [math]::Truncate( $iLen / $C_iObj_divisor )
                if ($n -lt $C_iObj_divisor ) {
                    $n = $C_iObj_divisor    # take minimum
                } else {
                    $n += 1                 # take min..divided
                    $n = Get-Random -Minimum $C_iObj_divisor -Maximum $n
                }
                $aRcObj = @()
                for ( $i = 0; $i -lt $n; $i ++ ) {
                    $aRcObj += $aTmp[$i]
                }
            }
        }
        $C_sMod_rex  {      #   cmd:'*'
            _trace (__LINE__) (__FUNCTION__) "rex"
            $aRcObj = $p_aSrc   # take all in REX
        }
        $C_sMod_all  {      #   cmd:'!'
            _trace (__LINE__) (__FUNCTION__) "all"
            $aRcObj = $p_aSrc   # take all
        }
        default {
            _trace (__LINE__) (__FUNCTION__) "default"
        }
    }

    #   copy if FileNameOnly
    if ( $o_FnmOnly) {
        $aTmp   = @()
        foreach ($x in $aRcObj) {
            $sFnm = (Get-Item $x).Name
            $aTmp += $sFnm
        }
        $aRcObj = $aTmp
    }

    $i = $aRcObj.Length
    _info "iRcObjLen2=:'$i'" (__LINE__)

    #   return @()

    return $aRcObj

} # f~run_handleMode


#   ###########################################################################
#   b:  body
#   ###########################################################################

#   m:  !key
$C_sSrcIdc          =   'y'                 #   first letter
$C_sSrcExt          =   '.py'               #   file extension
$C_sSrcUno          =   'y01_intro.ps1'     #   one valid file
$C_aSrcBlack        =   @(  'y10_module_m1.py'
                            'y20_thread.py',
                            'y20_thread.py',
                            'y32_unitTest.py', 'y32_unitTest_m1.py',
                            'y50_dummy.py', 'y51_advanced.py', 'y52_timing_m1.py' )
$C_iObj_divisor     =   8                   #   mode:rnd max/x
$C_sCompiler        =   'python'

#   check vectorCAST vpy
if ($o_use__vpy) {
    $bUsr   =   ($env:UserName -eq 'zzHassP')
    $bVca   =   ($env:VECTOR_LICENSE_FILE -eq '7650@hdhappvectorcastvtlic')
    $bVpy   =   $bUsr -and $bVca
    if ($bVpy) {    #   usr:MeVoith && VCA
        $C_sCompiler    =   'vpython'
    }
}

#   t.b.d
$C_bPathInitialization          =   $false

#   handle RegularExpression rex
$C_sRexStd          =   $C_sSrcIdc + '??_*' + $C_sSrcExt
if (!(f_runLib_isString($v__sRex))) {
    $v__sRex = $C_sRexStd
}

#   m:  debug
$script:g_bTrace        =   $false
$script:g_bInfo         =   $false
if ($o_debug ) {
    $script:g_bTrace    =   $true
    $script:g_bInfo     =   $true
}

#   m:  temp
$script:sRc             =   $null

#   ===========================================================================
#   m:  constant
#   ===========================================================================

#
#   s:  const.os
#

$C_cSepDirectoryPath__posix     =   '/'
$C_cSepDirectoryPath__winnt     =   '\'
if ($env:Os -eq 'Windows_NT') {
    $C_cSepDirectoryPath    =   $C_cSepDirectoryPath__winnt
} else {
    $C_cSepDirectoryPath    =   $C_cSepDirectoryPath__posix
}

#
#   s:  const.color
#

$C_sColor_std       =  'Gray'
$C_sColor_result    =  'Cyan'
$C_sColor_menu      =  'Green'
$C_sColor_info      =  'Yellow'
$C_sColor_file      =  'DarkBlue'
$C_sColor_trace     =  'Magenta'
$C_sColor_error     =  'Red'
$C_sColor_exit      =  'DarkRed'
$C_sColor_silent    =  'DarkGray'
$C_sColor_status    =  'DarkYellow'
$C_sColor_accepted  =  'DarkGreen'
<#  not used colors
    'Blue'
#>

#

#
#   s:  const.menu
#

[int] $C_iMenuTabulatorSize      = 3
[int] $C_iMenuTabulatorSizeSpc   = 7

$C_sMenuMarker        = '=' * $C_iMenuTabulatorSize
[hashtable] $g_hMenuTabulator = @{
    'tab'   = "=" * $C_iMenuTabulatorSize + ' '
    'men'   = "-" * $C_iMenuTabulatorSize + ' '
    'smn'   = " " * $C_iMenuTabulatorSize + ' '
    'dot'   = "." * $C_iMenuTabulatorSize + ' '
    'shl'   = "<" * $C_iMenuTabulatorSize + ' '
    'shr'   = ">" * $C_iMenuTabulatorSize + ' '
    'spc'   = " " * $C_iMenuTabulatorSizeSpc + ' '
}

#
#   s:  constant.program
#

#   modi of command
$C_sMod_all  = 'all'
$C_sMod_uno  = 'uno'
$C_sMod_rnd  = 'rnd'
$C_sMod_rex  = 'rex'

#   ctr output
$C_sFmtCtr   = '{0:d3}'

#   ===========================================================================
#   m:  alias
#   ===========================================================================

#   s:  alias.location
Set-Alias -Name __LINE__        -Value  f_runLoc_getCurrentLineNumber
Set-Alias -Name __FILE__        -Value  f_runLoc_getCurrentFileName
Set-Alias -Name __FUNCTION__    -Value  f_runLoc_getScriptName

#   general
Set-Alias -Name _echo   -Value  Write-Output

#   alias.control
Set-Alias -Name _delay  -Value  f_runLib_delay
Set-Alias -Name _print  -Value  f_runLib_print
Set-Alias -Name _puts   -Value  f_runLib_puts
Set-Alias -Name _logs   -Value  f_runLog_perform

#   alias.exit
Set-Alias -Name _bug    -Value  f_runLib_exit

#   menu.debugInfo
Set-Alias -Name _info   -Value  f_runBug_info
Set-Alias -Name _trace  -Value  f_runBug_trace

#   menu
Set-Alias -Name _show   -Value  f_runMen_show

#   ===========================================================================
#   m:  global
#   ===========================================================================

#
#   s:  glob.scp
#

$g_sScpFnm  =   $MyInvocation.MyCommand.Name
$d = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
Push-Location $d
$script:g_sScpPth  = Resolve-Path $g_sScpFnm
Pop-Location

#
#   s:  glob.scratch
#

#   u:  scratch.dir !CRQ-241226:ScratchByFwk
$d = $env:UserProfile
$s = $env:v_USR_scratch_relPath
if ($null -eq $s) {
    $d += 'temp'
} else {
    $d += $s
}
$script:g_sScratchDir = $d

#   u:  scratch.space
[hashtable] $global:g_hScratch = @{}


#
#   s:  glob.exitCode
#

$env:v_FWK_exitCode        =   Get-Random -Minimum 1001 -Maximum 9999
$script:v_iLibExitCode  =   -1138   # return value

#
#   s:  glob.program
#

$script:g_bColor        =   $true
$script:g_iMenuCtr      =   0

#
#   s:  glob.EnvironmentVariable
#

$env:v_mode_bBat = $null
$env:v_mode_bClr = $null
$env:v_mode_bVbs = $null
$env:v_mode_iLog = $null
if ( $o_color )   {
    $env:v_mode_bClr = 'true'
}
if ( $o_verbose ) {
    $env:v_mode_bVbs = 'true'
}

#   adjust.src.logging
if ( $v__bLogging ) {
    if ( $o_logging ) {
        $env:v_mode_iLog = '1'
    }
    elseif ( $o_auto ) {
        $env:v_mode_iLog = '2'
    }
}

#   ===========================================================================
#   m:  program
#   ===========================================================================

#
#   s:  do.read.parameter.cmd
#

#   init
$bHlp   =   $o_help     #   take option help
$bClr   =   $false      #   ? clear+erase scratch
$bCrt   =   $false      #   ? create scratch
$bCmd   =   $false      #   ? cmd is valid
$bGci   =   $false      #   ? Get-ChildItem
$sMod   =   $null       #   mod:{uno,rnd,rex,all}

if ( ! $bHlp ) {

    $bStr = f_runLib_isString($v__sCmd)

    if ($bStr) {
        $bCmd = $false
        switch($v__sCmd) {
            '?' {   $bHlp   =   $true }
            'c' {   $bClr   =   $true; $bCrt  = $true }
            'e' {   $bClr   =   $true }
            '!' {   $bCmd   =   $true;
                        $sMod = $C_sMod_all; $bGci = $true }
            '+' {   $bCmd   =   $true;
                        $sMod = $C_sMod_rnd; $bGci = $true }
            default {
                $cCmd = $v__sCmd[0]
                switch($cCmd) {
                    '*' {
                        $v__sRex    =   $v__sCmd.SubString(1)
                        $bGci       =   $true
                        $bCmd       =   $true
                        $sMod       =   $C_sMod_rex
                    }
                    default {
                        $bCmd   =   f_runLib_isFile($v__sCmd)
                        $sMod   =   $C_sMod_uno
                    }
                }   # stringCommand
            } # switch default
        } # switch
    } else {
        $bHlp = $true
    }
}
$script:g_sMod = $sMod

#   check help, if wrong parameter
if ( ! $bHlp ) {
    if (! $bCmd ) {
        $bHlp = $true
    }
    elseif ($p_iRepeat -lt 1) {
        $bHlp = $true
    }
}

#   clear scratch
if ($bClr) {
    _trace (__LINE__)(__FUNCTION__) "scratchClear"
    f_runTmp_scratchClear
    if ($bCrt) {
        f_runTmp_scratchCreateIfNotExist
    }
    exit
}

#   show usage
if ($bHlp) {
    f__usage; exit
}

#   ---------------------------------------------------------------------------
#   s:  do.set
#   ---------------------------------------------------------------------------

#   create.scratch
f_runTmp_scratchCreateIfNotExist

#   init.path?
f_runEnv_setPath($C_bPathInitialization)

#   set HOST
f_runLib_setHost

#   calc.PostFix
$sFmt = 'yyMMddHHmmss'
$sDtm = $script:g_sDtmPostfix = f_runLib_sDateTime($sFmt)

#   PS7 ?
$script:g_sPSH_id = 'PS5'
if ($PSVersionTable.PsVersion.Major -ge 7) {
    $script:g_sPSH_id = 'PS7'
}

#   prepare.Logging
$script:g_bLogging  =  $false
if ( $v__bLogging ) {
    if ( ! (f_runLog_prepare($sDtm)) ) {
        _bug "??? logPrepare fails" (__LINE__)
    }
}

#   ready
_trace (__LINE__)(__FUNCTION__) "ready"

#   ---------------------------------------------------------------------------
#   s:  do.menu.header
#   ---------------------------------------------------------------------------

#   header
f_runMen_header(__LINE__)

#   show
$sPwd = $(Get-Location)
_info "sCmd:        '$v__sCmd'"
_info "sRex:        '$v__sRex'"
_info "iRepeat:     <$v__iRepeat>"
_info "sPwd:        '$sPwd'"
_info "sMode:       <$sMod>"
_info "bGci:        <$bGci>"
_info "bVerbose:    <$o_verbose>"
_info "bColor:      <$o_color>"
_info "bRawMode:    <$o_raw>"
_info "bLogging:    <$o_logging>"
_info "bAutoName:   <$o_auto>"
_info "vLogging:    <$v__bLogging>"
_info "iExitCode:   <$env:v_FWK_exitCode>"
_info "sPath: {$env:path}"
if ($v__bAutoNaming) {
    $pLog = $global:g_hScratch.m_pLog
    _info "pLog   := '$pLog'"
}

#
#   s:  do.prepare
#

#
#   u:  fetch.pGci
#

[array] $aSrc = @()
$script:g_pGci = $null
if( $bGci ) {
    _trace (__LINE__) (__FUNCTION__) "get.pGci"
    _info "gci : '$v__sRex'"
    $script:g_pGci = Get-ChildItem $v__sRex
    $n = $script:g_pGci.Count
    if ($n -le 0) {     #   !CRQ-241208: check.len
        _bug "?pGci.Length == 0 with REX:'$v__sRex'" (__LINE__)
    }
    #   !CRQ-241208: check extension, must be fit
    $aTmp = $script:g_pGci
    $aSrc = @()
    foreach ($x in $aTmp) {
        $sExt = (Get-Item $x).Extension
        if ($sExt -eq $C_sSrcExt) {
            $aSrc += $x
        }
    }
    $n =  $aSrc.Length
    if ($n -eq 0) {
        _bug "?Src.Length == 0 with REX:'$v__sRex'" (__LINE__)
    }
} else {
    _trace (__LINE__) (__FUNCTION__) "set.pGci:=src"
    $aSrc += $v__sCmd
}

#
#   u:  handle.mode : aSrc => aObj
#

[array] $aObj = @()
$aObj = f_runCmd_handleMode -p_sMode $sMod -p_aSrc $aSrc -o_FnmOnly:$true
$nObj = $aObj.Length
if ($nObj -eq 0) {
    _bug ("noInputSrc")(__LINE__)
}

#
#   u:  info.show.objects
#

_trace (__LINE__) (__FUNCTION__) "show.obj"
if ($script:g_bInfo) {
    $i      =   0
    $n      =   $aObj.Length
    $sMax   =   [String]::Format($C_sFmtCtr, $n)
    foreach ($x in $aObj) {
        $i += 1
        $sIdx  =  [String]::Format($C_sFmtCtr, $i)
        _info "[$sIdx/$sMax] : '$x'" -o_visible
    }
}

#   set BlackList - valid only if mode:rnd or mode:all
$aBlack = @()
switch ( $sMod ) {
    $C_sMod_rnd  {   $aBlack = $C_aSrcBlack }
    $C_sMod_all  {   $aBlack = $C_aSrcBlack }
}

#   ready.Prepare
_trace (__LINE__) (__FUNCTION__) "ready.prepare"

#   ---------------------------------------------------------------------------
#   s:  do.show.body
#   ---------------------------------------------------------------------------

#   tabulator
$sTab = "#" * 80

#   counter strings
$sRunMax    =  [String]::Format($C_sFmtCtr, $v__iRepeat)
$sObjMax    =  [String]::Format($C_sFmtCtr, $aObj.Length)

#   show header line
$n = $aObj.Length
$s = "### run of <$n> scripts"
if ( $v__iRepeat -gt 1 ) {
    $s += " and <$v__iRepeat> times"
}
_puts $s

#   show.for
$i = 0
foreach ($x in $aObj) {
    $i += 1
    _puts "`t[$i] : '$x'"
}
_echo "`n"

#   ---------------------------------------------------------------------------
#   s:  do.perform.test
#   ---------------------------------------------------------------------------

#   mode.BATCH := true  : inform called scripts
if ( ! $o_raw ) { $env:v_mode_bBat = 'true' }

for ( $iRun = 1; $iRun -le $v__iRepeat; $iRun ++) {

    if ($iRun -gt 1) {
        #   _echo ""   # line
        if ($sMod -eq 'rnd') { # shuffle
            $aObj = $aObj | Sort-Object {Get-Random}
        }
    }

    $iObj = 0
    foreach ($x in $aObj) {

        #   inc objects
        $iObj   += 1

        #   format.i2s
        $sObjIdx    =  [String]::Format($C_sFmtCtr, $iObj)
        $sRunNow    =  [String]::Format($C_sFmtCtr, $iRun)

        #   check object
        if ( $aBlack -contains $x ) {   # ?inBlackList
            continue
        }
        elseif (!(f_runLib_isFile($x))) {  # ?noFile
            _logs "??? noF : [$sIdx] : '$x' " -o_visible
            $aBlack += $x
            continue
        }

        #   show
        _logs $sTab
        $s = "test "
        if ( $v__iRepeat -gt 1 ) {
            $s += ": run.[$sRunNow/$sRunMax]"
        }
        if ($aObj.Length -gt 1 ) {
            $s += ": obj.[$sObjIdx/$sObjMax] "
        }
        $s += ": '$x' "
        _logs $s
        _logs $sTab
        _print $s

        #   clear error
        $Error.clear()
        $bEc = $false

        #   try compile
        try {
            Start-Sleep 1
            f_runCpl_compileTc($x)         #   +++ COMPILING +++
        }
        catch {
            $bEc = $true
            $sEc = $Error[0]
            _print ';' ; _puts " ec = [$LastExitCode]" $C_sColor_error
        }
        finally {
            if ( !$bEc ) {
                if ($LastExitCode -eq $env:v_FWK_exitCode) {
                     _puts ";" $C_sColor_accepted
                } elseif ($LastExitCode -eq 0) {
                    _print ';' ; _puts " ec == 0" $C_sColor_result
                } else {
                    _print ';' ; _puts " ec != [$LastExitCode]" $C_sColor_result
                }
            }
        } # try-catch-finally

        if ( $bEc ) {  # save as not successful
            f_runMen_putEc
            $aBlack += $x
        } # if ec

    }   # foreach in aObj

} # for run stress

#   mode.BATCH := false
if ( ! $o_raw ) { $env:v_mode_bBat = 'false' }

#   ---------------------------------------------------------------------------
#   s:  do.menu.footer
#   ---------------------------------------------------------------------------

#   show end.of.work
if ( $script:g_bLogging ) {
    Start-Sleep 1
    $pLog = $global:g_hScratch.m_pLog
    _echo ""
    _print "### log -> "
    _puts "'$pLog'" $C_sColor_file
    _echo ""
} else {
    _puts "`n### ready:no.logging`n"
}

#   reset EnvironmentVariable mode~
if ($o_reset) {
    $env:v_mode_bBat = $null
    $env:v_mode_bClr = $null
    $env:v_mode_bVbs = $null
    $env:v_mode_iLog = $null
}

#   show footer
f_runMen_footer(__LINE__)

#   b:  end ###

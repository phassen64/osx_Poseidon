#   ###########################################################################
#   include Library Tutorial                    DTM:  241110
#   ###########################################################################

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

<#
    author      :   P.Hassen
    company     :   mATe64 UG
    location    :   D-90489 N�rnberg
#>

<#
    description :
        main include file for WPS tutorial
        is called by a helper-include file
#>

<#
    content
        f:  scriptHeader
        b:  function
            f:  scriptInfo
            f:  isString
            f:  isItem
            f:  stringHandling
            f:  dateTime
            f:  exit
            f:  math
            f:  IO
            f:  print
            f:  menu.bdy
            f:  menu.ctr
            f:  debug: info && trace
            f:  integer
        b:  class
        b:  body
            m:  psh
            m:  scp
            m:  alias
            m:  color
            m:  dirSep
            m:  globals
                s:  parameterCopy
                s:  scratchDir
            m:  end
#>

#   ===========================================================================
#   f:  scriptHeader
#   ===========================================================================

param(
    [string]    $p__sScp,
    [int]       $p__iLogMode,   # 1:std, 2:autoNaming, else:noLogging
    [switch]    $o__bColor,
    [switch]    $o__bVerbose    # info && trace
)

#   =:= b: copy Script parameter ?

#   ###########################################################################
#   b:  function
#   ###########################################################################

#   ===========================================================================
#   f:  scriptInfo
#   ===========================================================================

function f_lib_script_commandName {
    $p__sScp    #   $MyInvocation.MyCommand
}

function f_lib_script_name {
    $MyInvocation.ScriptName
}

function f_lib_script_lineNumber {
    $MyInvocation.ScriptLineNumber
}

function f_lib_script_getParamter {
    $s = "scp:{$p__sScp}"
    $s += ";log:{$p__iLogMode}"
    $s += ";clr:{$o__bColor}"
    $s += ";vbs:{$o__bVerbose}"
    return $s
}

#   ===========================================================================
#   f:  isString
#   ===========================================================================

function f_lib_isString([string] $p_sString) {        # !FCT
    if ( ( $p_sString -eq $null) `
                -or ( [string]::IsNullOrEmpty($p_sString) ) `
                -or ( [string]::IsNullOrWhiteSpace($p_sString) ) `
                -or ( -not ( $p_sString -is [string] ) ) )
    {
            return ($false)
    }
    return $true
}

#   ===========================================================================
#   f:  isItem
#   ===========================================================================

function  f_lib_isFile([string] $p_sString) {
    if (!(f_lib_isString($p_sString)))  {
        return ($false)
    }
    if (!(Test-Path $p_sString -PathType Leaf)) {       # mustExist
        return ($false)
    }
    return $true
} # f~lib~isFile

function f_lib_isDirectory([string] $p_sString) {
    if (!(f_lib_isString($p_sString)))  {
        return ($false)
    }
    if (!(Test-Path $p_sString -PathType Container)) {  # mustExist
        return ($false)
    }
    return $true
} # f~lib~isDirectory

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
} # f~lib~isDriveLetter


#   ===========================================================================
#   f:  isType
#   ===========================================================================

#   https://devblogs.microsoft.com/scripting/understanding-numbers-in-powershell/
#   A third type name, single, is a synonym for type float;
#   float is used throughout this specification.

function f_lib_isType_array($p)      {   return ($p -is [array])     }
function f_lib_isType_boolean($p)    {   return ($p -is [bool])   }
function f_lib_isType_byte($p)       {   return ($p -is [byte])      }  # 8-bit unsigned
function f_lib_isType_char($p)       {   return ($p -is [char])      }  # Unicode-16-bit
function f_lib_isType_dateTime($p)   {   return ($p -is [DateTime])  }
function f_lib_isType_decimal($p)    {   return ($p -is [decimal])   }  # 128-bit dec
function f_lib_isType_double($p)     {   return ($p -is [double])    }  # 64-bit float
function f_lib_isType_float($p)      {   return ($p -is [float])    }   # 32-bit float
function f_lib_isType_hash($p)       {   return ($p -is [hashtable]) }
function f_lib_isType_int($p)        {   return ($p -is [int])       }
function f_lib_isType_int64($p)      {   return ($p -is [int64])     }
function f_lib_isType_long($p)       {   return ($p -is [long])      }   # 64-bit
function f_lib_isType_object($p)     {   return ($p -is [Object])    }
function f_lib_isType_single($p)     {   return ($p -is [single])    }   # 32-bit float
function f_lib_isType_string($p)     {   return ($p -is [string])    }
function f_lib_isType_xml($p)        {   return ($p -is [xml])       }
function f_lib_isType_Rex($p_sRex) {
    #   contains the string any kind of REX chars?
    $s = $p_sRex
    if (
            ($s -match '^\$')   -or `
            ($s -match '\*')    -or `
            ($s -match '\[')    -or `
            ($s -match '\]')    -or `
            ($s -match '\{')    -or `
            ($s -match '\}')    -or `
            ($s -match '\?')
        )
    {
        return $true
    }
    return $false
} # f~lib_isTypeRex


#   ===========================================================================
#   f:  getType
#   ===========================================================================

function f_lib_getType($p_sVariable) {
    return $p_sVariable.GetType()
}


#   ===========================================================================
#   f:  stringHandling
#   ===========================================================================

#
#  A string @"..."@ contains all chars, including '\r' and '\n'
#

#   cut '\n' only
function f_lib_chop([string] $p_sString) {
    $s  =   $p_sString
    $s  =   $s.replace("`n",'')
    return $s
}

#   cut last '\r' '\n'
#   0x0a=NL=`n
#   0x0d=CR=`r
function f_lib_chomp([string] $p_sString, [char]$p_cReplace = $null) {
    $s  =  $p_sString
    $c  =  $p_cReplace[0]
    if ($p_cReplace -ne $null) {
        $s  =   $s.replace("`r`n",$c) # $p_cReplace)
    }
    else {
        $s  =   $s.replace("`r`n",'')
    }
    return $s
}

#   ===========================================================================
#   f:  dateTime
#   ===========================================================================

function f_lib_sDateTime(   [string]    $p_sFmt='yyMMddHHmmss',
                            [DateTime]  $p_tDateTime)   {
    <#
            DateTime Formate (US)
            *   long        DD/MM/YYYY      example: 06/28/2021 => 28.Juni 2021
            *   short       DD/MM/YY        example: 06/28/21
            *   very short  DD/MM           example: 06/28
            *   hour:min    DD/MM/YYYY HH:mm     example: 06/28/2021 15:45
            *   hour:min    HH:mm           example: 15:45 => 07.Juli2021 15:45
    #>
    <#  exampleFormatString
            f~lib~sDateTime -p_sFmt 'yyMMddss' -p_tDateTime '15:02' => 15:02:00
    #>
    if ( $p_tDateTime -eq $null ) {
        $sDate = Get-Date -Format $p_sFmt
    } else {
        $sDate = $p_tDateTime.ToString("$p_sFmt")
    }

    return $sDate

} # f~lib_sDateTime


function f_lib_iTimeSpan( [DateTime] $p_tDTM_start, [DateTime] $p_tDTM_stopp)   {

    #   create timeSpan object
    $pRunTime   =  $(New-TimeSpan $p_tDTM_start $p_tDTM_stopp)

    #   calc
    $iSec   =   $pRunTime.Seconds
    $iSec   +=  $pRunTime.Minutes * 60
    $iSec   +=  $pRunTime.Hours   * 60 * 60
    $iSec   +=  $pRunTime.Days    * 60 * 60 * 24

    #   returns in Seconds
    return $iSec

} # f~lib_iTimeSpan


function f_lib_dtm([string] $p_sFmt='yyMMddHHmmss')  {
    $x = $script:g_tScpDtm
    return ( $x.ToString("$p_sFmt") )
}


#
#   s:  timer
#

function f_lib_delay($p_iDelay = 0) {
    if ($p_iDelay -eq 0) {
        return
    }
    Write-Host "--- continue in <$p_iDelay>"
    for ( $i = 0; $i -lt $p_iDelay; $i++) {
        Start-Sleep 1
        Write-Host '.' -ForegroundColor $C_sColor_status -NoNewLine
    }
    Write-Host ';'
}

#   ===========================================================================
#   f:  exit
#   ===========================================================================

function f_lib_exit( [int] $p_iLine,
                     [string] $p_sText = '!')
{
    $u  = (Get-PSCallStack)[1].FunctionName
    $f  = "{0}" -f $MyInvocation.MyCommand     # __FUNCTION__
    $s = "### libExit at:[$f;$u;$p_iLine]:['$p_sText']"
    Write-Host $s -ForegroundColor $C_sColor_error
    exit (-(__LINE__))
}

function f_lib_assert([bool]$p_bExpression, $p_iLineNr = -1) {
    if ( ! $p_bExpression ) {
        $s = "assert ec:[$LastExitCode]"
        if ($p_iLineNr -gt 1) {
            $s += " at:[$p_iLineNr]"
        }
        $s = $g_hMenuTabulator['err'] + $s
        Write-Host $s -ForegroundColor $C_sColor_error
        exit (-($p_iLineNr))
    }
} # f~lib_assert

function f_lib_errorAction( [string] $p_sAction = 'SilentlyContinue') {
<#
    in:     new.ErrorAction
    out:    old.ErrorAction
#>
<#
    •   SilentlyContinue
        Don't display an error message continue to execute subsequent commands.
    •   Continue
        Display any error message and attempt to continue execution
            of subsequence commands.
    •   Inquire
        Prompts the user whether to continue or terminate the action
    •   Stop
        Terminate the action with error.
#>
    $sEap = $ErrorActionPreference
    $ErrorActionPreference = $p_sAction
    $Error.clear()  # clear all errors
    return $sEap    # return old
}  # f~lib_errorAction

#
#   ===========================================================================
#   f:  math
#   ===========================================================================

#   like math::truncate but with precsision
#   example: f(1.2345,3) => 1.234
function f_lib_truncate (   [double]    $p_dVal,
                            [int]       $p_iPrec)   {

    #   input: '1.2395654' with '.'
    [double] $dRc = 0.0
    [string] $s = $null
    #   convert::double=>string
    #   converts 1.23 => 1,23 if sepDec_DE
    $s = $p_dVal
    $s = $s.replace($C_cSepDecimal_en,$C_cSepDecimal)
    $i = $s.IndexOf($C_cSepDecimal)
    if ($i -lt 1) {
        return  $p_dVal
    }
    #   find it
    $i +=  $p_iPrec
    $i +=  1        # 'after .'
    if ($i -ge $s.Length) {
        return  $p_dVal
    }
    #   build subString
    $t = $s.Remove($i)              # 1,23
    #   convert::string=>double
    $dRc = [double]::Parse($t)      # 1.23
    #   return
    return  $dRc

}   # f~lib_truncate

#   ===========================================================================
#   f:  IO
#   ===========================================================================

function  f_lib_getFileSize([string] $p_sFilePath, [switch] $o_KB) {
    if (!(f_lib_isFile($p_sFilePath)))  {
        return -1
    }
    $x      = Get-Item $p_sFilePath
    $iRc    = $x.Length + 0       # in Bytes
    if ($o_KB) {
        $iRc = [int] [Math]::Truncate($iRc / 1024)
    }
    return $iRc
} # f~lib~getFileSize

function f_lib_getFileDateTimeStr(  [string] $p_sFile,
                            [string] $p_sFmt = 'yyMMdd_HHmmss') {
    $sRc = '?None'
    if (f_lib_isFile($p_sFile)) {
        $xDtm   =   $(Get-Item $p_sFile).LastWriteTime
        $sRc    =   $xDtm.ToString($p_sFmt)
    }
    return $sRc
} # f~lib_getFileDateTimeStr

function f_lib_joinPath ( [string] $p_sDir, [string] $p_sFnm ) {
    #   build
    $s = $p_sDir
    if ( $s[$s.Length - 1] -ne $C_cSepDirectoryPath ) {
        $s +=   $C_cSepDirectoryPath
    }
    $s += $p_sFnm
    return $s
} # f~lib_joinPath

function f_lib_hFileMember( [string] $p_sString )
{
    $hRc = @{}
    $hRc.m_bRc   = $false
    if (!(f_lib_isString($p_sString))) {
        return $hRc
    }

    #   store
    $x = $p_sString

    #   check.item
    $bMem = $hRc.m_bMem = Test-Path $x -PathType Leaf

    #   fetch
    #   x:\temp\peter.txt

    if ($bMem) {
        $hRc.m_sDir = (Get-Item $x).DirectoryName   #   x:\temp
        $hRc.m_sNam = (Get-Item $x).Name            #   peter.txt
        $hRc.m_sBdy = (Get-Item $x).Basename        #   peter
        $hRc.m_sExt = (Get-Item $x).Extension       #   *.txt
        $hRc.m_sPth = Resolve-Path $x
    }
    else {
        $d = $hRc.m_sDir = [io.path]::GetDirectoryName($x)   # 'x:\' but not 'x:'
        $f = $hRc.m_sNam = [io.path]::GetFileName($x)          #   peter.txt
        $hRc.m_sBdy = [io.path]::GetFileNameWithoutExtension($x)  #   peter
        $hRc.m_sExt = [io.path]::GetExtension($x)  # contains '.txt'
        $hRc.m_sPth = f_lib_joinPath ($d)($f)
    }

    #   driveLetter extra
    $cDrv =  $hRc.m_cDrv = $hRc.m_sDir[0]
    if (!$bMem) {   # check only, if NOT item
        $bDrv = f_lib_isDriveLetter($cDrv)
        if (!$bDrv) {
            return $hRc
        }
    }

    #   returnCode
    $hRc.m_bRc  =   $true

    return $hRc

} # f~lib_hFileMember



#   ===========================================================================
#   f:  item
#   ===========================================================================


function f_lib_itemCreate ( [string] $p_sString,
                            [bool]   $p_bItemIsDir = $false,
                            [bool]   $o_bForce = $false)
{
    #   check
    if (!(f_lib_isString($p_sString))) {
        return $false
    }
    #   differ
    if ( $p_bItemIsDir ) {
        $sPathType =  'Container'
        $sItemType =  'Directory'
    } else {
        $sPathType =  'Leaf'
        $sItemType =  'File'
    }
    #   store
    $x  =  $p_sString
    #   check to create
    if ( $o_bForce ) {
        $bCreate = $true
        $bExist  = Test-Path $x -PathType $sPathType
        if ($bExist) {
            if ( $p_bItemIsDir ) {
                Remove-Item $x -Recurse
            } else {
                Remove-Item $x
            }
        }
    }
    else {
        $bCreate = (! (Test-Path $x -PathType $sPathType) )
    }
    #   perform create
    if ( $bCreate ) {
        $sRc = New-Item $x -ItemType $sItemType
    }
    #   return status
    return ( Test-Path $x -PathType $sPathType )
} # f~lib_itemCreate


function f_lib_directoryCreate( [string] $p_sString, [bool] $p_bForce = $false )
{
    $bRc = f_lib_itemCreate($p_sString)($true)($p_bForce)
    return ( $bRc )
} # f~lib_directoryCreate

function f_lib_fileCreate( [string] $p_sString, [bool] $p_bForce = $false )
{
    $bRc = f_lib_itemCreate($p_sString)($false)($p_bForce)
    return ( $bRc )
} # f~lib_fileCreate


#   ===========================================================================
#   f:  print
#   ===========================================================================

function  f__print( [string] $p_sString,
                    [string] $p_sColor = $C_sColor_std,
                    [switch] $o_NoNL) {
    if (!(f_lib_isString($p_sString))) {
        f_lib_exit(__LINE__)('noString')
    }
    if ($g_bColor) {
        Write-Host $p_sString -ForegroundColor $p_sColor -NoNewLine:$o_NoNL
    } else {
        Write-Host $p_sString -NoNewLine:$o_NoNL
    }
} # f~~print

function  f_lib_print([string] $p_sString, [string] $p_sColor = $C_sColor_std ) {
    f__print -p_sString $p_sString -p_sColor $p_sColor -o_NoNL
} # f~lib~print

function  f_lib_puts([string] $p_sString, [string] $p_sColor =  $C_sColor_std )  {
    f__print -p_sString $p_sString -p_sColor $p_sColor
} # f~lib~puts


#   ===========================================================================
#   f:  menu.bdy
#   ===========================================================================

function f_lib_header($p_iLineNr) {

    #   IN: $v_arg_sScp
    #   IN: $env:v_FWK_exitCode
    #   OUT:$global:v_iLibExitCode

    # - s:  save exitCode
    if ($null -eq $env:v_FWK_exitCode) {
        $global:v_iLibExitCode  = $g_iStdExitCode
    } else {
        $global:v_iLibExitCode  = $env:v_FWK_exitCode
    }

    # - s:  functionName
    $F = "{0}" -f $MyInvocation.MyCommand

    # - s:  RunDateTime
    $global:g_tDtm_start = (Get-Date) # usedByFooter

    # - s:  show as String
    $sDtm_run = f_lib_sDateTime('yyMMdd_HHmmss')($g_tDtm_start )

    # - s:  Who
    #  <<< tron3\peter
    $sWhoAmI = $(WhoAmi)

    # - s:  count header
    $script:g_iMenu_main  = 0

    # - s:  build header Str
    $i  = $global:v_iLibExitCode
    $s      =  $g_hMenuTabulator['tab']
    $s +=   "h:`tBEG:'$p__sScp':<$sDtm_run>:{$i}"
    $s +=   " at:[$p_iLineNr]"
    #   $s +=   "`n`tby:[$sWhoAmI]"


    # - s:  clear old errors
    $Error.clear()  # clear all errors

    # - s:  output header Str
    f_lib_puts "$s`n" $C_sColor_menu

    # - s:  transscipt logging
    if ($g_bTranscriptLogging) {

        $f  = $script:g_hScpMem.m_sBdy
        if ($p__iLogMode -eq 2) {
            $f += '_'
            $s  = f_lib_sDateTime('yyMMddHHmmss')($g_tDtm_start )
            $f += $s
        }
        $f += '.log'
        $d  = $g_sDirScratch
        $p  = f_lib_joinPath($d)($f)
        $global:g_pLogTranscript = $p

        #   try Transcript
        try {
            Start-Transcript $global:g_pLogTranscript
        }
        catch {
            $p   = $global:g_pLogTranscript
            $sEc = $Error[0]
            $iEc = __LINE__
            $s   = "?transcript:'$p'"
            $s  +=  "at:$iEc"
            $s  += "`n[$sEc]"
            f_lib_puts "$s" $C_sColor_error
            #   reset
            $g_bTranscriptLogging = $false
        }
    }

} # f~lib_header


function f_lib_footer($p_iLineNr) {

    # - s:  get Scp
    $sScp   = $p__sScp

    #   DTM
    $global:g_tDtm_stopp = (Get-Date) # usedByFooter

    #   timeSpan
    $global:g_iTimeSpan = f_lib_iTimeSpan($global:g_tDtm_start)($global:g_tDtm_stopp)

    # - s:  build output
    $i  =   $global:v_iLibExitCode
    $t  =   $global:g_iTimeSpan
    $s  =   $g_hMenuTabulator['tab'] + "h:`tEND: <'$sScp'>:{$i}"
    $s +=   "::{$t}"
    $s += " at:[$p_iLineNr]`n"

    # - s:  show
    f_lib_puts "`n$s" $C_sColor_menu

    # - s:  stop logging
    if ($g_bTranscriptLogging) {
        Stop-Transcript
    }

    # - s:  change exitCode if error
    $iEc = $Error.count
    if ($iEc -gt 0) {
        $global:v_iLibExitCode = (-(__LINE__))   # set this error
    }

    # - s:  do Exit
    exit($global:v_iLibExitCode)
}

#   ===========================================================================
#   f:  menu.ctr
#   ===========================================================================

function f_lib_menu ([string] $p_sText, [int] $p_iLine = -1) {
    $iLine = $p_iLine
    $script:g_iMenu_main += 1
    $script:g_iMenu_S1     = 0
    $i      =  $script:g_iMenu_main
    $sNo    = [String]::Format("{0:d2}", $i)

#   --- m:  m01:    dataTypes overview at:[105]
    $sTab   = " "
    $s =  $g_hMenuTabulator['men'] + "m:$sTab m$sNo" + ':' + $p_sText

    if ($iLine -ne -1) {
        $s += " at:[$iLine]"
    }

    # - s:  show
    f_lib_puts "`n$s" $C_sColor_menu
}

function f_lib_menuS1 ([string] $p_sText, [int] $p_iLine = -1) {
    $script:g_iMenu_S1 += 1
    $script:g_iMenu_S2 = 0
    $i      =  $script:g_iMenu_S1
    $sNo    =  [String]::Format("{0:d2}", $i)
    $sTab   = " "
    $s      =  $g_hMenuTabulator['smn'] + "s:$sTab s$sNo" + ':' + $p_sText
    $iLine = $p_iLine
    if ($iLine -eq -1) {
        $s += ";"
        $iLine = $v_LINE  # use outside one
    } else {
        $s += " :[$iLine]"
    }
    # - s:  show
    f_lib_puts "$s" $C_sColor_menu
}

function f_lib_menuS2 ([string] $p_sText, [int] $p_iLine = -1) {
    $script:g_iMenu_S2 += 1
    $i      =  $script:g_iMenu_S2
    $sNo    =  [String]::Format("{0:d2}", $i)
    $sTab   = " "
    $s      =  $g_hMenuTabulator['smn'] + "u:$sTab u$sNo" + ':' + $p_sText
    $iLine = $p_iLine
    if ($iLine -eq -1) {
        $s += ";"
    } else {
        $s += " :[$iLine]"
    }
    # - s:  show
    f_lib_puts "$s" $C_sColor_menu_sub
}


function f_lib_text (   [string]    $p_sText,
                        [int]       $p_iLine = -1,
                        [string]    $p_sColor = $g_sColor_text,
                        [switch]    $o_Hdr, [switch]$o_End )    {
    $sFct   = "$g_sScp`::$p_sText()"
    $sCol   =  $p_sColor
    if ($o_Hdr) {
        $sCol   = $C_sColor_trace
        $s =  $g_hMenuTabulator['shr'] + "h:`t" + $sFct
    } elseif ($o_End) {#
        $sCol   = $C_sColor_trace
        $s =  $g_hMenuTabulator['shl'] + "f:`t" + $sFct
    } else {
        $sCol   = $p_sColor
        $s =  $g_hMenuTabulator['spc'] + $p_sText
    }
    if ($p_iLine -gt 1) {
        $s += " `t:[$p_iLine]"
    }
    f_lib_puts "$s" $sCol
}

#   external function - like f_lib_text
function f_lib_show(    [string] $p_sString,
                        [string] $p_sColor = $g_sColor_show) {
    $s = $g_hMenuTabulator['out'] + $p_sString
    f_lib_puts -p_sString $s -p_sColor $p_sColor
}

#   ===========================================================================
#   f:  debug: info && trace
#   ===========================================================================

function f_lib_info(
        [string] $p_sString,
        $p_iLine  = -1,
        [string] $p_sColor = $g_sColor_info,
        $p_bVerbose = $g_bInfo )
{
    if (!(f_lib_isString($p_sString))) {
        f_lib_puts "??? infoOfNullStr"; return
    }
    if ( $p_bVerbose -ne $true ) {
        return
    }
    $s =  $g_hMenuTabulator['inf'] + $p_sString

    if ($p_iLine -gt 1) {
        $s += " :[$p_iLine]"
    }
    f_lib_puts $s $p_sColor
} # f~lib_info


function f_lib_trace(
        $p_iLine  = -1,
        $p_sFile  = $null,
        $p_sText  = '?',
        $p_bTrace = $g_bTrace )
{
    if (!$p_bTrace) {
        return
    }
    if (f_lib_isFile($p_sFile)) {
        $sFnm = (Get-Item $p_sFile).Name
    } else {
        $sFnm = '?F'
    }
    $sFct = (Get-PSCallStack)[1].FunctionName
    #   output text
    $s = "$C_sMenuMarker T:`tTRACE:[$sFnm;$sFct"
    if ($p_iLine -gt 0) {
        $s += ";$p_iLine"
    }
    $s += "]"
    $s += ":'$p_sText'"      # !CRQ-210318
    #   show result
    f_lib_puts $s $C_sColor_trace

} # f~lib_trace


#   ===========================================================================
#   f:  integer
#   ===========================================================================

#   in:     0x71
#   out:    0111.001

function f_lib_zeroNumberString(
                [int]       $p_iValue,              # like 0xa1
                [int]       $p_iBase = 2,           # 2 => x ** 2
                [int]       $p_iSize = 8,
                [int]       $p_iGroupSize = 4,      # 0110.1110
                [string]    $p_cGroupChar = '.',    # '.'
                [switch]    $o_grouping )
{
    #   convert into binary String
    $s = [Convert]::ToString($p_iValue,$p_iBase)
#   $s = [System.String]::Format("{0:b}",$p_iNumber)

    #   pad
    for ($i = $s.Length; $i -lt $p_iSize; $i++ ) {
        $s = '0' + $s    # padding before
    }

    $iLen = $s.Length           # 10
    if ($iLen -gt $p_iSize) {   # 4
        #   $iPos = $iLen - $p_iSize
        $s = $s.SubString($s.Length - $p_iSize)
    }

    if ($o_grouping) {

        $sReverse = $s[-1..-$s.Length] -join ''
        $r = $null
        for ($i = 0; $i -lt $sReverse.Length; $i++) {
            if (($i -gt 0) -and (($i % $p_iGroupSize) -eq 0)) {
                $r += $p_cGroupChar
            }
            $r += $sReverse[$i]
        }
        $sForward = $r[-1..-$r.Length] -join ''
        $s = $sForward
    }


    return $s
}

#   ===========================================================================
#   f:  version
#   ===========================================================================

function  f_lib_version_dateTime {
    $f = __FILE__
    $x = (Get-Item $f).LastWriteTime
#   $x = (Get-Item $f).LastAccessTime
    return $x
}

#   ##########################################################################
#   b:  class
#   ###########################################################################

class CBase {
    [int]       $m__iCtr = 0
    [string]    $m__sScratch = $g_sDirScratch
} # C~Base

class CTest : CBase {
    [bool]      $m_bTest = $false
} # C~Base

class CTutor : CTest {
    [DateTime]      $m_tDtm;
    [string]        $m_sScp;
    CTutor(     [string]    $p_sFile,
                [DateTime]  $p_tDateTime) {
        $this.m_sScp = $p_sFile
        $this.m_tDtm = $p_tDateTime
        $this.m__iCtr += 1
    }
    [void] f_hello() {
        f_lib_text("hello I am inside a class")
    }
    [void] f_info() {
        $i  = $this.m__iCtr
        $f  = $this.m_sScp
        $d  = $this.m_tDtm
        f_lib_text("cls.info.ctr := <$i>")
        f_lib_text("cls.info.scp := <$f>")
        f_lib_text("cls.info.dtm := <$d>")
    }
    [string] f_mkTestDir([string] $p_sPostfix = $null) {
        $hScp   =   f_lib_hFileMember($this.m_sScp)
        $sBdy   =   $hScp.m_sBdy
        $sScpId =   $sBdy.Remove($sBdy.LastIndexOf('_'))
        $sNam   =   $sScpId
        $sDir   =   f_lib_joinPath($this.m__sScratch)($sNam)
        $sDir +=    $p_sPostfix
        $bDir   =   f_lib_directoryCreate($sDir)
        assert ($bDir) (__LINE__)
        return $sDir
    }
} # C~TutorLib




#   ###########################################################################
#   b:  body
#   ###########################################################################

#
#   m:  psh : common variables in the Tutorial
#

[hashtable] $global:v_hTutor = @{}

#   is PS7 ?
$v_hTutor.m_bShellIdPsh__7 = $false
$i = $v_hTutor.m_iPsh_version  = $PSVersionTable.PsVersion.Major
if ($i -ge 7) {
    $v_hTutor.m_bShellIdPsh__7 = $true
}

#
#   m:  scp
#

[hashtable] $script:g_hScpMem = @{}
$script:g_hScpMem = f_lib_hFileMember($p__sScp)
$script:g_tScpDtm = $(Get-Item $p__sScp).LastWriteTime    # file access time

#
#   m:  alias
#

Set-Alias -Name assert      -Value  f_lib_assert
Set-Alias -Name delay       -Value  f_lib_delay
Set-Alias -Name print       -Value  f_lib_print
Set-Alias -Name puts        -Value  f_lib_puts
Set-Alias -Name show        -Value  f_lib_show
Set-Alias -Name text        -Value  f_lib_text
Set-Alias -Name trace       -Value  f_lib_trace
Set-Alias -Name info        -Value  f_lib_info
Set-Alias -Name bug         -Value  f_lib_exit
Set-Alias -Name __LINE__    -Value  f_lib_script_lineNumber
Set-Alias -Name __FILE__    -Value  f_lib_script_name
Set-Alias -Name __FUNCTION__ -Value f_lib_script_commandName

#
#   m:  menu
#

[int]   $C_iMenuTabulatorSize       = 3
[int]   $C_iMenuTabulatorSizeSpc    = 7
$C_sMenuMarker        = "=" * $C_iMenuTabulatorSize
[hashtable] $g_hMenuTabulator = @{
    'tab'   = "=" * $C_iMenuTabulatorSize + ' '
    'men'   = "-" * $C_iMenuTabulatorSize + ' '
    'smn'   = " " * $C_iMenuTabulatorSize + ' '
    'dot'   = "." * $C_iMenuTabulatorSize + ' '
    'shl'   = "<" * $C_iMenuTabulatorSize + ' '
    'shr'   = ">" * $C_iMenuTabulatorSize + ' '
    'out'   = " " * $C_iMenuTabulatorSize + " <<`t"
    'err'   = "#" * $C_iMenuTabulatorSize + ' '
    'inf'   = " " * $C_iMenuTabulatorSize + " i:`t"
    'spc'   = " " * $C_iMenuTabulatorSizeSpc + ' '
}

#
#   m:  color
#

#   $C_sColor_any0      = 'White'
$C_sColor_std       = 'Gray'       #   standard output color
$C_sColor_silent    = 'DarkGray'
$C_sColor_status    = 'DarkYellow'
$C_sColor_info      = $C_sColor_silent
$C_sColor_menu      = 'Green'
$C_sColor_menu_sub  = 'DarkGreen'
#   $C_sColor_any1      = 'DarkCyan'
$C_sColor_result    = 'Cyan'
#   $C_sColor_any2      = 'DarkMagenta'
$C_sColor_trace     = 'Magenta'
$C_sColor_text      = $C_sColor_std
$C_sColor_file      = 'DarkBlue'
$C_sColor_param     = 'Blue'
$C_sColor_error     = 'DarkRed'
$C_sColor_warning   = 'Red'

#
#   m:  dirSep
#

$C_cSepDirectoryPath__posix     =   '/'
$C_cSepDirectoryPath__winnt     =   '\'
if ($env:Os -eq 'Windows_NT') {
    $C_cSepDirectoryPath    =   $C_cSepDirectoryPath__winnt
} else {
    $C_cSepDirectoryPath    =   $C_cSepDirectoryPath__posix
}


#
#   m:  encoding
#

$v_hTutor.m_sEncoding = 'Windows-1252'   # psh my std

#
#   m:  decSep
#

$C_cSepDecimal = $(Get-Culture).NumberFormat.NumberDecimalSeparator
$v_hTutor.m_cSepDecimal = $C_cSepDecimal
$C_cSepDecimal_en = '.'  # !CRQ-241202:inputSepDecFormatIsEn

#
#   m:  globals
#

#   s:  exitCode
[int]   $g_iStdExitCode     =   54711   # mayNotBeNegative

#   s:  parameterCopy
[bool] $g_bTrace    =   $o__bVerbose
[bool] $g_bInfo     =   $o__bVerbose
[bool] $g_bTranscriptLogging  =   $false
if (( $p__iLogMode -ge 1 ) -and ( $p__iLogMode -le 2 )) {
    $g_bTranscriptLogging = $true
}
[bool] $g_bColor    =   $o__bColor

#   s:  colorSet
$g_sColor_show  = $C_sColor_result
$g_sColor_info  = $C_sColor_info
$g_sColor_text  = $C_sColor_text

#   s:  menuCtr
[int] $script:g_iMenu_main  = 0
[int] $script:g_iMenu_S1    = 0
[int] $script:g_iMenu_S2    = 0

#   s:  scratchDir !CRQ-241226
$x = $env:UserProfile + $env:v_USR_scratch_relPath
[string] $g_sDirScratch = $x
if (!(Test-Path $x -PathType Container)) {
    $bRc = f_lib_itemCreate($x)
    if (! $bRc ) {
        bug(__LINE__)("I can't create Scratch::'$x'");exit
    }
    Write-Output "<<< scratch created:'$x'"
}

#   s:  logFile
[string] $global:g_pLogTranscript = $null

#
#   m:  end
#

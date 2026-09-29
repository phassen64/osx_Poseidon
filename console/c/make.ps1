<#
    make <C>  date:190825
    Author  :   P.Hassen
    Date    :   Version:05.09.2019

    usage  :    PSH>  .\make.ps1 [ <tc> || <opt> ][<switch>]
                <tc>        :=  <tcFile> || '.\'<tcFile>
                <tcFile>    := 'c??_*.c'
                <opt>       := <Optc> || <Opts>
                <Optc>      := {'?','h':help,'c':clean,'!':makeAll}
                <switch>    :
                                Verbose := use: Trace/Info
                                Version := use: version of make
                                Help    := show usage
                                Cpp     := use GnuC++ instead of GnuC
    example:
                PSH>  .\<SCP> <tc> 2
                PSH>  .\<SCP>           -version
                PSH>  .\<SCP> <tc> 2    -verbose

    compiler    :   'gcc'|'g++'
    prep.Symbol :   'TEST1'         # needed

    objectDir:
                v_DIR_obj

    content:
        :m: args
        :m: include
        :m: debug
        :m: constants
        :m: PP symbol
        :m: compile and make
        :m: usage
        :m: IO helper
        :m: menu and output functions
        :m: option handler
        :m: dir&file
        :m: tc tools
        :m+ define : BODY
        :m+ run the TC
        :m+ finish

#>


#
#   =*= :m: args
#

param(
    [string]    $sCommand    = '?',
    [switch]    $Cpp,
    [switch]    $Verbose,
    [switch]    $Version,
    [switch]    $Help
 )

# =*=   :m: include
#   already performed by the '$v_PROFILE_EXTENDED'

#   =*= :copy:: internal script args := external args
$p_arg_sCommand         = $sCommand  # <tc> || <opt>
$p_arg_bCpp             = $cpp
$p_arg_bVerbose         = $Verbose
$p_arg_bVersion         = $Version
$p_arg_bHelp            = $Help

#   =*= :m: debug
$bDbg                   = $FALSE

#
#   =*= :m: constants
#

New-Variable C_cLanguageId      -Option constant -Value 'c'
New-Variable C_sExtensionId_src -Option constant -Value 'c'
New-Variable C_sExtensionId_obj -Option constant -Value 'exe'
New-Variable C_sCompiler_c89    -Option constant -Value 'gcc'
New-Variable C_sCompiler_cpp    -Option constant -Value 'g++'
New-Variable C_sPreProcessor    -Option constant -Value 'TEST1'

#
#   =*= :m: PP symbol
#

$sCompilerPP = $C_sPreProcessor

#
#   =*= :m: compile and make
#

function f_compile($p_sSrc, $p_sObj) {
    $sObj = "$v_DIR_obj\$p_sObj"
    f__info "compile:$v_Compiler '$sSrc' => '$sObj'" (__LINE__)
    try {
        . $v_Compiler $sSrc -o $sObj -D $sCompilerPP
    } catch {
        puts "any compiling error" 'red'
    }
}


#
#   =*= :m: usage
#

function f_usage() {
    f__trace "usage..." (__LINE__)
    puts "=h= help info!" $v_COLOR_info
    $s = "`$> .\'$v_SCP' { <tc> || <option> } [<switch>]"
    echo "$s"
    Write-Host @"
    <tc>        = { source file '$v_REX_src' }
    <option>   = {  '?','h' :show usage * this text *
                    'c'     :clear at: <$v_DIR_tmp>
                    '!'     :make all TC                     }
    <switch>    = {
                    -verbose    : ? show info/trace
                    -version    : ? show version
                    -help       : ? show usage
                    -cpp        : ? use g++ compiler
    }
"@
}


#
#   =*= :m: IO helper
#

function f__rm( $p_sRex = $NULL, $p_sDir = $v_DIR_obj ) {
    $sRex   = "$p_sDir\$p_sRex"
    $aSrc   = (ls $sRex)
    $n      = $aSrc.length  # puts "sRex=$sRex"; puts "n=$n"
    if ($n -gt 0 ) {
        $i = 0
        foreach ($x in $aSrc) {
            $i+=1; $s = "ReMOVE:{$x}:[$i]"; # debug: puts $s
            try { rm $x }
            catch { if ($v_bInfo) { f__error $s } }
        }
    }
}

function f__mv( $p_sRex, $p_sDirSrc, $p_sDirObj, [switch] $p_bCpy) {
    $bTrc = $TRUE
    $aSrc = (ls $p_sDirSrc\$p_sRex)
    if ( $aSrc.length -gt 0 ) {
        f__trace ('move...')(__LINE__)
        $n = $aSrc.length
        $s = 'MoVE'
        if ($p_bCpy) { $s = 'CoPY' }
        $s = "$s($n):'$p_sRex' FROM:<$p_sDirSrc>:TO:<$p_sDirObj>"
        try {
            if ($p_bCpy) {cp $aSrc $p_sDirObj -Force}
            else         {mv $aSrc $p_sDirObj -Force}
            if ($bTrc) { f__puts  $s -p_bTab -p_bCol }
        } catch {
            if ($v_bInfo) { f__error $s (__LINE__) }
        }
    } else {
        f__trace ('move empty list')(__LINE__)
    }
}

#
#   =*= :m: menu and output functions
#

function f__puts(
            $p_sText,
            $p_sFile = $v_sSTREAM_utf,  # mode:stream
            $p_sColor = $v_COLOR_text,
            $p_cTab   = '<',
            [switch] $p_bCol,
            [switch] $p_bTab,
            [switch] $p_bInf,  # only output, if info mode
            [switch] $p_bNoNL,
            $p_iLine = -1)
{
    $s  = "$p_sText"
    if ( $p_bTab ) { $sTab = $p_cTab * 3; $s = "$sTab $s" }
    if ( $p_iLine -gt 0 ) { $s += " at:[$p_iLine]" }
    $bOut = $TRUE
    if ( $p_bInf ) {
        if (!$v_bInfo) { $bOut = $FALSE }
    }
    if ($bOut) {
        if ( $p_bCol ) {
            if ( $p_bNoNL ) {
                    Write-Host "$s" -ForegroundColor $p_sColor -NoNewLine }
            else {  Write-Host "$s" -ForegroundColor $p_sColor }
        } else {
            if ( $p_bNoNL ) {
                    Write-Host "$s" -NoNewLine }
            else {  Write-Host "$s" }
        }
    }
}

function f__menu($p_sText, $p_iLine, $p_iRT = -1, [switch] $p_bChkEc) {
    $t = "'$p_sText'"; if ($p_iRT -gt 0) { $t += ":<$p_iRT s>" }
    $s = "SCP:{'$v_SCP'}:{'$v_DATE'}:{$g_iEc}:$t"
    $s = "=m= $s [$p_iLine]"
    if ($p_bChkEc) {
        if (f_bCheckEc $g_iEc) {
            $s += ":OK"
        } else {
            $s += ":FALSE"
        }
    }
    puts "$s" $v_COLOR_menu
}

function f__info($p_sText, $p_iLine = -1) {
    if ($v_bInfo -eq $TRUE) {
        $s = "=i= $p_sText"
        if ($p_iLine -gt 0) {
            $s += " at:[$p_iLine]"
        }
        puts $s $v_COLOR_info
    }
}

function f__trace($p_sText, $p_iLine=-1) {
    if ($v_bTrace) {
        $s = "=t= $p_sText"
        if ($p_iLine -gt 0) {
            $s += " at:[$p_iLine]"
        }
        puts $s $v_COLOR_trace
    }
}

function f__error($p_sError, $p_iLine=-1) {
    $s = "??? <$p_sError>"
    if ($p_iLine -gt 0) {
        $s += " at:[$p_iLine]"
    }
    puts $s $v_COLOR_error
}

#
#   =*= :m: option handler
#

function f_version() {
    f__trace "show version..." (__LINE__)
    $x = $(Get-Item $v_SCP).lastWriteTime
    f__print "<<< version( '$v_SCP' ) := <$x>" 'magenta'
}

function f_clean($p_sRex = $NULL) {
    f__trace "do cleaning..." (__LINE__)
    if ($p_sRex-eq $NULL) {
        f__rm($C_cLanguageId + '??*.'    + $C_sExtensionId_obj)
    } else {
        f__rm($p_sRex)
    }
}

function f_move() {
    $n = 1
    f__info "move obj files to:'$v_DIR_obj' in ($n)..." (__LINE__)
    sleep($n)
    f__mv($v_REX_obj)($env:tmp)($v_DIR_obj) -p_bCpy
}

#
#   =*= :m: dir&file
#

#   DES: creating a Directory or check it
function f_dirCreate( $p_sDir ) {
    #   remove DIR if exists
    if (test-path "$p_sDir") {
        f__info "!dirCr '$p_sDir' already exists" (__LINE__)
        return(__LINE__)
    }
    # !PHA avoid any echo - else no correct return code
    $xRc = (New-Item -Path $p_sDir -ItemType Directory)
    if (Test-Path $p_sDir) {
        f__info "!dirCr '$p_sDir' created" (__LINE__)
        return(__LINE__)
    }
    f__error("?dirCr '$p_sDir' creation fails")(__LINE__)
    return(-(__LINE__))
}

#   DES: concat DIR and FILE - returns UNIX fileName
function f_sFileName($p_sDir,$p_sFnm) {
    $s      = $p_sDir + '/' + $p_sFnm
    $sRc    = $s.replace('\','/')    # DOS=>UNIX
    return $sRc
}

#
#   =*= :m: tc tools
#

function f_iRuntime($p_bStart) {
    $dt = Get-Date      #    -format HH:mm:ss
    if ($p_bStart) {
        $script:v_runtime_start = $dt
        return 0
    } else {
        $tRuntime_stop  =   $dt
        $tRunTime       =   New-Timespan $script:v_runtime_start $tRuntime_stop
        $iRunTime       =   $tRunTime.Seconds
        $iRunTime       +=  $tRunTime.Minutes * 60
        $iRunTime       +=  $tRunTime.Hours   * 60 * 60
        $iRunTime       +=  $tRunTime.Days    * 60 * 60 * 24
        return $iRunTime
    }
}

function f_bCheckEc($p_iEc = $g_iEc) {

    $bTest = $FALSE

    #   test exit code
    if ($bTest) {
        $env:v_FWK_exitCode    = -(__LINE__)
        $LastExitCode       = -(__LINE__)
    }

    $sEcInfo = "(i|L)=($p_iEc|$LastExitCode)"
    $bRc     = $FALSE

    if ($LastExitCode -eq $p_iEc) {
        $sTxt   = "Ec==gEc => $sEcInfo =>:!!:OK"
        $sCol   = 'DarkGreen'
        $bRc    = $TRUE
    } elseif ($LastExitCode -eq 0) {
        $sTxt   = "Ec=:0 => $sEcInfo =>:!?:fine"
        $sCol   = 'DarkCyan'
        $bRc    = $TRUE
    } elseif ($LastExitCode -eq 1) {
        $sTxt   = "Ec=:1 => $sEcInfo =>:??:standard error"
        $sCol   = 'DarkRed'
        $bRc    = $FALSE
    } else {
        $sTxt   = "Ec =: $sEcInfo =>:??:NOK"
        $sCol   = 'Red'
        $bRc    = $FALSE
    }

    #   show
    if ($p_arg_bMode_raw) {
        puts "$sTxt" $sCol
    } else {
        puts "`t:$sTxt" $sCol
    }

    return $bRc

} # f~chkEc

#   ---------------------------------------------------------------------------
#   =*= :m+ define : BODY
#   ---------------------------------------------------------------------------

#   =*=:m:flags
$v_bTrace       = $TRUE
$v_bInfo        = $TRUE
$v_bTest        = $FALSE

#   =*=:m:color and screen
cls
$v_COLOR_text   =   'cyan'
$v_COLOR_menu   =   'green'
$v_COLOR_trace  =   'magenta'
$v_COLOR_info   =   'yellow'
$v_COLOR_error  =   'red'

#   =*=:m:SID
$v_SCP  = $MyInvocation.MyCommand.Name
$v_SID  = [io.path]::GetFileNameWithoutExtension( $v_SCP )
$v_DATE = Get-Date -Format 'yyMMddHHmmss'
$T      = Get-Date -Format 'ddHHmmss'

#   =*=: set exit code
$g_iEc = Get-random -Minimum 1001 -Maximum 9999 # script exit code
$env:v_FWK_exitCode = $g_iEc   # EC.env:=EC.scp : exitCode environment

#   =*=: matches and logId
$v_REX_src  =  $C_cLanguageId + '??_*.' + $C_sExtensionId_src  # source files
$v_REX_obj  =  $C_cLanguageId + '??*.'  + $C_sExtensionId_obj  # objects

#   =*=: stream ID for mode:stream
$v_RID      = "$v_SID." +  (Get-Date -format 'HHmmss')

#   =*=: Dir :: the wsh-tutorial loggs to tmpDir and not to the PWD
$v_DIR_obj   =  $v_hStarter['m_hDir']['out']
$v_DIR_tmp   =  $v_hStarter['m_hDir']['tmp']

#   =*=: logCopy Id
$sLogCopyId  = "{$v_SCP}:{$v_DATE}:{$g_iEc}"

#   =*=: header
f__menu('header')(__LINE__)     # first function call

#   ---------------------------------------------------------------------------
#   =*= :m+ parameter
#   ---------------------------------------------------------------------------

#   =*= :flags
$v_bTrace = $FALSE; $v_bInfo = $FALSE;
if ( $p_arg_bVerbose ) {
    $v_bTrace   = $TRUE
    $v_bInfo    = $TRUE
}

f__info "p.sCmd                 :=  <$p_arg_sCommand>" (__LINE__)
f__info "p.bVerbose             :=  <$p_arg_bVerbose>" (__LINE__)
f__info "p.bVersion             :=  <$p_arg_bVersion>" (__LINE__)
f__info "p.bC++                 :=  <$p_arg_bCpp>" (__LINE__)

#   =*= :logdir
#   !PHA: must be performed at this place, we need verbose flags
if ($v_bTest) {
    rmdir $v_DIR_obj
}
$iRc = f_dirCreate($v_DIR_obj)
if ($iRc -lt 0) {
    exit(__LINE__)
}

#   =*= :fetch possible TC
$aTcAll=@(); $aTc=@()
$x      =    gci $v_REX_src;
$aTcAll =   $x.Name
f__info("aTcAll:<$aTcAll>")(__LINE__)

#
#   =*= :handle arg-flags
#

#   mapping
if ( $p_arg_bVersion ) {
    $p_arg_sCommand = 'v'
}
elseif ( $p_arg_bHelp ) {
    $p_arg_sCommand = 'h'
}
elseif ( $p_arg_bCpp ) {
    $v_Compiler = $C_sCompiler_cpp
} else {
    $v_Compiler = $C_sCompiler_c89
}

#
#   =*= :handle p_arg_sCommand
#

switch($p_arg_sCommand) {

    '?' { f_usage }
    'h' { f_usage }
    'c' { f__puts "... clean"   ; f_clean   }
    'v' { f_version }
    'm' {       #   move to objDir
        f_move
    }
    '!' {       #  run all-Tc
        $aTc = $aTcAll
        f_clean
        f__trace("option:='use all TCs'")(__LINE__)
    }
    default {   #   run single-Tc or wrong option

        #   01:test a valid file
        if (!(test-path $p_arg_sCommand)) {
            f__error ("unknown option '$p_arg_sCommand'")(__LINE__)
            exit(-(__LINE__))
        }

        #   <tc> := command

        #   02:remove auto-complete fileName  ".\<filenames>
        $m  = '.\'  # auto-complete string
        $s  = [system.String]::join('', $p_arg_sCommand[0..1])
        f__trace("compare:<$s> and <$m>")(__LINE__)
        if ($s -eq $m) {
            f__trace("remove filename begin:<$m>")(__LINE__)
            $sTc  = $p_arg_sCommand.SubString(2);
        } else {
            $sTc =  $p_arg_sCommand
        }
        f__trace("useTc:<$sTc>")(__LINE__)

        #   03:find tc in tcAll
        if (!($aTcAll -contains $sTc)) {
            f__error ("unknown Script:'$p_arg_sCommand'")(__LINE__)
            exit(-(__LINE__))
        }
        f__trace("Tc:<$sTc> found in aTc")(__LINE__)

        #   04:define aTc
        $aTc =  @()
        $aTc += $sTc

        #   05:clean
        $sRex = [system.String]::join('', $sTc[0..2])
        $sRex += '*.log'
        f__trace("tryClean:<$sRex> of:<$sTc>")(__LINE__)
        f_clean($sRex)

    } # default

} # switch command:<opt>||<tc>  #   TEST<opt>: ; return __LINE__

#   =*= : LEAVE with single options '?' or 'c'
$n = $aTc.length
if ($n -eq 0) {
    f__trace("?tcList empty")(__LINE__)
    f__menu('footer')(__LINE__)
    exit(-(__LINE__))
}
f__trace "aTcUse($n):{$aTc}" (__LINE__)

#   :m+ calling-mode for TC
#   ? Is the TC
#       a) directly via PSH or
#       b) called by this script
$env:v_mode_bBat = $TRUE   # informs the TC whether BATCH or

#   :m+ eap:=true
$v_ErrorActionPreference = $ErrorActionPreference   # save
$ErrorActionPreference = 'stop' # stop's immediately hard errors

#   ---------------------------------------------------------------------------
#   =*= :m+ run the TC
#   ---------------------------------------------------------------------------

#   logging: RUNTIME.start
$iRunTime           =   f_iRuntime($TRUE)
f__puts "--- START:<$sLogCopyId>" -p_bInf; sleep(1)

#   save and prepare formtted output strings
$nTc    = $aTc.length;              $nTc_s  = "{0:d2}"-f $nTc

#   start
$iRunTimeTc_min = [int64]([string](Get-Date -Format 'yyMMddHHmmss'))
f__puts ">>> RUN: <{$iRunTimeTc_min}> ..." -p_bInf ; sleep(1)

$iTc = 0
$aRc = @()
foreach ($xTc in $aTc) {

    $iTc ++         # 1..n

    #   show+log : runTc[<current>/<max>]
    $iTc_s  = [String]::Format("{0:d2}", $iTc);
    $s = "runTc : [$iTc_s/$nTc_s] : '$xTc' "
    puts $s -p_bNoNl    # puts $s 'white' -p_bNoNl

    #   build filename
    $sSrc       = [io.path]::GetFileName($xTc)
    $sBaseName  = [io.path]::GetFileNameWithoutExtension(  $sSrc )
    $sObj       = "c89_$sBaseName.$C_sExtensionId_obj"

    #   compile
    f_compile($sSrc) ($sObj)         #   +++ COMPILING +++

    #   check the error code
    if (f_bCheckEc( $g_iEc )) {
        $aRc += $sObj
    } # if checkEc
    else {
        f__error("?Tc:={$iTc}")(__LINE__)
    }

} # foreach TC

$iRunTimeTc_max = [int64]([string](Get-Date -format yyMMddHHmmss))
f__puts "<<< RUN: <$iRunTimeTc_max>..." -p_bInf ; sleep(1)

# show
$n = $aRc.length;  f__puts "aRc($n):{$aRc} at DIR:{$v_DIR_obj}" -p_bTab -p_bCol

#   logging: RUNTIME.stop
$iRunTime = f_iRuntime($FALSE)
f__puts "--- STOP!:<$sLogCopyId>:iRT:={$iRunTime}" -p_bInf; sleep(1)

#   ---------------------------------------------------------------------------
#   =*= :m+ finish
#   ---------------------------------------------------------------------------

#   =*= :footer
f__menu('footer')(__LINE__)($iRunTime) #    -p_bChkEc

#   :m+ eap:=false
$ErrorActionPreference = $v_ErrorActionPreference

exit(__LINE__)
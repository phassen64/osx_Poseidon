#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::invoke   ###:[2025-06-20]
#   ***************************************************************************
<#
    des:    invoke a DOS-file which changes the environment    
    rem:    not Invoke-Command
    content:
    •   b:  include
    •   b:  header
            •   m:  compare cmd&psh
            •   m:  invoke ComSpec Script
    •   b:  footer
#>
<#
    CMD [/A | /U] [/Q] [/D] [/E:ON | /E:OFF] [/F:ON | /F:OFF] [/V:ON | /V:OFF]
        [[/S] [/C | /K] string]    
    /C      Carries out the command specified by string and then terminates
    /K      Carries out the command specified by string but remains
    /Q      Turns echo off
    /D      Disable execution of AutoRun commands from registry (see below)
#>

#   encoding: Windows-1252
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

<#  
    in PSH
    $x = '"D:\repository\GIT\console\tutorial\wPsh\w21_invoke.bat" Baby & set'
    $a = & $env:ComSpec /c $x        
    $a | Select-String '^([^=]*)=(.*)$' 
    *   all v_ variables
    $a | Select-String '^v_'
#>
    

#   internet solution
function F_mod_invoke1([string]  $p_pScp,
                      [string]  $p_sArg = $null )  {
    trace(__LINE__)(__FILE__) 'invoke1'
    $sCmd = """$p_pScp"" $p_sArg & set"
#   & $env:SystemRoot\system32\cmd.exe /c $sCmd
    & $env:ComSpec /d /c $sCmd |
    Select-String '^([^=]*)=(.*)$' | ForEach-Object {
        $k = $_.Matches[0].Groups[1].Value
        $v = $_.Matches[0].Groups[2].Value
        Set-Item -LiteralPath env:$k $v
    }
} # F~invoke

#   my variant
function F_mod_invoke2([string]  $p_pScp,
                      [string]  $p_sArg = $null )  {
    trace(__LINE__)(__FILE__) 'invoke2'
    $sCmd = """$p_pScp"" $p_sArg & set"
    $aCmd = (& $env:ComSpec /d /c $sCmd) | Sort-Object
    foreach ($xCmd in $aCmd) {
        $sKey = $xCmd.Split('=')[0]
        $sVal = $xCmd.Split('=')[1]    
        Set-Item -LiteralPath env:$sKey $sVal
    }    
} # F~invoke2

#   get all environment variables 
#   1)  via CMD 
#   2)  via PSH 
function F_mod_test([switch] $o_verbose)  {
    trace(__LINE__)(__FILE__) 'test'
    info("vbs:<$o_verbose>")(__LINE__)
    $aRc  = @()
    #   get.env
    $aCmd = (& $env:ComSpec /c 'set') | Sort    # '__DOTNET_ADD_64BIT=1'
    $aPsh = Get-ChildItem env:* | Sort # '[__DOTNET_ADD_64BIT, 1]'
    #   get.minLen
    $iLen = $aCmd.Length   
    if ($iLen -lt $aPsh.Length) {
        $iLen = $aPsh.Length           
    }
    #   tmp.hash
    $hCmd = @{}
    $hPsh = @{}
    #   sep for output
    $cSep = ';'
    for($i = 0; $i -lt $iLen; $i++) {
        $iRc    = $i
        if ($null -eq $aCmd[$i]) {
            break
        }
        #   fetch cmd
        $hCmd.m_sKey = $aCmd[$i].Split('=')[0]
        $hCmd.m_sVal = $aCmd[$i].Split('=')[1]
        #   fetch psh
        $hPsh.m_sKey = $aPsh[$i].Name
        $hPsh.m_sVal = $aPsh[$i].Value
        if ($sCmd -eq $sPsh) {
            $aRc += $aCmd[$i]
        } else {
            if ($o_verbose) {
                trace(__LINE__)(__FILE__) 'cmd<>psh'
                puts "?[$i]:'$sCmd'!='$sPsh'" 'Yellow'                        
            }            
        }
    }
    return $aRc
} # F~test
   
#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @"
=== :   PSH array
        m:  compare cmd&psh
        m:  invoke ComSpec Script
"@

$g_sColor_text  =    'DarkYellow'

#
#   m:  compare.cmd&psh
#

f_lib_menu("compare.cmd-psh")(__LINE__)

$aRc = F_mod_test -o_verbose
$iRc = $aRc.Length
puts "?env:cmd==psh : '$iRc"


#
#   m:  invoke
#

f_lib_menu("invoke")(__LINE__)


#   build batch-path
 
$d = (Get-Location).Path
$x = $MyInvocation.MyCommand.Name
$f = [io.path]::GetFileNameWithoutExtension($x)  #   peter
$f += '.bat'
$p = $d + '\' + $f
$s = "p:='$p'"
    
$bRc = f_lib_isFile($p)
puts "$s =: $bRc"   
if ($bRc) {
    $iMod = Get-Random 2
    text("ready invoke:<$iMod>")(__LINE__)    
    if ($iMod -eq 0) {
        F_mod_invoke1($p)('Ezra')        
    } else {
        F_mod_invoke2($p)('Baby')        
    }
    #   fetch new values
    $sPar = $env:v_DUMMY_par
    $sDtm = $env:v_DUMMY_dtm
    $sRnd = $env:v_DUMMY_rnd
    show "&&& par:<$sPar>: dtm:<$sDtm> rnd:<$sRnd>"
}

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::process                    ###:[2024-11-30]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  get.Process
        •   m:  start.Process
        •   m:  stop.Process
    •   b:  footer
#>


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @"
=== :   PSH process
        m:  get
        m:  start
        m:  stop

"@

#   menu
$g_sColor_text  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'

#   random
$iRnd = Get-Random -Maximum 10     # 0..n-1
$bRnd = ($iRnd % 2 -eq 0)

#
#   m:  get.Process
#

f_lib_menu("Get-Process")(__LINE__)

#
#   s:  get.all
#

f_lib_menuS1("all")(__LINE__)
$p      = Get-Process
$iLen   = $p.Length
$n      = $p.count
show "p.Len     : <$iLen>"
show "p.Count   : <$n>"

#   split
$m = [math]::round($n / 20)
show "p.parts  :  <$m>"

#   show
$i = 0
foreach($x in $p) {
    if ($i % $m -eq 0) {
        show "process[$i] : <$x>"
    }
    $i ++
}

#
#   s:  get.special
#

f_lib_menuS1("special")(__LINE__)
Get-Process | Where-Object { `
        ($_.ProcessName -eq 'powershell')  -or ($_.ProcessName -eq 'winlogon') `
}


#
#   m:  start.Process
#

if ($bRnd) {

    f_lib_menu "Start-Process" (__LINE__)

    $sPrg = "Notepad"
    $sExe = $sPrg + ".exe"

    text("run sub-process : <$sExe>...")
    delay(2)

    #   start 3 Notepads
    f_lib_menuS1("start 3 notepads")
    $i = 0
    $n = 3
    1..$n | %{
            $i += 1
            text "run[$i/$n] :'$sExe'"
            Start-Sleep 2
            Start-Process $sExe
    }
    Start-Sleep 1

    #   show notepad 1-3
    f_lib_menuS1("show process")
    Get-Process $sPrg
    delay(3)

    f_lib_menuS1("show processId")
    $p      = Get-Process $sPrg
    $aId    = $p.Id
    text "aId:<$aId>"

    #
    #   m:  stop.Process
    #

    f_lib_menu "Stop-Process" (__LINE__)


    text("delete all <$sPrg> processId")

    foreach ($x in $aId) {
        text "Stop-Process Id :<$x>"
        Start-Sleep 1
        Stop-Process $x 2>&1 3>&1 >> $fOut      # sometimes error
    }

}   # bRnd


#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

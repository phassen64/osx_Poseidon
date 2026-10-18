#   ---- readme PSH Tutorial

#   encoding.UTF8:
    !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   powershell-scripting frei schalten:
$>  Set-ExecutionPolicy 'Restricted'

$>  Set-ExecutionPolicy -ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser'

#   work before starting with go

$>  Set-Alias -Name _go  -Value  ".\run_wpsTutor.ps1"
$>  $env:v_FWK_mode_bClear = 'true'
$>  $env:v_FWK_mode_bVerbose = 'true'
$>  $env:v_FWK_mode_iLogging = '2'


<#
    overview tutorial
        •   p:  intro           •   p:  rex
        •   p:  dataType        •   p:  integer
        •   p:  operator        •   p:  math
        •   p:  condition       •   p:  dateTime
        •   p:  looping         •   p:  file
        •   p:  function        •   p:  csv
        •   p:  class           •   p:  process
        •   p:  array           •   p:  dummy
        •   p:  hash            •   p:  system
        •   p:  string          •   p:  misc
#>

#   Aufruf-Reihenfolge

    go.ps1          ->      v01_intro.ps1
    v01_intro.ps1   ->      HELP.inc.ps1
    HELP.inc.ps1    ->      TUT.inc.ps1

=   go.ps1
    param(  # 7 para
        [string]    $p_sCmd,                #  '+','-', or Tc
        [int]       $p_iRepeat  = 1,        #   stress counter
        [string]    $p_sRex = $C_sRexStd,   #   pattern to match
        [switch]    $o_raw,                 #   ?output directly to screen
        [switch]    $o_verbose,             #   ?info-text and traces
        [switch]    $o_color,               #   color ?
        [switch]    $o_logging,             #   logging ?
        [switch]    $o_auto,                #   logFile autoNaming
        [switch]    $o_help                 #   run usage
    )

=   HELP.inc.ps1
    param(
        [string]    $p__sScp
    )
    * uses
         $env:v_FWK_mode_bBatch
         $env:v_FWK_mode_bClear
         $env:v_FWK_mode_bVerbose
         $env:v_FWK_mode_iLogging


=   TUT.inc.ps1
    param(
        [string]    $p__sScp,
        [int]       $p__iLogMode,   # 1:std, 2:autoNaming, else:noLogging
        [switch]    $o__bColor,
        [switch]    $o__bVerbose    # info && trace
    )

#   note:
#   $>  $s | Get-Member
#   $<  shows all members of a string

--- ScratchDir
    $d = "$env:UserProfile\Temp"; dir $d
    $d = "$env:UserProfile\Temp"; gci $d

--- examples
+   run w01 and do logging
     $>  go .\w01_intro.ps1 -p__iLogMode 1

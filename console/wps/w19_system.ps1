#   ***************************************************************************
#   TUTORIAL PowerShell:    system                          ###:[2024-11-30]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url:https://learn.microsoft.com/de-de/powershell/?view=powershell-7.4

<#
    overview tutorial
#>
<#
    content:
    •   b:  include
    •   b:  header
        •   m:  Preference-Variable
        •   m:  Automatic-Variable
        •   m:  get-Command
        •   m:  get-Module
        •   m:  get-Alias
    •   b:  footer
#>

#   m:  include

.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  function
#

function F_show([string]$p_sNam, [string]$p_sVal) {
    $s = "$p_sNam `t =: < " + $p_sVal + " >"
    show $s
} # F~show

#   ###########################################################################
#   b:  body
#   ###########################################################################

#
#   b:  header
#

f_lib_header(__LINE__)

Write-Host @"
=== :   PSH system
        m:  variable.automatic
        m:  variable.preference
        m:  get.command
        m:  get.module
"@

$g_sColor_show  =       $C_sColor_std
#   $g_hMenuTabulator['out'] = $g_hMenuTabulator['spc']


#
#   m:  Automatic-Variable
#

#   https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.4

f_lib_menu("variable.Automatic")(__LINE__)

F_show  '$$'    $$
F_show  '$?'    $?
F_show  '$^'    $^
F_show  '$_'    $_
F_show  '$args' $args
F_show  '$ConsoleFileName' $ConsoleFileName
F_show  '$EnabledExperimentalFeatures' $EnabledExperimentalFeatures
F_show  '$Error' $Error
F_show  '$Event' $Event
F_show  '$EventArgs' $EventArgs
F_show  '$EventSubscriber' $EventSubscriber
F_show  '$ExecutionContext' $ExecutionContext
F_show  '$false' $false
show  '$foreach:<>'     #   !CRQ-241203:don'tShow:$foreach
F_show  '$HOME' $HOME
F_show  '$Host' $Host
F_show  '$input' $input
F_show  '$IsCoreCLR'    $IsCoreCLR
F_show  '$IsLinux'      $IsLinux
F_show  '$IsMacOS'      $IsMacOS
F_show  '$IsWindows'    $IsWindows
F_show  '$LASTEXITCODE' $LASTEXITCODE
F_show  '$Matches'    $Matches
F_show  '$MyInvocation'    $MyInvocation
F_show  '$NestedPromptLevel'    $NestedPromptLevel
F_show  '$null'    $null
F_show  '$PID'    $PID
F_show  '$PROFILE'    $PROFILE
F_show  '$PSBoundParameters'    $PSBoundParameters
F_show  '$PSCmdlet'    $PSCmdlet
F_show  '$PSCommandPath'    $PSCommandPath
F_show  '$PSCulture'    $PSCulture
F_show  '$PSDebugContext'    $PSDebugContext
F_show  '$PSEdition'    $PSEdition
F_show  '$PSHOME'    $PSHOME
F_show  '$PSItem'    $PSItem
F_show  '$PSScriptRoot'     $PSScriptRoot
F_show  '$PSSenderInfo'     $PSSenderInfo
F_show  '$PSUICulture'      $PSUICulture
F_show  '$PSVersionTable'   $PSVersionTable
F_show  '$PWD'      $PWD
F_show  '$Sender'   $Sender
F_show  '$ShellId'  $ShellId
F_show  '$StackTrace'  $StackTrace
F_show  '$switch'  $switch
F_show  '$this'  $this
F_show  '$true'  $true

#
#   m:  Preference-Variable
#

#   https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.4


f_lib_menu("variable.Preference")(__LINE__)

F_show '$ConfirmPreference' $ConfirmPreference
F_show '$DebugPreference'           $DebugPreference
F_show '$ErrorActionPreference'     $ErrorActionPreference
F_show '$ErrorView'                 $ErrorView
F_show '$FormatEnumerationLimit'    $FormatEnumerationLimit
F_show '$InformationPreference'     $InformationPreference
F_show '$LogCommandHealthEvent'     $LogCommandHealthEvent
F_show '$LogCommandLifecycleEvent'  $LogCommandLifecycleEvent
F_show '$LogEngineHealthEvent'      $LogEngineHealthEvent
F_show '$LogEngineLifecycleEvent'   $LogEngineLifecycleEvent
F_show '$LogProviderLifecycleEvent' $LogProviderLifecycleEvent
F_show '$LogProviderHealthEvent'    $LogProviderHealthEvent
F_show '$MaximumAliasCount'         $MaximumAliasCount
F_show '$MaximumDriveCount'         $MaximumDriveCount
F_show '$MaximumErrorCount'         $MaximumErrorCount
F_show '$MaximumFunctionCount'      $MaximumFunctionCount
F_show '$MaximumHistoryCount'       $MaximumHistoryCount
F_show '$MaximumVariableCount'      $MaximumVariableCount
F_show '$OFS'                       $OFS
F_show '$OutputEncoding'            $OutputEncoding
F_show '$ProgressPreference'        $ProgressPreference
F_show '$PSDefaultParameterValues'  $PSDefaultParameterValues
F_show '$PSEmailServer'             $PSEmailServer
F_show '$PSModuleAutoLoadingPreference'     $PSModuleAutoLoadingPreference
F_show '$PSNativeCommandArgumentPassing'    $PSNativeCommandArgumentPassing
F_show '$PSNativeCommandUseErrorActionPreference' $PSNativeCommandUseErrorActionPreference
F_show '$PSSessionApplicationName'      $PSSessionApplicationName
F_show '$PSSessionConfigurationName'    $PSSessionConfigurationName
F_show '$PSSessionOption'           $PSSessionOption
F_show '$PSStyle'                   $PSStyle
F_show '$Transcript'                $Transcript
F_show '$VerbosePreference'         $VerbosePreference
F_show '$WarningPreference'         $WarningPreference
F_show '$WhatIfPreference'          $WhatIfPreference

#
#   m:  get-Command
#

f_lib_menu("Get-Command")(__LINE__)

$pCmd   = Get-Command
$iLen   = $pCmd.Length
$n      = $pCmd.count
show "pCmd.Len     : <$iLen>"
show "pCmd.Count   : <$n>"

#   split
$m = [math]::round($n / 20)
show "p.parts  :  <$m>"

#   show
$i = 1
foreach($x in $pCmd) {
    if ($i % $m -eq 0) {
        show "command[$i] : <$x>"
    }
    $i ++
}

#
#   m:  get-Module
#

f_lib_menu("Get-Module")(__LINE__)


$pMod   = Get-Module
$iLen   = $pMod.Length
$n      = $pMod.count
show "pMod.Len     : <$iLen>"
show "pMod.Count   : <$n>"


#   show
$i = 1
foreach($x in $pMod) {
    show "module[$i] : <$x>"
    $i ++
}

#
#   m:  get-Alias
#

f_lib_menu("Get-Alias")(__LINE__)

$pAli   = Get-Alias
$iLen   = $pAli.Length
$n      = $pAli.count
show "pAli.Len     : <$iLen>"
show "pAli.Count   : <$n>"

#   split
$m = [math]::round($n / 20)
show "p.parts  :  <$m>"

#   show
$i = 1
foreach($x in $pAli) {
    if ($i % $m -eq 0) {
        show "alias[$i] : <$x>"
    }
    $i ++
}

#
#   b:  footer
#

f_lib_footer(__LINE__)


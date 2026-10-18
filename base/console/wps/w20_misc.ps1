#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::misc                  ###:[2024-11-17]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

<#
    content:
    •   b:  include
    •   b:  header
            •   m:  compareArray
            •   m:  scopeVariable
            •   m:  errorHandling
                •   s:  error.ActionPreference
                •   s:  error.Count
                •   s:  error.Clear
                •   s:  error.generate
                •   s:  error.variable
                •   s:  error.block:[try.catch.finally]
                •   s:  error.block:[trap]
            •   m:  selectString
            •   m:  archives
                •   s:  arc.compress
                •   s:  arc.expand
    •   b:  footer
#>

<#  error.PSH
    •   SilentlyContinue
        Die Fehlermeldung wird unterdrückt und PowerShell
        fÜhrt mit der Ausführung des Codes fort.
    •   Ignore
        Der Fehler wird ignoriert und taucht
        nicht im Error-Stream auf.
    •   Continue
        Dabei handelt es sich um das Standard-Verhalten.
        Fehlermeldungen werden (in roter Schrift) ausgegeben
        und das Script setzt seine AusfÜhrung fort.
    •   Stop
        Erzwingt ein Verhalten wie bei einem terminierenden Fehler,
        die AusfÜhrung wird also abgebrochen.
    •   Inquire:
        Fragt den Benutzer, ob er die Ausf�hrung fortsetzen m�chte.
#>

#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @"
=== :   PSH array
        m:  compare-Array       :   Compare-Object
        m:  scope-Variable      :   global,local,private,script
        m:  error-Handling      :   count,generate,block
        m:  select-String       :   search-String
"@

#   using
$g_sColor_text  =    'DarkYellow'
$g_sColor_show  =    'Gray'  #   $C_sColor_silent

#
#   m:  compareArray
#

f_lib_menu("compare array")(__LINE__)


$n = 5
$iRndMin = 1
$iRndMax = 4

$aDim   = @(@(),@())

for ($j = 0; $j -lt $aDim.length; $j++) {
    $a = @()
    for( $i = 1; $i -le $n; $i ++) {
        $a += ( Get-Random -Minimum $iRndMin  -Maximum $iRndMax )
    }
    $a  = $a  | Select-Object -Unique  # remove doubles
    $a  = $a  | Sort-Object
    $aDim[$j] = $a
}

#   show
for ($j = 0; $j -lt $aDim.length; $j++) {
    $a = $aDim[$j]
    show "a = <$a>"
}

#   compare both arrays
$pDif   = Compare-Object -ReferenceObject $aDim[0] -DifferenceObject $aDim[1]

#   save into target array
$aDif   = @()
$pDif | % {
    $aDif += $_.InputObject
}
$aDif = $aDif | sort

$bRc = $false
if ($aDif.length -eq 0) {
    $bRc = $True
}
show "compare (a1,a2) : == <$bRc>"

#
#   m:  scopeVariable
#

f_lib_menu("scope")(__LINE__)

    $global:i       = __LINE__
    $local:i        = __LINE__
    $private:i      = __LINE__
    $script:i       = __LINE__


show "global:i      =:  <$global:i>"
show "local:i       =:  <$local:i>"
show "private:i     =:  <$private:i>"
show "script:i      =:  <$script:i>"


#
#   m:  errorHandling
#

f_lib_menu("error handling")(__LINE__)

#
#   s: error.ActionPreference
#

f_lib_menuS1 "error.ActionPreference" (__LINE__)

#   get Error-Action-Preference
$x = $ErrorActionPreference
$xErrorActionPreference = $x    # save
show "ErrorActionPreference(1) =: '$x'" # continue
$ErrorActionPreference  = 'SilentlyContinue'        # !PHA: now ready for errors
$x = $ErrorActionPreference; show "ErrorActionPreference(2) =: '$x'" # continue

#
#   s:  error.Count
#

f_lib_menuS1 "error.count" (__LINE__)
$i = $Error.count  # saves last 256 errors
show "error.count := <$i>" # continue

#
#   s:  error.Clear
#

f_lib_menuS1 "error.clear" (__LINE__)
$Error.clear()  # saves last 256 errors
$i = $Error.count  # saves last 256 errors
show "error.count.B := <$i>" # continue

#
#   s:  error.generate
#

f_lib_menuS1 "error.generate" (__LINE__)

#   generate error DIV by ZERO
text('generate ERROR : DivByZero')(__LINE__)
$i = 5
$x = $i / 0                 # Error1: division by zero

text('generate ERROR : alias new')(__LINE__)
New-Alias -Name a_Tmp  -value "hans"
New-Alias -Name a_Tmp  -value "peter" # Error2: wrong alias
# this is not shown in the trap block

#  Reset ErrorActionPreference
text('reSet :ErrorActionPreference')(__LINE__)
$ErrorActionPreference = $xErrorActionPreference
$x = $ErrorActionPreference; show "ErrorActionPreference(3) =: '$x'" # continue

#
#   s:  error.variable
#

f_lib_menuS1 "error.variable" (__LINE__)

#   show error attributes
text('Error.<attributes>')(__LINE__)
$x = $Error.Count; show "Error.Count =: '$x'"
$x = $Error.Capacity; show "Error.Capacity =: '$x'"
$x = $Error.IsReadOnly; show "Error.IsReadOnly =: '$x'"

#   show all errors
text("show all errors in :<'`$Error'>")(__LINE__)
$aError = $Error        # is array-list
$t      = $Error.GetType()
$n      = $Error.Count
for ($i=0; $i -lt $n; $i++) {
    $e = $aError[$i]
    $j = $i+1
    show "Error[$j/$n] =: '$e'"
}

#   clear again
text('clear again errors')(__LINE__)
$Error.clear()
$x = $Error.Count; show "Error.Count =: '$x'"


#
#   s:  error.block:[try.catch.finally]
#

$g_sColor_show  =   $C_sColor_result

f_lib_menuS1("error.block:[try-catch-finally]")(__LINE__)

$Error.clear()
try {
    $ErrorActionPreference  = 'SilentlyContinue'    # avoid read warnings
    $i = 99
    $x = $i / 0 # generate error
}
catch {
    $sEc = $Error[0]
    show "TryErrorHandler : <$sEc>"
}
finally {
    show "This finally-block will be shown always!"
    $ErrorActionPreference  = 'Continue'
}
$Error.clear()
text("ready block.try")(__LINE__)


#
#   s:  error.block:[trap]
#

#
#   !REM:the position may be anywhere in the script
#

f_lib_menuS1("error.block:[trap]")(__LINE__)

trap {
    $sEc = $Error[0]
    show "TrapErrorHandler : <$sEc>"
    $Error.clear()
}
text("ready block.trap")(__LINE__)

#
#   m:  selectString
#

f_lib_menu("selectString")(__LINE__)

$sPattern = 'Tutor'
$aRc = Select-String -Path '*.ps1' -Pattern $sPattern
$iRc = $aRc.Length
show "Found string '$sPattern' <$iRc> times"

text("ready select")(__LINE__)


#
#   m:  archives
#

#   h:  https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.archive/

f_lib_menu("archives")(__LINE__)

#   fetch local dir
$dPwd = Get-Location
text("dirPwd:<$dPwd>") (__LINE__)

#   create class object
$X  = [CTutor]::new((__FILE__),(Get-Date))
$X.f_info()

#   mode
$bMode_test     = $false
$bMode_verbose  = $true

#
#   s:  arc.compress
#

f_lib_menuS1("compress")(__LINE__)

#   create dir.ZIP
$dCompress   =   $X. f_mkTestDir($null)
text("dirCompr:<$dCompress>") (__LINE__)

#   make source pattern
$xSrc = "$dPwd\w*.ps1","*.txt"
$fObj = 'Sometimes.zip'
$xObj = "$dCompress\$fObj"

#   do.compress
Compress-Archive    `
    -Path $xSrc     `
    -Destination $xObj `
    -WhatIf:$bMode_test  `
    -Update `
    -Verbose:$bMode_verbose

f_lib_delay(1)

#
#   s:  arc.expand
#

f_lib_menuS1("expand arc")(__LINE__)

#   create dir.UNZIP
$dExpand =  $X. f_mkTestDir('x')
text("dirExpnd:<$dExpand>") (__LINE__)

Expand-Archive    `
    -LiteralPath "$xObj" `
    -Destination $dExpand `
    -Force  `
    -WhatIf:$bMode_test  `
    -Verbose:$bMode_verbose

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

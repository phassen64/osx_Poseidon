#   ***************************************************************************
#   TUTORIAL PowerShell:    dummy                           ###:[2024-11-22]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url:https://learn.microsoft.com/de-de/powershell/?view=powershell-7.4

<#
    overview tutorial
#>
<#
    content:
    �   b:  include
    �   b:  header
    �   b:  footer
#>

#   m:  include

.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


#   ###########################################################################
#   b:  body
#   ###########################################################################


#
#   b:  header
#

f_lib_header(__LINE__)

Write-Host @"
=== :   PSH dummy
        m:  dummy
"@


#   bug(__LINE__)("p==0")
#   $b = $false; assert ($b) (__LINE__)

$x      =   [CTutor]::new((__FILE__),(Get-Date))
$s      =   $x. f_mkTestDir($null)
puts "** created TestDir:<$s>"


#
#   b:  footer
#

f_lib_footer(__LINE__)


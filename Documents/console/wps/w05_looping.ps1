#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::looping                ###:[2024-11-15]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell/powershell_looping.htm

<#
    content:

    •   b:  include

    •   b:  header

        •   m:  for.loop
            •   s:  break
            •   s:  continue
        •   m:  foreach
        •   m:  while
        •   m:  do...while

    •   b:  footer

#>


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


$g_sColor_text = $C_sColor_std
$g_sColor_show = $C_sColor_silent

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @"
=== :   PSH looping
        m:  for.loop
        m:  while
        m:  do...while
        m:  foreach
"@

#   using
$n           = 8
$nSampleSize = Get-Random -Minimum 2 -Maximum $n   # 0..n-1
$nBreak      = Get-Random -Minimum 1 -Maximum $nSampleSize

puts "`n;"
puts "&&& using max          = <$n>"  -p_sColor $C_sColor_silent
puts "&&& using nSampleSize  = <$nSampleSize>"  -p_sColor $C_sColor_silent
puts "&&& using nBreak  = <$nBreak>"  -p_sColor $C_sColor_silent



#
#   m:  for.loop
#

f_lib_menu("for")(__LINE__)

for($i = 0; $i -lt $nSampleSize; $i ++) {
    $x = Get-Random -Maximum 100
    text("for[$i]: '$x'")
}

#
#   s:  for.break
#

f_lib_menuS1("for.break:<$nBreak>")(__LINE__)

for($i = 0; $i -lt $nSampleSize; $i++) {
    $x = Get-Random -Maximum 100
    text("for.break[$i]: '$x'")
    if ($i -eq $nBreak) {
        break   # leave loop
    }
}

#
#   s:  for.continue
#

f_lib_menuS1("for.continue:<$nBreak>")(__LINE__)

for($i = 0; $i -lt $nSampleSize; $i++) {
    $x = Get-Random -Maximum 100
    if ($i -eq $nBreak) {
        continue  # goto start, but repeat loop
    }
    text("for.break[$i]: '$x'")
}

#
#   m:  while
#

f_lib_menu("while")(__LINE__)

$i = 0
while ( $i -lt $nSampleSize ) {
    $x = Get-Random -Maximum 100
    text("while[$i]: '$x'")
    $i += 1
}

#
#   m:  do...while
#

f_lib_menu("do...while")(__LINE__)

$i = 0
do {
    $x = Get-Random -Maximum 100
    text("doWhile[$i]: '$x'")
    $i += 1
} while ( $i -lt $nSampleSize )



#
#   m:  foreach
#


f_lib_menu("foreach")(__LINE__)

#   init sample
$aSample = @()
for($i = 0; $i -lt $nSampleSize; $i++) {
    $x = Get-Random -Maximum 100
    $aSample += $x
}

#   using foreach
$i = 0
foreach ( $x in $aSample ) {
    text("foreach[$i]: '$x'")
    $i += 1
}


#   b:  footer
f_lib_footer(__LINE__); exit(-(__LINE__))

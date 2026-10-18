#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::conditon               ###:[2024-11-13]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell/powershell_conditions.htm

<#
    content:

    •   b:  include

    •   b:  header

        •   m:  if
            •   s:  if.only
            •   s:  if-else
            •   s:  if-else-elsif

        •   m:  switch
            •   s:  switch.simple
            •   s:  switch.true
            •   s:  switch.contains
            •   s:  switch.wildcard
            •   s:  switch.wildcard.case

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

#   write a multi-line string
Write-Host @"
=== :   PSH DataTypes
        m:  if
            s:  if.only
            s:  if-else
            s:  if-else-elseif
        m:  switch
            s:  switch.simple
            s:  switch.true
            s:  switch.contains
            s:  switch.wildcard
            s:  switch.wildcard_with_case
"@


$sCol = $C_sColor_silent

#
#   m:  if
#

f_lib_menu("if")(__LINE__)

#   using
$n = 5
$i = Get-Random -Maximum $n   # 0..n-1

text "&&& using i   = <$i>"  -p_sColor $sCol
text "&&& using max = <$n>"  -p_sColor $sCol

#   s:  if.only
f_lib_menuS1("ifOnly")(__LINE__)

if ($i -gt 0) {
   text "YES: i is greater than 0"
}

#   s:  if-else
f_lib_menuS1('if-else')(__LINE__)

if ($i -gt 1) {
   text "YES: i is greater than 1"
} else {
   text "NOT: i is NOT greater 1"
}

#   s:  if-else-elsif
f_lib_menuS1('if-else-elseif')(__LINE__)
$i = $n
if ($i -gt 2) {
   text "YES: i > $n"
} elseif ($i -lt $n) {
   text "YES: i < $n"
} else {
   text "NOT:  i<$n || i>$n"
}


#
#   m:  switch
#

f_lib_menu("switch")(__LINE__)

$c = 'x'
text "&&& using  c='$c'"    -p_sColor $sCol

#
#   s:  switch.simple
#

f_lib_menuS1('simple')(__LINE__)

switch($c) {
    88      { $iRc = 1 }
    'x'     { $iRc = 2 }
    default { $iRc = 0 }
}
show "found.iRc = <$iRc>"   # <<< 2

#
#   s:  switch.true
#

f_lib_menuS1('switch.true')(__LINE__)

#   get random char
$s = 'ABCDEFGHIJ'
$i = Get-Random -Maximum $s.length    # 0..max-1
$c = $s[$i]
text "&&& looking for :'$c'" (-1) $sCol

#   run switch.true
switch ($true) {
    { ($c -eq 'A') -or ($c -eq 'B') } { $s = 'A|B' }
    { ($c -eq 'C') -or ($c -eq 'D') } { $s = 'C|D' }
    { ($c -eq 'E') -or ($c -eq 'F') } { $s = 'E|F' }
    { ($c -eq 'G') -or ($c -eq 'H') } { $s = 'G|H' }
    default { $s = 'default' }
}
show "result.true:<$s>"


#
#   s:  switch.contains
#

f_lib_menuS1('switch.contains')(__LINE__)

#   take char above
text "&&& using char again :'$c'" (-1) $sCol

#   run switch.contains
switch ($c) {
    { @('A','B') -contains $_ } { $s = 'A|B' }
    { @('C','D') -contains $_ } { $s = 'C|D' }
    { @('E','F') -contains $_ } { $s = 'E|F' }
    { @('G','H') -contains $_ } { $s = 'G|H' }
    default { $s = 'default' }
}

show "result.contains:<$s>"

#
#   s:  switch.wildcard
#

f_lib_menuS1('switch.wildcard')(__LINE__)

$a = 'ElvIs','MichAel','BritneY'
$l = $a.length
$i = Get-Random -Maximum $a.length   # 0..max-1
$s = $a[ $i]

#   take char above star
text "&&& using star: '$s'" (-1) $sCol

switch -wildcard ($s) {
    'elvi*'    { $i = 1 }
    'mich*el'  { $i = 2 }
    '*ritney'  { $i = 3 }
    default    { $i = 9 }
}

show "result.star('$s') =: $i"


#
#   s:  switch.wildcard.case
#

f_lib_menuS1('switch.wildcard.CASE')(__LINE__)

#   take array above
text "&&& using again star :'$s'" (-1) $sCol

switch -wildcard -case ($s) {
    'ElvI*'    { $i = 1 }
    'mich*el'  { $i = 2 }
    '*ritneY'  { $i = 3 }
    default    { $i = 9 }
}

show "result.star('$s') =: $i"


#   b:  footer
f_lib_footer(__LINE__); exit(-(__LINE__))

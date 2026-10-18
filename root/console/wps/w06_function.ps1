#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::function               ###:[2024-11-15]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell/powershell_looping.htm

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  (-) f_zero(-)
        •   m:  (-) f_uno(s)
        •   m:  (-) f_duo(s,i)
        •   m:  (i) f_inc(i)
        •   m:  param
        •   m:  switch (option)
        •   m:  default
        •   m:  array-return
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
=== :   PSH function
        m:  (-) zero(-)
        m:  (-) uno(s)
        m:  (-) duo(s,i)
        m:  (i) inc(i)
        m:  (i) add(a,b)
        m:  param
        m:  switch
        m:  default
        m:  (a) prime(i)
"@

#   using
$n          = 100
$i = Get-Random -Maximum $n   # 0..n-1
$j = Get-Random -Maximum $n   # 0..n-1

puts "`n&&& using max     = <$n>"  -p_sColor $C_sColor_silent
puts "&&& using i       = <$i>"  -p_sColor $C_sColor_silent
puts "&&& using j       = <$j>"  -p_sColor $C_sColor_silent



#
#   m:  (-) f_zero(-)
#

f_lib_menu("f_zero(-)")(__LINE__)

function f_zero {
    show "hello zero"
}

#   run.fctZero
f_zero


#
#   m:  (-) f_uno(s)
#

f_lib_menu("f_uno(s)")(__LINE__)

function f_uno ( [string] $p_sVal ) {
    text "uno.p1:<$p_sVal>"
}


#   run.uno - directly or with parameter
f_uno ("text1")
f_uno -p_sVal "text2"


#
#   m:  (-) f_duo(s,i)
#

f_lib_menu("f_duo(s,i)")(__LINE__)

function f_duo ( [string] $p_sVal, [int] $p_iVal ) {
    text "duo.p1s:<$p_sVal>; p2i:<$p_iVal>"
}


#   run.duo
f_duo ('harvey')($i)
f_duo -p_sVal "peter" -p_iVal 60


#
#   m:  (i) f_inc(i)
#

f_lib_menu("i=f_inc(i)")(__LINE__)

function f_inc ( [int] $p_iVal ) {
    return  $p_iVal + 1
}

#   run
$iRc = f_inc($i)
text ("inc($i) =: $iRc") (__LINE__)

#
#   m:  param
#

#   syntax: i = f_add{param:i,j}

f_lib_menu("param")(__LINE__)

function f_add {
        param( [int] $a , [int] $b )
    [int] $iRc = $a + $b
    return  $iRc
}

#   run
$iRc = f_add($i)($j)
text ("add($i,$j) =: $iRc") (__LINE__)


#
#   m:  switch (option)
#

#   syntax: i = f_usr([switch] $o_option)

f_lib_menu("switch")(__LINE__)

function f_sUser([switch] $o_upper) {
    $s = $env:UserName
    if ($o_upper) {
        $s = $s.ToUpper()
    }
    return $s
}

#   run.std
$sRc = f_sUser
text ("user.std =: $sRc") (__LINE__)

#   run.using.switch
$sRc = f_sUser -o_upper
text ("user.switch_upper =: $sRc") (__LINE__)



#
#   m:  default
#

f_lib_menu("default")(__LINE__)

function f_bEven ([int] $p_iNumber = 90489) {
    $bEven = $false
    if ( $p_iNumber  % 2 -eq 0 ) {
        $bEven = $true
    }
    return $bEven
}

#   run.withParameter
$bRc = f_bEven $n;  text ("isEven($n) =: $bRc") (__LINE__)
$bRc = f_bEven $i;  text ("isEven($i) =: $bRc") (__LINE__)

#   run.default
$bRc = f_bEven;     text ("isEven(-) =: $bRc") (__LINE__)

#   run.using.switch
$sRc = f_sUser -o_upper
text ("user.switch_upper =: $sRc") (__LINE__)



#
#   m:  array-return
#

f_lib_menu("primeTry")(__LINE__)

function f_aPrimeTry ([int] $p_iCount = 10) {
    $aRc = @()
    for($i = 1; $i -le $p_iCount; $i += 1) {
        if ( ($i % 2 -ne 0) -and ($i % 4 -ne 0) ) {
            $aRc += $i
        }
    }
    return $aRc
}

#   run
$aPrime = f_aPrimeTry
$i = 0
foreach ($x in $aPrime ) {
   $i += 1
   text ("prime[$i] = <$x>") (__LINE__)
}


###

#   b:  footer
f_lib_footer(__LINE__); exit(-(__LINE__))

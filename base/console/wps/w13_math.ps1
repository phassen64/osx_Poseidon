#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::math                   ###:[2024-11-29]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell
#   https://ss64.com/ps/syntax-math.html

<#
    !CRQ-241130:PS5.math
        •   !PS7.tau
        •   !PS7.log10
        •   !PS7.log2
        •   !PS7.magnitude
#>

<#
    content:
    •   b:  include
    •   b:  function
    •   b:  header
        •   m:  value           :   e,pi,!PS7.tau
        •   m:  rounding        :   round,truncate,floor,ceiling
        •   m:  exponentation   :   pow,sqrt,exp,log,(!PS7.log10,!PS7.log2)
        •   m:  trigometry      :   sin,cos,tan,asin,acos,atan
        •   m:  sign            :   sign,abs
        •   m:  extreme         :   max,min,(!PS7.magnitude)
        •   m:  misc            :   equals
    •   b:  footer
#>


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  function
#

function F_compare(
            [string]   $s,
            [double]   $p_dCalculated,  # alpha
            [double]   $p_dEstimated,   # beta
            [int]      $p_iLine = -1 )
{
    #   fetch precision
    $iPrecision = $script:g_iPrecision

    #   recalc
    $dVal1  = [math]::Round($p_dCalculated,$iPrecision)
    $dVal2  = [math]::Round($p_dCalculated,$iPrecision * 2 )

    #   rounded

    #   estimated
    $dTry1   = [math]::Round($p_dEstimated,$iPrecision)
    $dTry2   = [math]::Round($p_dEstimated,$iPrecision * 2)

    #   compare
    $b = $dTry1 -eq $dVal1

    #   evaluate
    if ($b) {
        $sCol = $g_sColor_text
        if ($dTry2 -eq $dVal2) {
            $s = "$s`t == $dVal2"
        } else {
            $s = "$s`t =~ $dVal2"
        }
    } else {
        $sCol = $C_sColor_error
        $s = "$s = $dVal2 : $dTry1 <> $dVal1 =: <$b>"
    }
    text ($s)($p_iLine )($sCol)
    if ($g_bForceAssert) {
        assert ($b) ($p_iLine)
    }

} # F~compare

#   $>  [system.math] | gm -static

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH math
        m:  value
        m:  rounding
        m:  exponentation
        m:  trigometry
        m:  sign
        m:  extreme
        m:  misc
'@

#   menu
$g_sColor_text  =       $C_sColor_std
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'
$g_hMenuTabulator['out'] =  $g_hMenuTabulator['spc']

$g_bForceAssert = $true
$script:g_iPrecision = 3


[double] $x = 0.0
[double] $y = 0.0
[double] $z = 0.0
[int]    $n = 0
[bool]   $bRc = $false

#   ===========================================================================
#   m:  value       :  e, pi, tau
#   ===========================================================================

f_lib_menu("value")(__LINE__)

#   s:  number E
$y = [math]::E
F_compare('E')($y)(2.71828182)(__LINE__)

#   s:  number PI
$y = [math]::PI
F_compare('PI')($y)(3.14159265)(__LINE__)

#   s:  number Tau
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.tau
    $y = [math]::Tau
    F_compare('Tau')($y)(6.28318530)(__LINE__)
}

#   ===========================================================================
#   m:  rounding        :   =: {round,truncate,floor,ceiling}
#   ===========================================================================

f_lib_menu("rounding")(__LINE__)

$x = 1.2345678

#   s:  Round a variable to 0 places.
$y = [math]::Round($x)
F_compare("math::round($x)")($y)(1.0)(__LINE__)

#   s:  Round a variable to $n places.
$n = 3
$y = [math]::Round($x,$n)
F_compare("math::round($x,$n)")($y)(1.235)(__LINE__)

#   s:  Remove the decimal returning only an Integer. Rounds toward zero.
$y = [math]::Truncate($x)
F_compare("math::truncate($x)")($y)(1.0)(__LINE__)

#   s:  extended truncate version in my library
$x = 1.2395654
$n = 2
$y = f_lib_truncate($x)($n) # avoid rounding
F_compare("lib::truncate($x,$n)")($y)(1.23)(__LINE__)

#   s:  floor
$y = [math]::Floor($x)
F_compare("math::floor($x)")($y)(1.0)(__LINE__)

#   s:  ceil
$y = [math]::Ceiling($x)
F_compare("math::ceiling($x)")($y)(2.0)(__LINE__)

#   ===========================================================================
#   m:  exponentation   =: {pow, sqrt, exp, log, log10, log2}
#   ===========================================================================

f_lib_menu("expontation")(__LINE__)

[double] $p = 3.52

#   s:  pow(x,y) = a**b
$x = 2.0
$p = 3.0
$y = [math]::Pow($x,$p)
F_compare("math::pow($x,$p)")($y)(8.0)(__LINE__)

#   s:  sqrt(x)
$x = 100.10
$y = [math]::Sqrt($x)
F_compare("math::sqrt($x)")($y)(10.005)(__LINE__)

#   s:  Exp(n)  = e**n
$x = 2.0
$y = [math]::Exp($x)
F_compare("math::exp($x)")($y)(7.389)(__LINE__)

#   s:  log(e,p) = ln(x)
$y = [math]::Log($x)
F_compare("math::log($x)")($y)(0.693)(__LINE__)

#   s:  log10(x)
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.log10
    $x = 1000
    $y = [math]::Log10($x)
    F_compare("math::log10($x)")($y)(3.0)(__LINE__)
}

#   s:  log2(x)
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.log2
    $x = 32
    $y = [math]::Log2($x)
    F_compare("math::log2($x)")($y)(5.0)(__LINE__)
}

#   ===========================================================================
#   m:  trigometry      =: {sin,cos,tan,asin,acos,atan}
#   ===========================================================================

f_lib_menu("trigometry ")(__LINE__)

$x = [math]::PI / 2

$y = [math]::sin($x)
F_compare("math::sin($x)")($y)(1)(__LINE__)

$y = [math]::cos($x)
F_compare("math::cos($x)")($y)(0)(__LINE__)

$x = [math]::PI / 4
$y = [math]::tan($x)
F_compare("math::tan($x)")($y)(1)(__LINE__)

$x = 1
$y = [math]::asin($x)
$z = [math]::PI / 2
F_compare("math::asin($x)")($y)($z)(__LINE__)

$x = 1
$y = [math]::acos($x)
$z = 0
F_compare("math::acos($x)")($y)($z)(__LINE__)

$x = 1
$y = [math]::atan($x)
$z = [math]::PI / 4
F_compare("math::atan($x)")($y)($z)(__LINE__)

#   ===========================================================================
#   m:  sign        =: {sign,abs}
#   ===========================================================================

f_lib_menu("misc")(__LINE__)

$x = -100.123
$y = 89.1

#   s:  sign(x)
$z = [math]::sign($x)
F_compare("math::sign($x)")($z)(-1)(__LINE__)           # sign==-1

#   s:  abs(x)
$z = [math]::abs($x)
F_compare("math::abs($x)")($z)(100.123)(__LINE__)

#   ===========================================================================
#   m:  extreme     =: {max,min,MaxMagnitude,MinMagnitude}
#   ===========================================================================

f_lib_menu("maxMin")(__LINE__)

#   s:  max(x,y)
$z = [math]::max($x,$y)
F_compare("math::max($x,$y)")($z)($y)(__LINE__)             # y

#   s:  min(x,y)
$z = [math]::min($x,$y)
F_compare("math::min($x,$y)")($z)($x)(__LINE__)             # x


#   *** ignore SIGN

if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.magnitude

    #   s:  MaxMagnitude (x,y)
    $z = [math]::MaxMagnitude($x,$y)
    F_compare("math::maxMagnitude($x,$y)")($z)($x)(__LINE__)    # x

    #   s:  MinMagnitude (x,y)
    $z = [math]::MinMagnitude($x,$y)
    F_compare("math::minMagnitude($x,$y)")($z)($y)(__LINE__)    # y

}

#   ===========================================================================
#   m:  misc    =: {equals}
#   ===========================================================================

f_lib_menu("misc")(__LINE__)

$x = [math]::PI
$y = [math]::PI

#   s:  equals(x,y)

$bRc = [math]::equals($x,$y)
F_compare("math::equals($x,$y)")($bRc)($true)(__LINE__)

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::operator               ###:[2024-11-14]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   https://www.tutorialspoint.com/powershell/powershell_operators.htm
#   des:    operator on dataType :   int,bool,string

<#
    content:

    •   b:  include
    •   b:  header
        •   g:  misc
            •   m:  isType          op:{-is,-isnot}                 ty:any
            •   m:  logical         op:{-and,-or,-xor,-not}         ty:bool
        •   g:  int
            •   m:  arithmetic      op:{+,-,*,/,div,mod}            ty:int
            •   m:  assignment      op:{=,+=,-=,*=,/=}              ty:int
            •   m:  incrementer     op:{++,--}                      ty:int
            •   m:  compare         op:{-eq,-ge,-gt,-le,-lt,-neq}   ty:int
            •   m:  bitwise         op:{-band,-bor,-bxor,-bnot}     ty:int
        •   g:  string
            •   m:  like            op:{-[c|i][Not]like}            ty:string
        •   g:  array
            •   m:  contains        op:{-[c|i][Not]contains}        ty:array
            •   m:  inArray         op:{-in,-notIn}                 ty:array
    •   b:  footer

#>

#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


#
#   b:  function
#

function F_binStr(
            [int]       $p_iNumber,
            [int]       $p_iSize )       {
    return f_lib_zeroNumberString($p_iNumber)(2)($p_iSize) -o_grouping
}


#   b:  header
f_lib_header(__LINE__)


#   write a multi-line string
Write-Host @"
=== :   PSH operator
        •   m:  isType          ty:any
        •   m:  logical         ty:bool
        •   m:  arithmetic      ty:int
        •   m:  assignment      ty:int
        •   m:  incrementer     ty:int
        •   m:  compare         ty:int
        •   m:  bitwise         ty:int
        •   m:  like            ty:string
        •   m:  contains        ty:array
        •   m:  inArray         ty:array
"@


$g_sColor_text = $C_sColor_std
$g_sColor_show = $C_sColor_silent

#   using
$n = 16
$i = Get-Random -Maximum $n     # 0..n-1
$j = Get-Random -Maximum $n     # 0..n-1
$k = Get-Random -Maximum $n     # 0..n-1

#   ===========================================================================
#   g:  misc
#   ===========================================================================

#
#   m:  isType          op:{-is,-isnot}         ty:any
#

f_lib_menu("isType")(__LINE__)

#   define some vars
[bool]      $b = $true
[string]    $s = 'peter'
[array]     $a = 1,'b',3
[int]       $i = 9
[single]    $g = 9.321
[hashtable] $h = @{ "name" = "peter"}
[DateTime]  $d = Get-Date

#   show
show "using s=<$s>; i=<$i>; a=<$a>; h=<$h>"

#   operator: -is
$bRc = $b -is [bool]; text "x := <$b> -is [bool] = $bRc" (__LINE__)
$bRc = $s -is [string]; text "x := <$s> -is [string] = $bRc" (__LINE__)
$bRc = $i -is [int];    text "x := <$i> -is [int] = $bRc" (__LINE__)
$bRc = $a -is [array];   text "x := <$a> -is [array] = $bRc" (__LINE__)
$bRc = $g -is [single];  text "x := <$g> -is [single] = $bRc" (__LINE__)
$bRc = $h -is [hashtable];  text "x := <$h> -is [hashtable] = $bRc" (__LINE__)
$bRc = $d -is [DateTime];  text "x := <$d> -is [DateTime] = $bRc" (__LINE__)

#   operator: -isnot
$bRc = $s -isNot [int]
    text "x := <$s> -isNot [int] = $bRc" (__LINE__)

#
#   m:  logical         op:{-and,-or,-xor,-not}     ty:bool
#

f_lib_menu("logical")(__LINE__)

#   calc var
$a = $false; $b = $false
if ($i % 2 -eq 0)  { $a = $true }
if ($j % 2 -eq 0)  { $b = $true }
show "using a=<$a>; b=<$b>"

#   run operator
$x = $a -and $b;    text "x := <$a> -and <$b>   = $x" (__LINE__)
$x = $a -or $b;     text "x := <$a> -or  <$b>   = $x" (__LINE__)
$x = $a -xor $b;    text "x := <$a> -xor <$b>   = $x" (__LINE__)
$x = -not $a;       text "x := -not <$a>        = $x" (__LINE__)
$x = -not $b;       text "x := -not <$b>        = $x" (__LINE__)


#   ===========================================================================
#   g:  int
#   ===========================================================================

#
#   m:  arithmetic      op:{+,-,*,/,div,mod}        ty:int
#

f_lib_menu("arithmetic")(__LINE__)
show "using max=<$n>; i=<$i>; j=<$j>; k=<$k>"

$x = $i + $j;   text "x := <$i> + <$j> = $x" (__LINE__)
$x = $i - $j;   text "x := <$i> - <$j> = $x" (__LINE__)
$x = $i * $j;   text "x := <$i> * <$j> = $x" (__LINE__)
if ($j -gt 0) {
    $x = $i / $j;   text "x := <$i> / <$j> = $x" (__LINE__)
}

#   more division in chapter:integer
#   modulo
f_lib_menuS1("modulo")(__LINE__)
if ($j -gt 0) {
    $x = $i % $j;   text "x := <$i> mod <$j> = $x" (__LINE__)
}
if ($i -gt 0) {
    $x = $k % $i;   text "x := <$k> mod <$i> = $x" (__LINE__)
}
if ($k -gt 0) {
    $x = $j % $k;   text "x := <$j> mod <$k> = $x" (__LINE__)
}


#
#   m:  assignment      :{=,+=,-=,*=,/=}            ty:int
#

#   syntax  :   $x <op> $y

f_lib_menu("assignment")(__LINE__)
show "using i=<$i>; j=<$j>; k=<$k>"

$x = $i;    text "x:  = i:$i = $x" (__LINE__)
$x += $j;   text "x: += j:$j = $x" (__LINE__)
$x -= $k;   text "x: -= k:$k = $x" (__LINE__)
$x *= $i;   text "x: *= i:$i = $x" (__LINE__)
if ($j -gt 0) {
    $x /= $j;   text "x: /= j:$j = $x" (__LINE__)
}

#
#   m:  incrementer         op:{++,--}              ty:int
#

#   syntax  :   $x ++ affects $x

f_lib_menu("incrementer")(__LINE__)
show "using max=<$n>; i=<$i>; j=<$j>; k=<$k>"

#   store
[int] $a = $i; [int] $b = $j

$i ++;   text "i:<$a>++ := <$i>" (__LINE__)
$j --;   text "j:<$b>-- := <$j>" (__LINE__)

#   restore
$i = $a; $j = $b

#
#   m:  compare         op:{-eq,-ge,-gt,-le,-lt,-ne}  ty:int
#

f_lib_menu("compare")(__LINE__)
show "using i=<$i>; j=<$j>"

$x = $i -eq $j;    text "x := <$i> -eq <$j> = $x" (__LINE__)
$x = $i -ge $j;    text "x := <$i> -ge <$j> = $x" (__LINE__)
$x = $i -gt $j;    text "x := <$i> -gt <$j> = $x" (__LINE__)
$x = $i -le $j;    text "x := <$i> -le <$j> = $x" (__LINE__)
$x = $i -lt $j;    text "x := <$i> -lt <$j> = $x" (__LINE__)
$x = $i -ne $j;    text "x := <$i> -ne <$j> = $x" (__LINE__)

#
#   m:  bitwise         op:{-band,-bor,-bxor,-bnot}     ty:int
#

f_lib_menu("biwise")(__LINE__)

[int]$a = $i; [int]$b = $j
$sa = F_binStr($a)(4)
$sb = F_binStr($b)(4)
show "using a=<$sa>=$i; b=<$sb>=$j"

$x = $a -band  $b;
$s = F_binStr($x)(4)
text "x := <$sa> -band <$sb> = $s"  (__LINE__)

$x = $a -bor $b
$s = F_binStr($x)(4)
text "x := <$sa> -bor  <$sb> = $s"   (__LINE__)

$x = $a -bxor $b
$s = F_binStr($x)(4)
text "x := <$sa> -bxor  <$sb> = $s"   (__LINE__)

$x = -bnot $a
$s = F_binStr($x)(4)
text "x := -bnot <$sa>  = $s"   (__LINE__)


#   ===========================================================================
#   g:  string
#   ===========================================================================

#
#   m:  like  op:{-[c|i][Not]Like}          ty:string
#
#   syntax:     = [string]$x <op> [string]$regEx;

f_lib_menu("like")(__LINE__)

#   define test
$s = 'peter'
show "using s=<$s>"

#   op: -like
$r = 'Peter';   $x = $s -like $r; text "s -like <$r> = $x" (__LINE__)
$r = 'p*';      $x = $s -like $r; text "s -like <$r> = $x" (__LINE__)
$r = 'p?t?R';   $x = $s -like $r; text "s -like <$r> = $x" (__LINE__)
$r = 'a*';      $x = $s -like $r; text "s -like <$r> = $x" (__LINE__)   # F

#   op: -cLike
$r = 'Peter';   $x = $s -cLike $r; text "s -clike <$r> = $x" (__LINE__)
$r = 'p*';      $x = $s -cLike $r; text "s -clike <$r> = $x" (__LINE__)

#   op: -iLike
$r = 'Peter';   $x = $s -iLike $r; text "s -ilike <$r> = $x" (__LINE__)
$r = 'p*';      $x = $s -iLike $r; text "s -ilike <$r> = $x" (__LINE__)

#   op: -notLike
$r = 'Peter';   $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__)
$r = 'p*';      $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__)

#   op: -cNotLike
$r = 'p?t?R';   $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__)
$r = 'a*';      $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__)

#   op: -iNotLike
$r = 'p?t?R';   $x = $s -iNotLike $r; text "s -iNotLike <$r> = $x" (__LINE__)
$r = 'a*';      $x = $s -iNotLike $r; text "s -iNotLike <$r> = $x" (__LINE__)


#   ===========================================================================
#   g:  array
#   ===========================================================================

#
#   m:  contains  op:{-[c|i][not]contains}          ty:array
#

#   syntax:     = [array]$a <op> [string]$x;

f_lib_menu("contains")(__LINE__)


#   define test
[array] $a = @('a','b','c')
show "using a=<$a>"

#   op: -contains
$x = 'A'; $y = $a -contains $x; text "<$a> -contains <$x> = $y" (__LINE__)
$x = 'c'; $y = $a -contains $x; text "<$a> -contains <$x> = $y" (__LINE__)
$x = '1'; $y = $a -contains $x; text "<$a> -contains <$x> = $y" (__LINE__)
$x = 'B'; $y = $a -contains $x; text "<$a> -contains <$x> = $y" (__LINE__)

#   op: -notContains
$x = '+'; $y = $a -notContains $x; text "<$a> -notContains <$x> = $y" (__LINE__)
$x = 'a'; $y = $a -notContains $x; text "<$a> -notContains <$x> = $y" (__LINE__)

#   op: -cContains      : case-sensitive
$x = 'A'; $y = $a -cContains $x; text "<$a> -cContains <$x> = $y" (__LINE__)
$x = 'b'; $y = $a -cContains $x; text "<$a> -cContains <$x> = $y" (__LINE__)

#   op: -cNotContains   : case-sensitive
$x = 'A'; $y = $a -cNotContains $x; text "<$a> -cNotContains <$x> = $y" (__LINE__)
$x = 'b'; $y = $a -cNotContains $x; text "<$a> -cNotContains <$x> = $y" (__LINE__)

#   op: -iContains      : case-intensive - std
$x = 'a'; $y = $a -iContains $x; text "<$a> -iContains <$x> = $y" (__LINE__)
$x = '1'; $y = $a -iContains $x; text "<$a> -iContains <$x> = $y" (__LINE__)

#   op: -iNotContains   : case-intensive
$x = 'a'; $y = $a -iNotContains $x; text "<$a> -iNotContains <$x> = $y" (__LINE__)
$x = '1'; $y = $a -iNotContains $x; text "<$a> -iNotContains <$x> = $y" (__LINE__)


#
#   m:  inArray             op ::{-[c|i][not]in}        ty:array
#

#   reverse of contains

f_lib_menu("inArray")(__LINE__)

#   operator: -in
[array]     $a  =   'apple','Banana','orange'

$x = 'apple'
$bRc    = $x -in $a
text "x := <$x> -in <$a> = $bRc" (__LINE__)     # true

$x = 'strawberry'
$bRc    = $x -in $a
text "x := <$x> -in <$a> = $bRc" (__LINE__)     # false

$x = 'banana'
$bRc    = $x -in $a
text "x := <$x> -in <$a> = $bRc" (__LINE__)     # true

$x = 'banana'
$bRc    = $x -cIn $a
text "x := <$x> -in <$a> = $bRc" (__LINE__)     # false

#   operator: -notIn
$x = 'cherry'
$bRc    = $x -notIn $a
text "x := <$x> -notIn <$a> = $bRc" (__LINE__)  # true


#   ###########################################################################

#   b:  footer
f_lib_footer(__LINE__); exit(-(__LINE__))

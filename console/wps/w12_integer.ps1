#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::integer                ###:[2024-11-26]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell
#   https://www.sharepointdiary.com/2020/11/powershell-format-string.html

#   !CRQ-241130:PS5.noBinary    : !PS7.bin
#   !CRQ-241130:PS5.noUint      : !PS7.uint
#   !CRQ-241202:decSep

<#
    content:
    •   b:  include
    •   b:  function
    •   b:  header
        •   m:  define.{dec,hex,bin}
        •   m:  int.limit
            •   s:  limit.int
            •   s:  limit.uint
            •   s:  limit.byte
            •   s:  limit.decimal
            •   s:  limit.single
        •   m:  int.operator
            •   s:  op.arithmetic       op:{+,-,*,/}
                •   u:  op.modulo       op:{%}
                •   u:  op.truncate     op=[Math]::Truncate  * like C
            •   s:  op.assignment       op:{=,+=,-=,*=,/=}
            •   s:  op.incrementer      op:{++,--} * post&prefix
            •   s:  op.compare          op:{-eq,-ge,-gt,-le,-lt,-neq}
            •   s:  op.bitwise          op:{-band,-bor,-bxor,-bnot}
        •   m:  converter.i<=>s
            •   s:  i2s(base)           [Convert]::ToString($i,$b)  -> string
            •   s:  s2i(base)           [Convert]::ToInt32($s,$b)   -> int32
        •   m:  formatter       base={2,10,16} dataType={int,single}
            •   s:  format.method       [String]::Format($F,$i)    -> string
            •   s:  format.operator     $F -f $i
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
} # F~binStr

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH integer
        m:  define          : dec,hex,bin
        m:  int.limit       : i16,i32,i64,u16,u32,u64,byte,decimal,single
        m:  int.operator    : arithmetic,assignment,...
        m:  converter       : i2s,s2i
        m:  formatter       : method, operator
'@

#   menu
$g_sColor_text  =       $C_sColor_std
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'
$g_hMenuTabulator['out'] =  $g_hMenuTabulator['spc']


#   ===========================================================================
#   m:  define.{dec,hex,bin}
#   ===========================================================================

f_lib_menu("define")(__LINE__)

#   dec
$i = 41394; text("dec:<$i>") (__LINE__)

#   hex
$i = 0xa1b2;    text("hex.4142 :<$i>") (__LINE__)

#   bin
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $i = 0b1010000110110010;    text("bin.1010000110110010:<$i>") (__LINE__)
}


#   ===========================================================================
#   m:  int.limit
#   ===========================================================================

f_lib_menu("int.limit")(__LINE__)

#
#   s:  limit.int
#

f_lib_menuS1("limit.int")(__LINE__)

#   int =:i32
$s = '[int]::MaxValue' + '<' + [int]::MaxValue + '>'; text $s (__LINE__)
$s = '[int]::MinValue' + '<' + [int]::MinValue + '>'; text $s (__LINE__)

#   int16
$s = '[int16]::MaxValue' + '<' + [int16]::MaxValue + '>'; text $s (__LINE__)
$s = '[int16]::MinValue' + '<' + [int16]::MinValue + '>'; text $s (__LINE__)

#   int32
$s = '[int32]::MaxValue' + '<' + [int32]::MaxValue + '>'; text $s (__LINE__)
$s = '[int32]::MinValue' + '<' + [int32]::MinValue + '>'; text $s (__LINE__)

#   int64
$s = '[int64]::MaxValue' + '<' + [int64]::MaxValue + '>'; text $s (__LINE__)
$s = '[int64]::MinValue' + '<' + [int64]::MinValue + '>'; text $s (__LINE__)


#
#   s:  limit.uint
#

f_lib_menuS1("limit.uint")(__LINE__)


#   uint =:u32
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.uint
    $s = '[uint]::MaxValue' + '<' + [uint]::MaxValue + '>'; text $s (__LINE__)
    $s = '[uint]::MinValue' + '<' + [uint]::MinValue + '>'; text $s (__LINE__)
}

#   uint16
$s = '[uint16]::MaxValue' + '<' + [uint16]::MaxValue + '>'; text $s (__LINE__)
$s = '[uint16]::MinValue' + '<' + [uint16]::MinValue + '>'; text $s (__LINE__)

#   uint32
$s = '[unt32]::MaxValue' + '<' + [uint32]::MaxValue + '>'; text $s (__LINE__)
$s = '[unt32]::MinValue' + '<' + [uint32]::MinValue + '>'; text $s (__LINE__)

#   uint64
$s = '[unt64]::MaxValue' + '<' + [uint64]::MaxValue + '>'; text $s (__LINE__)
$s = '[unt64]::MinValue' + '<' + [uint64]::MinValue + '>'; text $s (__LINE__)

#
#   s:  limit.byte
#

f_lib_menuS1("limit.byte")(__LINE__)

#   byte == u8
$s = '[byte]::MaxValue' + '<' + [byte]::MaxValue + '>'; text $s (__LINE__)
$s = '[byte]::MinValue' + '<' + [byte]::MinValue + '>'; text $s (__LINE__)

#
#   s:  limit.decimal
#

f_lib_menuS1("limit.decimal")(__LINE__)

$s = '[decimal]::MaxValue' + '<' + [decimal]::MaxValue + '>'; text $s (__LINE__)
$s = '[decimal]::MinValue' + '<' + [decimal]::MinValue + '>'; text $s (__LINE__)

#
#   s:  limit.single
#

f_lib_menuS1("limit.single")(__LINE__)

$s = '[single]::MaxValue' + '<' + [single]::MaxValue + '>'; text $s (__LINE__)
$s = '[single]::MinValue' + '<' + [single]::MinValue + '>'; text $s (__LINE__)

#   ===========================================================================
#   m:  int.operator
#   ===========================================================================

#   values
$n = 16
$i = Get-Random -Maximum $n     # 0..n-1
$j = Get-Random -Maximum $n     # 0..n-1
$k = Get-Random -Maximum $n     # 0..n-1

f_lib_menu("integer.operator")(__LINE__)
show("using max=<$n>; i=<$i>; j=<$j>; k=<$k>") $C_sColor_tmp

#
#   s:  op.arithmetic   op:{+,-,*,/}
#

f_lib_menuS1("arithmetic")(__LINE__)
$x = $i + $j;   text "x := <$i> + <$j> = $x" (__LINE__)
$x = $i - $j;   text "x := <$i> - <$j> = $x" (__LINE__)
$x = $i * $j;   text "x := <$i> * <$j> = $x" (__LINE__)
if ($j -gt 0) {
    #   REM: int2double conversion - avoid by using truncate
    $x = $i / $j
    $s = $null
    if ( $x -is [double] ) {
        $s = '*int2double*'
    }
    text "x := <$i> / <$j> = $x $s" (__LINE__)
}

#   u:  op.modulo       op:{%}
f_lib_menuS2("modulo")(__LINE__)
if ($j -gt 0) {
    $x = $i % $j;   text "x := <$i> mod <$j> = $x" (__LINE__)
}
if ($i -gt 0) {
    $x = $k % $i;   text "x := <$k> mod <$i> = $x" (__LINE__)
}
if ($k -gt 0) {
    $x = $j % $k;   text "x := <$j> mod <$k> = $x" (__LINE__)
}

#   u:  op.truncate     op=[Math]::Truncate     * like C-division
#   REM: avoid int2double conversion
f_lib_menuS2("division")(__LINE__)
if ($j -gt 0) {
    $x = [int] [Math]::Truncate($i / $j); text "x := <$i> div <$j> = $x" (__LINE__)
}
if ($i -gt 0) {
    $x = [int] [Math]::Truncate($k / $i); text "x := <$k> div <$i> = $x" (__LINE__)
}
if ($k -gt 0) {
    $x = [int] [Math]::Truncate($j / $k); text "x := <$j> div <$k> = $x" (__LINE__)
}

#
#   s:  op.assignment       :{=,+=,-=,*=,/=}
#

#   syntax  :   $x <op> $y

f_lib_menuS1("assignment")(__LINE__)

$x = $i;    text "x:  = i:$i = $x" (__LINE__)
$x += $j;   text "x: += j:$j = $x" (__LINE__)
$x -= $k;   text "x: -= k:$k = $x" (__LINE__)
$x *= $i;   text "x: *= i:$i = $x" (__LINE__)
if ($j -gt 0) {
    #   REM: int2double conversion
    $x /= $j
    $s = $null
    if ( $x -is [double] ) {
        $s = '*int2double*'
    }
    text "x: /= j:$j = $x $s" (__LINE__)
}

#
#   s:  op.incrementer          op:{++,--} postfix,prefix
#

#   syntax  :   $x ++ affects $x

f_lib_menuS1("incrementer")(__LINE__)
show("using i=<$i>; j=<$j>") $C_sColor_tmp

#   store
[int] $a = $i; [int] $b = $j
$i ++;   text "i:<$a>++ := <$i>" (__LINE__)
$j --;   text "j:<$b>-- := <$j>" (__LINE__)

[int] $a = $i; [int] $b = $j; [int] $c = $j
++ $i;   text "i:++<$a> := <$i>" (__LINE__)
-- $j;   text "j:--<$b> := <$j>" (__LINE__)

#
#   s:  op.compare          op:{-eq,-ge,-gt,-le,-lt,-ne}
#

f_lib_menuS1("compare")(__LINE__)
show("using i=<$i>; j=<$j>") $C_sColor_tmp

$x = $i -eq $j;    text "x := <$i> -eq <$j> = $x" (__LINE__)
$x = $i -ge $j;    text "x := <$i> -ge <$j> = $x" (__LINE__)
$x = $i -gt $j;    text "x := <$i> -gt <$j> = $x" (__LINE__)
$x = $i -le $j;    text "x := <$i> -le <$j> = $x" (__LINE__)
$x = $i -lt $j;    text "x := <$i> -lt <$j> = $x" (__LINE__)
$x = $i -ne $j;    text "x := <$i> -ne <$j> = $x" (__LINE__)

#
#   s:  op.bitwise          op:{-band,-bor,-bxor,-bnot}
#

f_lib_menuS1("biwise")(__LINE__)
show("using i=<$i>; j=<$j>") $C_sColor_tmp
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
#   m:  converter.i<=>s     base={2,8,10,16}
#   ===========================================================================

f_lib_menu("converter.i<=>s")(__LINE__)


$g_iVal = 0xA1B2   # hex-number above
show("using i=<'$g_iVal'>") $C_sColor_tmp

#
#   s:  i2s(base)   : -> string
#

f_lib_menuS1("convert.i2s(<int>,base)")(__LINE__)

$i = $g_iVal

#   binary
$b = 2
$s = '1010000110110010';
$x = [Convert]::ToString($i,$b)
text "x: i2s(<$i>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   octal
$b = 8
$s = '120662'
$x = [Convert]::ToString($i,$b)
text "x: i2s(<$i>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   decimal
$b = 10
$s = '41394'
$x = [Convert]::ToString($i,$b)
text "x: i2s(<$i>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   hexadecimal
$b = 16
$s = 'a1b2'
$x = [Convert]::ToString($i,$b)
text "x: i2s(<$i>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)


#
#   s:  s2i(base)   : -> int32
#

f_lib_menuS1("convert.s2i(<string>,<base>)")(__LINE__)


#   binary
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $b = 2
    $s = '1010000110110010';
    $x = [Convert]::ToInt32($s,$b)
    text "x: s2i(<$s>,<$b>) `t =: <$x> " (__LINE__)
    assert($x -eq $i)(__LINE__)
}

#   octal
$b = 8
$s = '120662'
$x = [Convert]::ToInt32($s,$b)
text "x: s2i(<$s>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $i)(__LINE__)

#   decimal
$b = 10
$s = '41394'
$x = [Convert]::ToInt32($s,$b)
text "x: s2i(<$s>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $i)(__LINE__)

#   hexadecimal
$s = 'a1b2'
$b = 16
$x = [Convert]::ToInt32($s,$b)
text "x: s2i(<$s>,<$b>) `t =: <$x> " (__LINE__)
assert($x -eq $i)(__LINE__)

#   ===========================================================================
#   m:  formatter           base={2,10,16} dataType={int,single}
#   ===========================================================================


f_lib_menu("formatter")(__LINE__)

[string] $F = $null

$i  = 0xA1B2
show("using i=<'$i'>") $C_sColor_tmp
$g  = 123.456
show("using g=<'$g'>") $C_sColor_tmp

#
#   s:  format.method
#

f_lib_menuS1("format.method")(__LINE__)

#   format.me.binary   20 digits, zero-padding
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $F = '{0:b20}'
    $s = '00001010000110110010'
    $x = [String]::Format($F,$i)
    text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
    assert($x -eq $s)(__LINE__)
}

#   format.me.dec
$F = '{0:d}'
$s = '41394'
$x = [String]::Format($F,$i)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.me.dec :   8 digits, zero-padding
$F = '{0:d8}'
$s = '00041394'
$x = [String]::Format($F,$i)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.me.hex
$F = '{0:x}'
$s = 'a1b2'
$x = [String]::Format($F, $i)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.me.hex : 8digits
$F = '{0:x8}'
$s = '0000a1b2'
$x = [String]::Format($F, $i)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.me.hex : 8digits.UpperCase
$F = '{0:X4}'
$s = 'A1B2'
$x = [String]::Format($F, $i)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.me.float
$F = '{0:f8}'
$s = '123.45600000' # no-zero-left-padding
$s = $s.replace('.',$C_cSepDecimal) # !CRQ-241202:decSep
$x = [String]::Format($F, $g)
text "x: format(<$i>,<$F>) `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#
#   s:  format.operator
#

f_lib_menuS1("format.operator")(__LINE__)

#   format.op.dec
$F = '{0:d}'
$x = $F -f $i
$s = '41394'
text "x: <$F> -f <$i> `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.op.hex
$F = '{0:x}'
$x = $F -f $i
$s = 'a1b2'
text "x: <$F> -f <$i> `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.op.bin
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $F = '{0:b}'
    $x = $F -f $i
    $s = '1010000110110010'
    text "x: <$F> -f <$i> `t =: <$x> " (__LINE__)
    assert($x -eq $s)(__LINE__)
}

#   format.op.float
$F = '{0:f}'
$x = $F -f $g
if ($C_cSepDecimal -eq '.') {
    $s = '123.46'
} else {
    $s = '123,46'  # $s = $s.replace(',',$C_cSepDecimal)
}
text "x: <$F> -f <$g> `t =: <$x> " (__LINE__)
assert($x -eq $s)(__LINE__)

#   format.op.dateTime
$F = "{0:yyyy}-{0:MM}-{0:dd} && {0:hh}:{0:mm}:{0:ss}"
$sDtm = $(Get-Date)
$x = $F -f $sDtm
text "x: <$F> -f <DTM>`n`t`t =: <$x> " (__LINE__)



#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

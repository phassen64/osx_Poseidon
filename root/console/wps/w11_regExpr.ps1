#   ***************************************************************************
#   TUTORIAL PowerShell:    regular-expression              ###:[2024-11-22]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

<#

    check and learn regExpr Str with :
    •   https://jhoneill.github.io/powershell/2021/04/10/regex1.html
    •   https://regex101.com/

    restrictions in  WPS :
    POSIX char class /[[:<x>>:]]/  x = {print,digit,alpha,alnum,...}
    •   hex like \h or \H

    meta chars :
    •   \   :   escape-meta
    •   []  :   set or range
    •   {}  :   multiplier
    •   ()  :   store result
    •   <>  :   name result
    •   .   :   anyChar 1 time
    •   *   :   anyChar 0 or n times
    •   ?   :   optional
    •   +   :   mandatory
    •   ^   :   beginOfString
    •   $   :   endOfStr
    •   |   :   inclusiveOr
#>



<#
    content:
    •   b:  include
    •   b:  header
    •   m:  match
        •   s:  match.single:{'.'}
        •   s:  match.optional:{'?'}
        •   s:  match.mandatory:{'+'}
        •   s:  match.any:{'*'}
        •   s:  match.inclusiveOr:{'|'}
        •   s:  match.multiplier:{m}
        •   s:  match.set:{[xyz]}
        •   s:  match.range:{[x-z]}
        •   s:  match.digit:{\d\D}
        •   s:  match.space:{\s\S}
        •   s:  match.wordchar:{\w\W}
        •   s:  match.position{^$}
        •   s:  match.meta{\meta}
        •   s:  match.group{(g)}
        •   s:  match.SelectString
    •   m:  replace
    •   b:  footer
#>


#   m:  include

.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  function
#

function F_match(
            [string]    $s,
            [string]    $r,
            [bool]      $p_bMatch  =  $false,
            [int]       $p_iLine = -1 )
{
    $x  = $s -match $r
    $b  = $p_bMatch -eq $x
    $s  = "'$s' -match '$r' =:< $x >"
    #   color
    $sCol = $g_sColor_text
    if ($false -eq $b) {
        $sCol = 'Yellow'
        $sCol = $C_sColor_result
    }
    text ($s)($p_iLine )($sCol)
    assert ($b) ($p_iLine)
} # F~match


function F_replace(
            [string]    $p_sSrcStr,
            [string]    $p_sSrcRex,        # rex
            [string]    $p_sObj,
            [string]    $p_sMatch  =  $null,
            [int]       $p_iVariant   = 0,
            [int]       $p_iLine   = -1)
{
    if (  $p_iVariant -eq 0 ) {
        $z  = $p_sSrcStr -replace $p_sSrcRex,$p_sObj    # operator
    } else {
        $z  = $p_sSrcStr.replace($p_sSrcRex,$p_sObj)    # function
    }
    $b  = $p_sMatch  -eq $z
    $s  = "'$p_sSrcStr' -replace<$p_iVariant> '$p_sSrcRex','$p_sObj' =:< $z >"
    #   color
    $sCol = $g_sColor_text
    if ($false -eq $b) {
        $sCol = 'Yellow'
        $sCol = $C_sColor_result
    }
    text ($s)($p_iLine )($sCol)
    assert ($b) ($p_iLine)
} # F~replace

#   ###########################################################################
#   b:  body
#   ###########################################################################


#
#   b:  header
#

f_lib_header(__LINE__)

Write-Host @"
=== :   PSH dummy
        m:  match
        m:  replace
"@

trace(__LINE__)(__FILE__) 'using'

#   using
$g_sColor_text  =       $C_sColor_std
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'

$g_hMenuTabulator['out'] =  $g_hMenuTabulator['spc']
$n = 16
$g_iRnd = Get-Random -Maximum $n     # 0..n-1
$g_bEven = ( $g_iRnd % 2 -eq 0)


#   ===========================================================================
#   m:  match   op:{-[c|i][not]match}
#   ===========================================================================

#   c: case-sensitive
#   i: case-in-sensitive

#   REM : similiar to like, but using rex


f_lib_menu("match")(__LINE__)

#
#   introduction
#

$s = 'Abc'
$r = 'abc';
show("using s=<'$s'>; r=<'$r'>") $C_sColor_tmp

#   op: -match, -cMatch, -cNotMatch, -iMatch, -iNotMatch

$x = $s -match      $r; text "s -match <$r>     = $x" (__LINE__) # T
$x = $s -cMatch     $r; text "s -cMatch <$r>    = $x" (__LINE__) # F
$x = $s -cNotMatch  $r; text "s -cNotMatch <$r> = $x" (__LINE__) # T
$x = $s -iMatch     $r; text "s -iMatch <$r>    = $x" (__LINE__) # T
$x = $s -iNotMatch  $r; text "s -iNotMatch <$r> = $x" (__LINE__) # F

#   some example
$r = 'abc';
show("simple : `tr:<$r>") $C_sColor_tmp

F_match ('ABC')($r) ($true) (__LINE__)
F_match ('ab')($r) ($false) (__LINE__)      # F: notC
F_match ('abbbc')($r) ($false) (__LINE__)   # F: manyB
F_match ('aaabccc')($r) ($true) (__LINE__)  # T
F_match ('a b c')($r) ($false) (__LINE__)   # F

#
#   s:  match.single:{'.'}
#

f_lib_menuS1("match.single")(__LINE__)

$s = 'abc'
show(".  : single of `ts:<$s>") $C_sColor_tmp

F_match ($s)('a..') ($true) (__LINE__)
F_match ($s)('ab.') ($true) (__LINE__)
F_match ($s)('a.c') ($true) (__LINE__)
F_match ($s)('...') ($true) (__LINE__)
F_match ($s)('..a') ($false) (__LINE__)     # F: wrongPos


#
#   s:  match.optional:{'?'}
#

f_lib_menuS1("match.optional")(__LINE__)

$r = 'ax?b'     # optional 1 'x'
show("? : optional_uno `tr:<$r>") $C_sColor_tmp

F_match ('axb') ($r)($true) (__LINE__)
F_match ('axxxb') ($r)($false) (__LINE__)   # F: manyX
F_match ('ab')  ($r)($true) (__LINE__)

#
#   s:  match.mandatory:{'+'}
#

f_lib_menuS1("match.mandatory")(__LINE__)

$r = 'ax+b'         # x needed
show("+  : mandatory `tr:<$r>") $C_sColor_tmp

F_match ('axb')($r)($true)(__LINE__)
F_match ('axxxb')($r)($true)(__LINE__)
F_match ('ab')($r)($false)(__LINE__)        # F: notX
F_match ('abx')($r)($false)(__LINE__)       # F: posX
F_match ('xab')($r)($false)(__LINE__)       # F: posX

#   special
$r = 'x+..y+'
show("+  : mandatory `tr:<$r>") $C_sColor_tmp

F_match ('axbcyd')($r)($true)(__LINE__)
F_match ('axbyd')($r)($false)(__LINE__)     # F: posY

#
#   s:  match.any:{'*'}
#

f_lib_menuS1("match.any")(__LINE__)

$r = 'ax*b'     #   x*n; n=0
show("*  : any `tr:<$r>") $C_sColor_tmp

F_match ('axb')($r)($true)(__LINE__)
F_match ('axxxb')($r)($true)(__LINE__)
F_match ('ab')($r)($true)(__LINE__)

#
#   s:  match.multiplier:{m}
#

f_lib_menuS1("match.multiplier")(__LINE__)

$r = 'ax{2}b'       #   2 times the char 'x'
show("{m}: multiplier : `tr:<$r>") $C_sColor_tmp

F_match ('axb')     ($r)($false)(__LINE__)  #   F: 1x
F_match ('axxb')    ($r)($true) (__LINE__)
F_match ('axxxb')   ($r)($false)(__LINE__)  #   F: 3x
F_match ('ab')      ($r)($false)(__LINE__)  #   F: 0x
F_match ('zaxxbz')  ($r)($true) (__LINE__)

#
#   s:  match.inclusiveOr:{'|'}
#

f_lib_menuS1("match.inclusive.or")(__LINE__)

$r = 'ax|yb'       #  x or y
show("|  : inclusiveOr `tr:<$r>") $C_sColor_tmp

$s = 'axb';    F_match ($s)($r)($true)(__LINE__)
$s = 'ayb';    F_match ($s)($r)($true)(__LINE__)
$s = 'axyb';   F_match ($s)($r)($true)(__LINE__)    # T: x && y
$s = 'ab';     F_match ($s)($r)($false)(__LINE__)   # F: neither x nor y
$s = 'abx';    F_match ($s)($r)($false)(__LINE__)   # F: wrong pos of x

#
#   s:  match.set:{[xy]}   : exclusive or of set e=[xy]
#

f_lib_menuS1("match.exclusive.or:[set]")(__LINE__)

$r = 'a[xy]b'
show("[] : exclusiveOr `tr:<$r> ") $C_sColor_tmp

$s = 'axb';    F_match ($s)($r)($true)(__LINE__)
$s = 'ayb';    F_match ($s)($r)($true)(__LINE__)
$s = 'axyb';   F_match ($s)($r)($false)(__LINE__)   # F: x ^| y
$s = 'ab';     F_match ($s)($r)($false)(__LINE__)   # F: neither x nor y
$s = 'abx';    F_match ($s)($r)($false)(__LINE__)   # F: wrong pos of x


#
#   s:  match.range:{[x-z]}     * any in the range, but only 1x
#

f_lib_menuS1("match.range")(__LINE__)

#   all letter
$r = '[a-z]'
show("[] : range.letter r:<$r> ") $C_sColor_tmp

F_match ('abc')($r)($true) (__LINE__)
F_match ('1a3')($r)($true) (__LINE__)
F_match ('123')($r)($false) (__LINE__)    # F: no-letter
F_match ('_23')($r)($false) (__LINE__)    # T: '_' is letter

#   only-vowel
$r = '[aeiou]'
show("[] : range.vowel r:<$r> ") $C_sColor_tmp
F_match ('a')($r)($true) (__LINE__)
F_match ('b')($r)($false) (__LINE__)
F_match ('c')($r)($false) (__LINE__)
F_match ('_')($r)($false) (__LINE__)

#   only-non-vowel
$r = '[a-z-[aeiou]]'
show("[] : range.non-vowel r:<$r> ") $C_sColor_tmp
F_match ('a')($r)($false) (__LINE__)
F_match ('b')($r)($true) (__LINE__)
F_match ('c')($r)($true) (__LINE__)
F_match ('_')($r)($false) (__LINE__)

#   all digit
$r = '[0-9]'
show("[] : range.digit r:<$r> ") $C_sColor_tmp
F_match ('1bc')($r)($true) (__LINE__)
F_match ('ab3')($r)($true) (__LINE__)
F_match ('abc')($r)($false) (__LINE__)    # no-digit

#   using multiplier and combined
show("[] : range.any") $C_sColor_tmp
F_match ('1bc45')('[a-z]{2}')($true) (__LINE__)
F_match ('1bc45')('[a-z]{3}')($false)(__LINE__)
F_match ('12cd5')('[0-9]{2}[a-z]{2}[0-9]')($true)(__LINE__)

#
#   s:  match.digit:{\d\D}     :\d:digit,\D:no~
#

f_lib_menuS1("match.digit")(__LINE__)
show('\d : digit') $C_sColor_tmp
show('\D : non-digit') $C_sColor_tmp

F_match ('ab1de')('..\d..')($true)(__LINE__)
F_match ('5678e')('\d{4}.')($true)(__LINE__)
F_match ('5678e')('\d{4}.')($true)(__LINE__)
F_match ('ab345')('\D{2}\d{3}')($true)(__LINE__)
F_match ('abcde')('\D{5}')($true)(__LINE__)

#
#   s:  match.space:{\s\S}     :\s:space,\S:no~
#

f_lib_menuS1("match.space")(__LINE__)

show('\s : space') $C_sColor_tmp
show('\S : non-space') $C_sColor_tmp

F_match ('ab de')('..\s..')($true)(__LINE__)
F_match ('     ')('\s{5}')($true)(__LINE__)
F_match ('12345')('\S{5}')($true)(__LINE__)
F_match ('xx de')('\S\s\s\S\S')($false)(__LINE__)
F_match ('a  de')('\S\s\s\S\S')($true)(__LINE__)

#
#   s:  match.wordchar:{\w\W}     :\w:letter,digit,underscore,\W:no~
#

f_lib_menuS1("match.wordchar")(__LINE__)

show('\w : wordchar') $C_sColor_tmp
show('\W : non-Wordchar') $C_sColor_tmp

F_match ('abcde')('\w{5}')($true)(__LINE__)
F_match ('a2c_e')('\w{5}')($true)(__LINE__)
F_match ('a_ de')('\w{5}')($false)(__LINE__)    # space
F_match ('a_ de')('\w{2}\W\w{2}')($true)(__LINE__)
F_match ('^$*.[')('\w')($false)(__LINE__)


#
#   s:  match.position{^$}      ^:begin $:end
#

f_lib_menuS1("match.position")(__LINE__)

show('^  : begin') $C_sColor_tmp
F_match ('abcde')('^a')($true)(__LINE__)    # 'a' at begin
F_match ('Abcde')('^a')($true)(__LINE__)    # noCase
F_match ('1bcde')('^a')($false)(__LINE__)   # F: missing 'a' at begin

show('$  : endin') $C_sColor_tmp
F_match ('abcde')('e$')($true)(__LINE__)    # 'e' at end
F_match ('abcd5')('e$')($false)(__LINE__)   # F: missing 'e' at end
F_match ('abcd_')('_$')($true)(__LINE__)

#   combined
show('^$ : begin && endin') $C_sColor_tmp
F_match ('a')('^a$')($true)(__LINE__)        # 'a' is begin and end
F_match ('abcde')('^ae$')($false)(__LINE__)  # 'a' at:begin and 'e' at:end
F_match ('abcde')('^a\w+e$')($true)(__LINE__)   # better

#
#   s:  match.meta{\meta}
#

f_lib_menuS1("match.meta")(__LINE__)


#   Meta = { \ [] {} () <> ? ! ^ $ * . }

#   M:{?}
$r = '\?a\?'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '?a?';     F_match ($s)($r)($true)(__LINE__)
$s = 'a?';      F_match ($s)($r)($false)(__LINE__)  # F : first?
$s = '?a';      F_match ($s)($r)($false)(__LINE__)  # F : last?
$s = 'a';       F_match ($s)($r)($false)(__LINE__)  # F : no?

#   M:{\$}
$r = '\\a\$'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '\a$';     F_match ($s)($r)($true)(__LINE__)
$s = 'a$';      F_match ($s)($r)($false)(__LINE__)  # F: first\
$s = '\a';      F_match ($s)($r)($false)(__LINE__)  # F: last $

#   M:{*[]?}
$r = '\*\[\!\]\?'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '*[!]?';   F_match ($s)($r)($true)(__LINE__)
$s = '[!]';     F_match ($s)($r)($false)(__LINE__)  # F: no*
$s = '*[!]';    F_match ($s)($r)($false)(__LINE__)  # F: no?
$s = '*[]?';    F_match ($s)($r)($false)(__LINE__)  # F: no!

#   M:{^{}.}
$r = '\^\{a\}\.'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '^{a}.';   F_match ($s)($r)($true)(__LINE__)
$s = '{a}.';    F_match ($s)($r)($false)(__LINE__)  # F: no^
$s = '^{a}';    F_match ($s)($r)($false)(__LINE__)  # F: no.

#   M:()
$r = '\(a\)'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '(a)';     F_match ($s)($r)($true)(__LINE__)
$s = 'a)';      F_match ($s)($r)($false)(__LINE__)
$s = '(a';      F_match ($s)($r)($false)(__LINE__)
$s = '((a))';   F_match ($s)($r)($true)(__LINE__)

$r = '\<a\>'
show("meta `tr:<$r> ") $C_sColor_tmp
$s = '<a>';     F_match ($s)($r)($true)(__LINE__)

#
#   s:  match.group{(g)}
#

f_lib_menuS1("match.group")(__LINE__)

show('(g) : group') $C_sColor_tmp

#   simple group
$s = 'a23de678'
$r = '(a\d{2})(\D{2})(\d{3})'
F_match ($s)($r)($true)(__LINE__)

#   group with results
$s = 'N-90489-PHA'
$r = '(?<vPLZ>\d{5}).(?<vID>\D{3})'
F_match ($s)($r)($true)(__LINE__)

#
#   s:  match.SelectString
#

f_lib_menuS1("match.selectString")(__LINE__)

#   get all environment variables via CMD
$aCmd = (& $env:ComSpec /c 'set') | Sort-Object

#   fetch this
$C_sKey = 'UserName'
$C_sKey = 'ComputerName'

#   my rex
$r = '^([^=]*)=(.*)$'   # complex
$r = '^(.*)=(.*)$'      # try my

#   parse : (USERNAME=peter) => 'USERNAME'|'peter'
$i = 0
$aCmd | Select-String $r | ForEach-Object {
    $k = $_.Matches[0].Groups[1].Value
    $v = $_.Matches[0].Groups[2].Value
    $x = $aCmd[$i]
    if ($k -eq $c_sKey) {
        show "[$i]:'$x' => '$k'|'$v'" 'Yellow'
    }
    $i += 1
}

#   ===========================================================================
#   m:  replace
#   ===========================================================================

f_lib_menu("replace")(__LINE__)

#   replace simple a string
show("replaceSimple") $C_sColor_tmp
$sSrc   = 'abcabc'
$sObj   = 'xbcxbc'
$r      = 'a'
$t      = 'x'
F_replace ($sSrc)($r)($t)($sObj)(1)(__LINE__)

#   replace t beginOfStr
show("replaceAtBegin") $C_sColor_tmp
$sSrc   = 'abcabc'
$r      = '^a'
$t      = 'x'
$sObj   = 'xbcabc'
F_replace ($sSrc)($r)($t)('xbcabc')(0)(__LINE__)

#   replace t endOfStr
show("replaceAtEnd") $C_sColor_tmp
$sSrc   = 'abcabc'
$r      = 'c$'
$t      = 'x'
$sObj   = 'abcabx'
F_replace ($sSrc)($r)($t)($sObj)(0)(__LINE__)

#   replace as remove
show("remove") $C_sColor_tmp
$sSrc   = 'abcabc'
$r      = 'a'
$t      = ''
$sObj   = 'bcbc'
F_replace ($sSrc)($r)($t)($sObj)(1)(__LINE__)

#   replace dirSep
show("replaceDirSep") $C_sColor_tmp
$sSrc    = 'c:\dir\subFolder'
$sObj    = 'c:\\dir\\subFolder'
$r = '\'
$t = '\\'
F_replace ($sSrc)($r)($t)($sObj)(1)(__LINE__)

#   replace decimalSeparator
show("replaceDecOperator") $C_sColor_tmp
$sSrc    = '1,2345'
$sObj    = '1.2345'
$r = ','
$t = '.'
F_replace ($sSrc)($r)($t)($sObj)(1)(__LINE__)

#   replace  mail
show("mailAddress") $C_sColor_tmp
$aTmp = @("AdeleV","GradyA","JoniS")
$aObj = @()
$aSrc = @("AdeleV@lazydev.com","GradyA@lazydev.com","JoniS@lazydev.com")
$aSrc | ForEach-Object {
    $aObj += $_.Replace("@lazydev.com","")
}

#   compare both arrays
$x = $aTmp | Where-Object {$aObj -notContains $_}
$b = ( $x.Length -eq 0)
show "x := ?(aTmp == aObj) => <$b>"
assert($true -eq $b)(__LINE__)

info 'ready' (__LINE__)


#
#   b:  footer
#

f_lib_footer(__LINE__)


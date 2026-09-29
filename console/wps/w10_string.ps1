#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::string              ###:[2024-11-20]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  init                        :   [string] $s
        •   m:  define
            •   s:  single-quoted           :   $s = 'x'
            •   s:  double-quoted           :   $s = "x"
            •   s:  hereString              :   @'...'@
            •   s:  multiplicator           :   $s = 'x' * 10
        •   m:  property.Length
        •   m:  change
            •   s:  string.merge            :   $s = {$s1$s2}
            •   s:  string.concatenation    :   $s = $s1 + $s2
            •   s:  string.append           :   $s += 'x'
        •   m:  access
            •   s:  access.string.single    :   $c = $s[$i]
            •   s:  access.string.slice     :   $t = $s[$i..$n]
        •   m:  compare
            •   s:  compare.operator        :   $s -{eq|gt|lt} $r
            •   s:  compare.like            :   $s -like $r
            •   s:  compare.match           :   $s -match $r
        •   m:  method
            •   s:  upper&&lower            :   $s.{ToUpper|ToLower}()
            •   s:  trim                    :   trim,trimStart,trimEnd space
            •   s:  replace                 :   replace(x,y)
            •   s:  index                   :   index,LastIndexOf
            •   s:  cutter                  :   subString, remove
            •   s:  chopper                 :   chop, chomp
            •   s:  split                   :   $s.split($c) => $a
            •   s:  join                    :   join($c,$a) => $s
    •   b:  footer
#>


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH string
        m:  init            [string] $s =$null
        m:  define          $s = 'x' ; $s = "x"
        m:  property        $s.Length
        m:  change          $s = $s1 + $s2
        m:  access          $s[0..2]
        m:  compare         -eq -gt -lt -like
        m:  method          trim,index,replace...
'@

#   using
$g_sColor_text  =       $C_sColor_std
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'

$g_hMenuTabulator['out'] = $g_hMenuTabulator['spc']
$n = 16
$i = Get-Random -Maximum $n     # 0..n-1


#
#   m:  init
#

f_lib_menu("init")(__LINE__)

#   empty string
[string] $s = $null

$s = 'peter'
show $s

#
#   m:  define
#

f_lib_menu("define")(__LINE__)

#   s:  single-quoted
f_lib_menuS1('single-quoted')(__LINE__)
$s = 'We get no number <$i> with single-quoted-strings.'
show $s

#   s:  double-quoted
#   with dataType qualifier
f_lib_menuS1('double-quoted')(__LINE__)
[string] $s = "Double quoted-strings evaluate <$i> number."
show $s

#   s:  hereString
#   Write a string about several lines.
f_lib_menuS1('hereString')(__LINE__)
f_lib_text('HERE-string with single quote')

$sHere = @'
            This is a singleQuoted-HERE-String.
            Second Line.
            Third Line.
'@

show "BEGIN of HERE"
puts $sHere
show "END of HERE"

#   s:  multiplicator
f_lib_menuS1('multiplicator')(__LINE__)

$i = 10
$c = 'x'
$s = $c * $i

text "string <$c> * <$i> =: '$s'" (__LINE__)

#
#   m:  property.length
#

f_lib_menu("property.length")(__LINE__)

$i = $s.Length
show "length of string '$s' is : <$i>"
assert($i -eq 10)(__LINE__)

#
#   m:  change
#

#
#   s:  string.merge
#

f_lib_menuS1("merge")(__LINE__)

$s1 = 'ABC'
$s2 = '123'
$x  = "$s1$s2";     $s = "x:=" + '<"' + '$s1$s2' + '">' + "`t=> <$x>"; show $s

#
#   s:  string.concatenation
#

f_lib_menuS1("concatenation")(__LINE__)

#   separated strings
$s1 = 'Adam'
$s2 = 'Eve'
$x  = $s1 + ' & ' + $s2
text "concat('$s1','$s2') =: $x" (__LINE__)

#
#   s:  string.append
#

f_lib_menuS1("append")(__LINE__)

$s = 'peter'
$s += ' and '
$s += 'Harvey'
show $s


#
#   m:  access
#

f_lib_menu("access")(__LINE__)
$s  = 'ABCDEFGHIJ'
show("using s = '$s'") $C_sColor_tmp

#
#   s:  access.string.single
#

f_lib_menuS1('access.single')(__LINE__)

#   forward access
$i = 0;     $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # 'A'
assert($x -eq 'A')(__LINE__)
$i = 3;     $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # 'D'
$i = 10;    $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # ''

#   reverse access
$i = - 1;   $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # 'J'
$i = - 3;   $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # 'H'
$i = - $s.Length;   $x = $s[$i];    text "c:='$s'[$i] `t=> <$x>"    # 'A'

#
#   s:  access.string.slice
#

f_lib_menuS1('access.slice')(__LINE__)

#   positive slice [+i..+j]

$sRc = [string] $x
$i=0;$j=2;  $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"     # <A B C>
$i=3;$j=7;  $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"     # <D E F G H>
$i=2;$j=0;  $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"     # <C B A>
$i=2;$j=6;  $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"     # <C D E F G>

#   negatice slice [+i..-j],[-$i..+$j],[-$i..+-j]
$i=1;$j=-1;  $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"    # <B A J>
$i=-1;$j=+1; $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"    # <J A B>
$i=-8;$j=-4; $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"    # <C D E F G>
$i=-4;$j=-8; $x = $s[$i..$j]; text "'$s'[$i..$j] = <$x>"    # <G F E D C>
#   not work assert($x -eq 'G F E D C')(__LINE__)

<#
    !CRQ-250427:sliceEmpty
    *   slices generates a CharObjectArray with empty values
#>
$t = $s.GetType()
text "`$s.GetType() => <$t>"    # string
$t = $x.GetType()
text "`$x.GetType() => <$t>"    # System.Object[]

#   convert CharObjectArray => string
[string] $y = $null
$iLen = $x.Length
for($i = 0; $i -lt $x.Length; $i++) {
    $y += $x[$i]
}
text "convert`$x::CharObjectArray => String =: <$y>"

#
#
#   m:  compare
#

f_lib_menu("compare")(__LINE__)

#
#   s:  compare.operator    op:{-[c|i]<cmpOp> = {eq,lt,gt}
#

f_lib_menuS1("compare-operator =:'-[c|i]<Op>={eq,lt,gt}'")(__LINE__)
#   c: case-sensitive
#   i: case-in-sensitive

$s = 'ABC'
$t = 'abc'
show("using s='$s' t='$t'") $C_sColor_tmp

$x = $s -eq  $t; show "x := <$s> -eq <$t>   =: $x"    #   True ! - no case
$x = $s -cEq $t; show "x := <$s> -cEq <$t>  =: $x"    #   False - case
$x = $s -iEq $t; show "x := <$s> -iEq <$t>  =: $x"    #   True
$x = $s -lt $t;  show "x := <$s> -le <$t>   =: $x"    #   False
$x = $s -gt $t;  show "x := <$s> -gt <$t>   =: $x"    #   False

$t = 'ab'
$x = $s -gt $t; show "x := <$s> -gt <$t>    =: $x"    #   True

#
#   s:  compare.like    op:{-[c|i][not]like}
#

#   c: case-sensitive
#   i: case-in-sensitive

#   REM:    -like similiar to -eq but using wildcards {'*','?','[<set>]'}

f_lib_menuS1("like  {-[c|i][not]like}")(__LINE__)

$s = 'peter'
show("using s = '$s'") $C_sColor_tmp

#   op: -like
show("-like") $C_sColor_tmp
$r = 'Peter';   $x = $s -like $r; text "s -like <$r> = $x" (__LINE__) # T
$r = 'p*';      $x = $s -like $r; text "s -like <$r> = $x" (__LINE__) # T
$r = 'p?t?R';   $x = $s -like $r; text "s -like <$r> = $x" (__LINE__) # T
$r = 'a*';      $x = $s -like $r; text "s -like <$r> = $x" (__LINE__) # F

#   using a vocal set [...]
$v = 'aeiou';
$r = "P[$v]t[$v]r";  $x = $s -like $r; text "s -like <$r> = $x" (__LINE__) # T

#   op: -cLike
show("-cLike") $C_sColor_tmp
$r = 'Peter';   $x = $s -cLike $r; text "s -cLike <$r> = $x" (__LINE__) # F
$r = 'p*';      $x = $s -cLike $r; text "s -like <$r> = $x" (__LINE__) # T
$r = 'p?t?R';   $x = $s -cLike $r; text "s -like <$r> = $x" (__LINE__) # F
$r = 'a*';      $x = $s -cLike $r; text "s -like <$r> = $x" (__LINE__) # F

#   op: -iLike
show("-iLike") $C_sColor_tmp
$r = 'Peter';   $x = $s -iLike $r; text "s -iLike <$r> = $x" (__LINE__) # F
$r = 'p*';      $x = $s -iLike $r; text "s -like <$r> = $x" (__LINE__) # T
$r = 'p?t?R';   $x = $s -iLike $r; text "s -like <$r> = $x" (__LINE__) # F
$r = 'a*';      $x = $s -iLike $r; text "s -like <$r> = $x" (__LINE__) # F

#   op: -notLike
show("-notLike") $C_sColor_tmp
$r = 'Peter';   $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__) # T
$r = 'p*';      $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__) # F
$r = 'p?t?R';   $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__) # T
$r = 'a*';      $x = $s -notLike $r; text "s -notLike <$r> = $x" (__LINE__) # T

#   op: -cNotLike
show("-cNotLike") $C_sColor_tmp
$r = 'Peter';   $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__) # T
$r = 'p*';      $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__) # F
$r = 'p?t?R';   $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__) # T
$r = 'a*';      $x = $s -cNotLike $r; text "s -cNotLike <$r> = $x" (__LINE__) # T

#
#   s:  compare.match   op:{-[c|i][not]match}; c: case-sensitive; i:in-sensitive
#
#   REM : similiar to like, but using regularExpression, later more

f_lib_menuS1("match {-[c|i][not]match}")(__LINE__)

$s = 'peter'
show("using s = '$s'") $C_sColor_tmp

#   op: -match
show("-match") $C_sColor_tmp
$r = '[a-z]';   $x = $s -match $r; text "s -match <$r> = $x" (__LINE__) # T
$r = 'p?t?r';   $x = $s -match $r; text "s -match <$r> = $x" (__LINE__) # T
$r = '\w';      $x = $s -match $r; text "s -match <$r> = $x" (__LINE__) # T

#   ===========================================================================
#   m:  method
#   ===========================================================================

f_lib_menu("method")(__LINE__)

$s = ' Michael. '   # 10 z
show("using s = '$s'") $C_sColor_tmp

#
#   s:  upper&&lower
#

f_lib_menuS1("upper-lower")(__LINE__)
$x = $s.ToUpper();  text "s.ToUpper =  <$x>"  (__LINE__)    #   < MICHAEL. >
assert($x -eq ' MICHAEL. ')(__LINE__)
$x = $s.ToLower();  text "s.ToLower =  <$x>"  (__LINE__)    #   < michael. >
assert($x -eq ' michael. ')(__LINE__)

#
#   s:  trim         : remove spaces
#

f_lib_menuS1("trim")(__LINE__)

#   trim, trimStart,trimEnd
$x = $s.Trim();     text "s.Trim = <$x>"  (__LINE__)            # <Michael.>
assert($x -eq 'Michael.')(__LINE__)
$x = $s.TrimStart();     text "s.TrimStart = <$x>"  (__LINE__)  # <Michael. >
assert($x -eq 'Michael. ')(__LINE__)
$x = $s.TrimEnd();     text "s.TrimEnd = <$x>"  (__LINE__)      # < Michael.>
assert($x -eq ' Michael.')(__LINE__)

#
#   s:  replace     : case-sensitive-char-replacement
#

f_lib_menuS1("replace")(__LINE__)

#   remove all spaces
$x = $s.Replace(' ','')
text "s.Replace(<space>,<blank>) = <$x>"   (__LINE__)   #   <Michael.>
assert($x -eq 'Michael.')(__LINE__)

#   replace "A" => "x"      # wrong
$a='A'; $b='x'; $x = $s.Replace($a,$b)
text "s.Replace($a,$b) = <$x>"  (__LINE__)              #   < Michael. >
assert($x -eq ' Michael. ')(__LINE__)

#   replace "a" => "x"      # case sensitive !
$a='a'; $b='x'; $x = $s.Replace($a,$b)
text "s.Replace($a,$b) = <$x>"  (__LINE__)              #   < Michxel. >
assert($x -eq ' Michxel. ')(__LINE__)

#   other example
$s = "ABxCDExFGH"
show("using s = '$s'") $C_sColor_tmp
$a='x'; $b='.'; $x = $s.Replace($a,$b)
text "s.Replace($a,$b) = <$x>"  (__LINE__)              #   <AB.CDE.FGH>
assert($x -eq 'AB.CDE.FGH')(__LINE__)

#
#   s:  index               : get case-sensitive-char-position
#

f_lib_menuS1("index")(__LINE__)

show("using s = '$s'") $C_sColor_tmp

#   u:  indexOf
f_lib_menuS2('indexOf')(__LINE__)

$c='A'
$x = $s.IndexOf($c);    show "x := '$s'.IndexOf('$c')`t=> <$x>"  # 0
assert($x -eq 0)(__LINE__)
$c='a'
$x = $s.IndexOf($c);    show "x := '$s'.IndexOf('$c')`t=> <$x>"  # -1 : case?
$c='x'
$x = $s.IndexOf($c);    show "x := '$s'.IndexOf('$c')`t=> <$x>"  # 2
$c='G'
$x = $s.IndexOf($c);    show "x := '$s'.IndexOf('$c')`t=> <$x>"  # 8
$c='$'
$x = $s.IndexOf($c);    show "x := '$s'.IndexOf('$c')`t=> <$x>"  # -1: not found

#   u:  lastIndexOf
f_lib_menuS2('lastIndexOf')(__LINE__)

$c='A'
$x = $s.LastIndexOf($c);    show "x := '$s'.LastIndexOf('$c')`t=> <$x>"  # 0
assert($x -eq 0)(__LINE__)
$c='x'
$x = $s.LastIndexOf($c);    show "x := '$s'.LastIndexOf('$c')`t=> <$x>"  # 6
assert($x -eq 6)(__LINE__)
$c='G'
$x = $s.LastIndexOf($c);    show "x := '$s'.LastIndexOf('$c')`t=> <$x>"  # 8
assert($x -eq 8)(__LINE__)

#
#   s:  cutter :   subString && reMove
#

f_lib_menuS1("cutter")(__LINE__)

$s = "ABCDEFGHIJ"
show("using s = '$s'") $C_sColor_tmp

#   u:  subString
f_lib_menuS2('subString')(__LINE__)
$i=3    # cut(i){s[0]...s[n-1]}  => s[i]...s[n-1]
$x = $s.SubString($i);  show "x := '$s'.SubString($i) `t=> <'$x'>"    # <DEFGHIJ>
assert($x -eq 'DEFGHIJ')(__LINE__)

#   u:  remove  - reverse method to 'subString'
f_lib_menuS2('remove')(__LINE__)
$i=3    # cut(i){s[0]...s[n-1]}  => s[0]...s[i-1]
$x = $s.Remove($i);     show "x := '$s'.Remove($i) `t=> <'$x'>"       # <ABC>
assert($x -eq 'ABC')(__LINE__)
#
#   s:  chopper            :   remove NL [ TAB ]
#

f_lib_menuS1("chopper")(__LINE__)

#    chop:  $s  =   $s.replace("`n",'')
#    chomp: $s  =   $s.replace("`r`n",'')

#   define a multi-line string - don't use a HereString
#   chop is enough
$sDay = "Montag;Dienstag;`nMittwoch;Donnerstag;Freitag;`nSamstag;Sonntag"
show("using sDay =`n$sDay") $C_sColor_tmp

#   define a multi-line HereString
#   string contains `n and `r chars => we need chomp
$sMonth = @"
Januar;Februar;
März;April;Mai;Juni;Juli;August;September;Oktober;November;Dezember
"@
show("using sMonth =`n$sMonth") $C_sColor_tmp

#   u:  chop
f_lib_menuS2("chop")(__LINE__)
$sRc = f_lib_chop ($sDay)

#   show
show("sDay.chopped = <$sRc>")

#   u:  chomp
f_lib_menuS2("chomp")(__LINE__)
$sRc = f_lib_chomp $sMonth     # cut `r `n

#   show
show("sMonth.chomped = <$sRc>")


#
#   s:  split           $s.split($c) => $a
#

#   https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7.4#short-description

f_lib_menuS1("split")(__LINE__)


#
#   u:  example string with comma as separator
#

$s =  'alpha,beta,gamma,delta,epsilon'
text("using s = '$s'") (__LINE__) $C_sColor_tmp

#   split into an array
$c = ',' # comma
$a = $s.split($c)
text "s.split('$c') => <$a>" (__LINE__)

#   is array ?
$bRc = $a -is [array]
text("?isArray('a') =: <$bRc>")     #   true
assert($true -eq $bRc)(__LINE__)

#   length
$n  = $a.length
text "a.length = <$n>" (__LINE__)
assert(5 -eq $n)(__LINE__)

#   fetch one
$i = Get-Random $n
$x = $a[$i]
text "a[$i] = '$x'" (__LINE__)

#
#   u:  another string with space as separator
#

$s =  'anton bert cleo daphne'
text("using s = '$s'") (__LINE__) $C_sColor_tmp
$c = ' ' # comma
$a = $s.split($c)
text "s.split('$c') => <$a>" (__LINE__)
$i = Get-Random $a.Length
$x = $a[$i]
text "a[$i] = '$x'" (__LINE__)


#
#   s:  join        ::join($c,$s) => $string
#

#   https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_join?view=powershell-7.5

f_lib_menuS1("join")(__LINE__)
[array] $a = @()
$a += 'apple';
$a += 'banana';
$a += 'organge';
$n = $a.length
text "len($a) => <$n>" (__LINE__)

#   perform join
$s = [string]::join(";", $a)
$n = $s.length
text "join(a) => <$s>[$n]" (__LINE__)
    
#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

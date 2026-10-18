#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::array                  ###:[2024-11-17]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

#   !CRQ-241130:PS5.charRange   !PS7.charRange

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  define
        •   m:  init            :   $a = @()
        •   m:  add             :   $a += $x
        •   m:  remove
        •   m:  compare
            •   s:  compare.contains    :   $a -contains $x
            •   s:  compare.in          :   $x -in $a
            •   s:  compare.array
                •   u:  compare.array.Where-Object
                •   u:  compare.array.Compare-Object
        •   m:  copy            :   $b = $a
        •   m:  range           :   1..n
        •   m:  slicing         :   b = array $a[1..3]
        •   m:  reverse         :   b = [$a[n-1]..0]
        •   m:  select          :   i = 3
            •   s:  index       :   x(i) := 4
            •   s:  first       :   a =: <1 2 3>
            •   s:  last        :   a =: <8 9 10>
            •   s:  skip        :   skip(i)=:last(N-i)
            •   s:  skipLast    :   skipLast(i) := first(N-i)
        •   m:  uniq
        •   m:  sort
            •   s:  sort.ascending
            •   s:  sort.descending
            •   s:  sort.uniq
        •   m:  shuffle
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
=== :   PSH array
        m:  define
        m:  init        : $a = @()
        m:  add         : $a += $x
        m:  remove
        m:  compare     : $a -contains $x && $x -in $a
        m:  copy        : $b = $a
        m:  range       : $a = $i..$n
        m:  slicing     : $b = $a[$i..$n]
        m:  reverse     : $b = $a[($a.Length - 1)..0]
        m:  select      : Select-Object {-Index|-First|-Last|-Skip|-SkipLast} $n1
        m:  uniq        : $b = $a | Select-Object -Unique
        m:  sort        : $b = $a | Sort-Object
        m:  shuffle     : $b = Sort-Object {Get-Random}
'@

#   using
$g_sColor_text  =       $C_sColor_silent
$g_sColor_show  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'
$g_hMenuTabulator['out'] = $g_hMenuTabulator['spc']


#
#   m:  define
#

f_lib_menu("define")(__LINE__)

#   array of different types including another array
$a = @('harvey',15,$true,2.35,@('a','b','c'),'04/01/2009 15:00:00')
show "a := [$a]"
assert($a.length -eq 6)(__LINE__)

#   test
$bRc = f_lib_isType_array($a)
show "isArray := <$bRc>"
assert($bRc -eq $true)(__LINE__)

#   length
$i = $a.length
show "a.length := <$i>"

#   show array
show "show array member" $C_sColor_tmp
$i = 0
foreach($x in $a) {
    show "a[$i] =: <$x>"
    $i += 1
}

#   access end
show "acess array member {LAST}"  $C_sColor_tmp
$iLast  = $a.length - 1
$x      = $a[$iLast]
show "a[$iLast] =: <$x>"

#
#   m:  init
#

f_lib_menu("init")(__LINE__)

#   empty
text("empty array")(__LINE__)
$a = @()
show "a =: <$a>"

#
#   m:  add
#

f_lib_menu("add")(__LINE__)

#   add 1
$s = 'peter'
$a += $s
show "a += <'$s'> =: <$a>"

#   add 2
$i = 4711
$a += $i
show "a += <'$i'> =: <$a>"

#   add 3
$b = $false
$a += $b
show "a += <'$b'> =: <$a>"
assert($a.Length -eq 3)(__LINE__)


#
#   m:  remove
#

f_lib_menu("remove")(__LINE__)

$a = @('red','yellow','green')
show "a = <$a>"

#   using pipe syntax
$x = 'green'
$r = $a | Where-Object {$_ -ne $x }; show "a | where -ne <'$x'> := <$r>"
text "a = <$a>" (__LINE__) $C_sColor_std
text "a.Removed = <$r>" (__LINE__) $C_sColor_std


#
#   m:  compare         : -contains -in
#

f_lib_menu("compare")(__LINE__)

$a = @('red','yellow','green')
show "a = <$a>"

#   s:  compare.contains
f_lib_menuS1("compare.contains")(__LINE__)
$x = 'Yellow';  $y = $a -contains $x; show "a -contains <$x> := <$y>" # true
$x = 'blue';    $y = $a -contains $x; show "a -contains <$x> := <$y>" # false

#   s:  compare.in
f_lib_menuS1("compare.in")(__LINE__)
$x = 'Yellow';  $y = $x -in $a; show "a -in <$x> := <$y>"   # true
$x = 'blue';    $y = $x -notIn $a; show "a -notIn <$x> := <$y>" # false

#   s:  compare.array
f_lib_menuS1("compare.array")(__LINE__)

#   define range arrays
$a = 1..5
$b = 4..8
$c = 5..1
show "A:<$a>; B:<$b>; C:<$c>"

#   u:  compare.array.Where-Object
f_lib_menuS2("compare.array")(__LINE__)
show "cmd: Where-Object"  $C_sColor_tmp

#   compare A with B
$x = $a | Where-Object {$b -notContains $_}
$b = ( $x.Length -eq 0)
show "x := difference(A,B) =: <$x> => <$b>"
assert($false -eq $b)(__LINE__)

#   compare A with C
$x = $a | Where-Object {$c -notContains $_}
$b = ( $x.Length -eq 0)  # x is not an array
show "x := difference(A,C) =: <$x> => <$b>"
assert($true -eq $b)(__LINE__)

#   u:  compare.array.Compare-Object
f_lib_menuS2("compare.array.Compare-Object")(__LINE__)
show "cmd: Compare-Object"  $C_sColor_tmp

#   compare A with B using compare objects
$x = Compare-Object -ReferenceObject $a -DifferenceObject $b
$b = ( $x.Length -eq 0)
show "x := compareObject(A,B) =: <$x> => <$b>"
assert($false -eq $b)(__LINE__)

#   compare A with C using compare objects
$x   = Compare-Object -ReferenceObject $a -DifferenceObject $c
$b = ( $x.Length -eq 0)
show "x := compareObject(A,C) =: <$x> => <$b>"
assert($true -eq $b)(__LINE__)

#
#   m:  copy
#

f_lib_menu("copy")(__LINE__)

$b = $a
$b += 'blue'        # realy copy, not a link
show "a = <$a>"
show "b = <$b>"
assert($a.length -ne $b.Length)(__LINE__)

#
#   m:  range
#

f_lib_menu("range")(__LINE__)

#   integer range
[array] $a = 1..5
show "a = <$a>"
assert($a -is [array])(__LINE__)

#   char range
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.charRange
    [array] $a = 'a'..'h'
    show "a = <$a>"
    assert($a -is [array])(__LINE__)
}

#
#   m:  slicing
#

f_lib_menu("slicing")(__LINE__)

[array] $a = 1..10
show "a = <$a>"          #  <1 2 3 4 5 6 7 8 9 10>

[array] $b = [array] $a[5..7]
show "b = <$b>"         #   <6 7 8>

[array] $c = [array] $a[0] +  [array] $a[2..4] + [array] $a[$a.length - 1]
show "c = <$c>"         #   <1 3 4 5 10>

assert($c.Length -eq 5)(__LINE__)


#
#   m:  reverse
#

f_lib_menu("reverse")(__LINE__)

#   char range
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.charRange
    [array] $a = 'a'..'h'
    show "a := <$a>"
}

$b = $a[($a.Length - 1)..0]
show "a.reverse := <$b>"

#
#   m:  select
#

f_lib_menu("select")(__LINE__)

[array] $a = 1..10                  #   a := <1 2 3 4 5 6 7 8 9 10>
show "a := <$a>"

$n1 = ( Get-Random -Maximum $a.length )
$n2 = ( Get-Random -Maximum $a.length )
$n3 = ( Get-Random -Maximum $a.length )
show "n1,n2,n3 := <$n1>,<$n2>,<$n3>"

#   using x=3

#   s:  index

f_lib_menuS1 "Index" (__LINE__)         #   <4>

$x = $a | Select-Object -Index $n1
show "index <$n1> =: <$x>"
assert($x -eq $a[$n1])

$x = $a | Select-Object -Index $n2
show "index <$n2> =: <$x>"
assert($x -eq $a[$n2])

$x = $a | Select-Object -Index $n3
show "index <$n3> =: <$x>"
assert($x -eq $a[$n3])


#   s:  first

f_lib_menuS1 "First" (__LINE__)         #   <1 2 3>

$x = $a | Select-Object -First $n1
show "first <$n1> =: <$x>"

$x = $a | Select-Object -First $n2
show "first <$n2> =: <$x>"

$x = $a | Select-Object -First $n3
show "first <$n3> =: <$x>"

#   s:  last

f_lib_menuS1 "Last" (__LINE__)          #   <8 9 10>

$x = $a | Select-Object -Last $n1
show "last <$n1> =: <$x>"

$x = $a | Select-Object -Last $n2
show "last <$n2> =: <$x>"

$x = $a | Select-Object -Last $n3
show "last <$n3> =: <$x>"


#   s:  skip        :   skip(x)=:last(N-x)

f_lib_menuS1 "Skip" (__LINE__)          #   <4 5 6 7 8 9 10>

$x = $a | Select-Object -Skip $n1
show "skip <$n1> =: <$x>"

$x = $a | Select-Object -Skip $n2
show "skip <$n2> =: <$x>"

$x = $a | Select-Object -Skip $n3
show "skip <$n3> =: <$x>"


#   s:  skipLast    :   skipLast(x) := first(N-x)

f_lib_menuS1 "SkipLast" (__LINE__)      #   <1 2 3 4 5 6 7>

$x = $a | Select-Object -SkipLast $n1
show "skipLast <$n1> =: <$x>"

$x = $a | Select-Object -SkipLast $n2
show "skipLast <$n2> =: <$x>"

$x = $a | Select-Object -SkipLast $n3
show "skipLast <$n3> =: <$x>"


#
#   m:  uniq
#

f_lib_menu("uniq")(__LINE__)

#  build array
$a = 1,5,3,2,3,3,3,4,2,5
$n = $a.Length
show "a = <$a> ($n)"
assert($a.Length -eq $n)

$aUniq  = $a | Select-Object -Unique
$n = $aUniq.Length
show "a.uniq = <$aUniq> ($n)"

#
#   m:  sort
#

f_lib_menu("sort")(__LINE__)

$n = 10
$a = @()
for( $i = 1; $i -le $n; $i ++) {
    $a += ( Get-Random -Maximum 1000 )
}
show "a = <$a>"
assert($a.Length -eq $n)

#
#   s:  sort.ascending
#

f_lib_menuS1("sort.ascending")(__LINE__)

$aSorted  = $a | Sort-Object
show "a.sorted.asc = <$aSorted>"

#
#   s:  sort.descending
#

f_lib_menuS1("sort.descending")(__LINE__)

$aSorted_des  = $a | Sort-Object -Descending
show "a.sorted.des = <$aSorted_des>"

#
#   s:  sort.uniq
#

f_lib_menuS1("sort.uniq")(__LINE__)

$n = 10
$a = @()
for( $i = 1; $i -le $n; $i ++) {
    $a += ( Get-Random -Maximum 10 )
}
$n = $a.Length
show "a = <$a> ($n)"

$aSortedUniq  = $a | Sort-Object | Select-Object -Unique
$n = $aSortedUniq.Length
show "a.sorted.uniq = <$aSortedUniq> ($n)"

#
#   m:  shuffle
#

f_lib_menu("shuffle")(__LINE__)

$a = $aSortedUniq
show "a             =   <$a>"

$aShuffled  = $a | Sort-Object {Get-Random}
show "a.shuffled    =   <$aShuffled>"

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

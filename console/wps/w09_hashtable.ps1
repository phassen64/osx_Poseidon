#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::hashtable              ###:[2024-11-19]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

#   !CRQ-PS5:ordered    :: !PS7.ordered
<#
    content:
    •   b:  include

    •   b:  header
        •   m:  define
            •   s:  define.typed
            •   s:  define.ordered
        •   m:  show
            •   s:  show.string
            •   s:  show.foreach.keys   : $h.keys
            •   s:  show.foreach.values : $h.values
            •   s:  show.foreach.enumerator
            •   s:  show.enumerator | ForEach-Object
            •   s:  show.enumerator | %
        •   m:  init
        •   m:  add
            •   s:  add.directly
            •   s:  add.byMethod
        •   m:  remove
        •   m:  count
        •   m:  ordered
        •   m:  output-formatted
            •   s:  output.sorted
            •   s:  output.format
                •   s:  format.table
                •   s:  format.list


    •   b:  footer
#>

#   ordered hashes doesn't work with '[hashtable]''
function F_putHash($p_hHash, # [hashtable]
                [string] $p_sName = 'h', [int] $p_iLine = -1) {
    $i = 1
    $n = $p_hHash.Count
    $s = $p_sName
    if ($p_iLine -gt 1) {
        $s += " at:[$p_iLine]"
    }
    show $s $g_sColor_text
    foreach ($x in $p_hHash.getEnumerator()) {
        $key = $x.Key
        $val = $x.Value
        #   $s = '<' + $p_sName + '>'
        $s = 'h {'
        $s += " $i/$n } =: $key => $val"
        show $s
        $i ++
    }
}


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @"
=== :   PSH hashtable
        m:  define
        m:  show
        m:  init    : $h=@{}
        m:  add     : $h.Add($k,$v)
        m:  remove  : $h.Remove($k)
        m:  count   : hashSize
        m:  ordered hash
        m:  output formatted
"@

#   using
$g_sColor_text  =    'DarkYellow'
$g_sColor_show  =    'Gray'  #   $C_sColor_silent
$g_hMenuTabulator['out'] =  $g_hMenuTabulator['spc']
$n = 16
$i = Get-Random -Maximum $n     # 0..n-1


#
#   m:  define
#

f_lib_menu("define")(__LINE__)


[hashtable] $hCity = @{
    'Germany'= 'Berlin';
    'France' = 'Paris';
    'USA'   =  'Washington'
}
F_putHash($hCity)('define.hCity')(__LINE__)

[hashtable] $hCelebrity = @{
    'Pop'       =   'BritneySpears';
    'Movie'     =   'JeffBridges';
    'Soccer'    =   'DiegoMaradonna'
}
F_putHash($hCelebrity)('define.hCelebrity')(__LINE__)

#
#   s:  define.typed
#

#   ohne string=>key syntax

f_lib_menuS1("define.typed")(__LINE__)

$h = @{}
$h.m_bVal = $true
$h.m_iVal = 123
$h.m_sVal = 'ok'
$h.m_fVal = 47.11
F_putHash($h)('typed')(__LINE__)

#
#   s:  define.ordered
#

f_lib_menuS1("define.ordered.Person")(__LINE__)

#   ordered without '[hashtable]' keyword
$h = [ordered] @{
    'name'      = 'peter';
    'certification' = @(1974,1980,1985,1997,2016);
    'smart'     =  $true;
    'bodySize'  =  1.67;
    'age'       =  60;
}
F_putHash($h)('h.Person.Ordered')(__LINE__)

#   save
$hPerson = [ordered] @{}
$hPerson = $h

#
#   s:  show.string
#

f_lib_menuS1("show.string")(__LINE__)

if ($i % 2 -eq 0) {
    #   s:  show.directly
    f_lib_menuS1("directly")(__LINE__)
    text("immediately by name")
    $hCity  # shows the hash immediately
}
else {
    #   s:  show.OutString
    f_lib_menuS1("asString")(__LINE__)
    text("as string")
    $sHash = $hCity | Out-String    # create a String-Object
    show "sHash:=<$sHash>"          # => better
}

#
#   s:  show.foreach.keys   : $h.keys
#

f_lib_menuS1("show.keyOnly")(__LINE__)

text("h.Keys")
$i = 1
$n = $hCity.Count
foreach ($x in $hCity.Keys) {
    show "key [$i] : $x"
    $i ++
}

#
#   s:  show.foreach.values : $h.values
#

f_lib_menuS1("valueOnly")(__LINE__)

text("h.Values")
$i = 1
$n = $hCity.Count
foreach ($x in $hCity.Values) {
    show "value [$i] : $x"
    $i ++
}

#
#   s:  show.foreach.enumerator
#

f_lib_menuS1("enumerator")(__LINE__)

text("h.getEnumerator()")
$i = 1
$n = $hCity.Count
foreach ($x in $hCity.getEnumerator()) {
    $key = $x.Key
    $val = $x.Value
    show "elem[$i/$n] : $key => $val"
    $i ++
}

#
#   s:  show.enumerator | Foreach-Object
#

f_lib_menuS1("show HASH with foreach-Object")(__LINE__)

text("City")
$i = 1
$hCity.getEnumerator() | ForEach-Object {
    $key = $_.Key       # aktuelles object '$_'
    $val = $_.Value
    show "[$i/$n]:: <$key> => <$val>"
    $i ++
}

#
#   s:  show.enumerator | %        % = :: "ForEach-Object"
#

f_lib_menuS1("show HASH with %")(__LINE__)

text("Celebrity")
$i = 1
$hCelebrity.getEnumerator() | % {
    $key = $_.Key
    $val = $_.Value
    show "[$i/$n]:: <$key> => <$val>"
    $i ++
}

#
#   m:  init
#

f_lib_menu("init")(__LINE__)

$h = @{}
show "h:=<$h> * empty"

#   check.getType
$tRc = $h.GetType(); text("type(h) =: '$tRc'")
assert('hashtable' -eq $tRc)(__LINE__)

#   check.Is
$bRc = $h -is [hashtable]
text("?isHashtable(h) =: <$bRc>")
assert($true -eq $bRc)(__LINE__)

#
#   m:  add
#

f_lib_menu("add")(__LINE__)

F_putHash($hCity)('City.now')(__LINE__)

#   s:  add.directly
f_lib_menuS2("add_directly")(__LINE__)
$k='Russia'; $v='Moscow'; $hCity[$k] = $v
show "add h(k,v) = h('$k','$v')"
F_putHash($hCity)("City.added:<$k>")(__LINE__)

#   s:  add.byMethod
f_lib_menuS2("add_by_method")(__LINE__)

$k='GreatBritain'; $v='London'
show "add h(k,v) = h('$k','$v')"
$hCity.Add($k,$v)
F_putHash($hCity)("City.added:<$k>")(__LINE__)

$k='China'; $v='Peking'
$hCity.Add($k,$v)
show "add h(k,v) = h('$k','$v')"
F_putHash($hCity)("City.added:<$k>")(__LINE__)

#
#   m:  remove
#

f_lib_menu("remove")(__LINE__)
F_putHash($hCity)('City.now')(__LINE__)
$k = 'Germany'
$hCity.Remove($k)
F_putHash($hCity)("City.removed:<$k>")(__LINE__)

#
#   m:  count
#

f_lib_menu("count")(__LINE__)

$iLen = $hCity.Count; show "hCity.Len : <$iLen>"
$iLen = $hPerson.Count; show "hPerson.Len : <$iLen>"
$iLen = $hCelebrity.Count; show "hCelebrity.Len : <$iLen>"

#
#   m:  ordered
#

f_lib_menu("ordered hash")(__LINE__)

#   hash.standard
$h = [hashtable] @{ a = 1; b = 2; c = 3; d = 4 }
F_putHash($h)('h.NoOrder')(__LINE__)

#   hash.ordered
$h  = [ordered] @{ a = 1; b = 2; c = 3; d = 4 }
F_putHash($h)('h.Ordered')(__LINE__)

#   check.getType
$tRc = $h.GetType(); text("type(h) =: '$tRc'")
if ( $v_hTutor.m_bShellIdPsh__7 ) {
    $sTy = 'ordered'
} else {
    $sTy = 'System.Collections.Specialized.OrderedDictionary'
}
assert($sTy -eq $tRc)(__LINE__)

#   check.Is.PS7.only
if ( $v_hTutor.m_bShellIdPsh__7 ) {
    $bRc = $h -is [ordered]                 # !PS7.ordered
    assert($true -eq $bRc)(__LINE__)
}
#   check.Is
$bRc = $h -is [System.Collections.Specialized.OrderedDictionary]
text("?isOrdered(h) =: <$bRc>")
assert($true -eq $bRc)(__LINE__)

#
#   m:  output-formatted
#

f_lib_menu("output-formatted")(__LINE__)
echo "`n"

f_lib_menuS1("sorted")(__LINE__)
echo "`n"

#
#   s:  output.sorted
#

#   Sortiert wird nur die Ausgabe des Hashes,
#   und nicht das Hash selbst !


text("define")

# define
$n = 8
$vMax = 1000
$h = @{}
for ($i = 0; $i -lt $n; $i ++) {
    $k = 'key_' + $i
    $v = Get-Random -Maximum $vMax
    $h[$k] = $v
}
F_putHash($h)('hNumber')

#   sort by value
text("sorted")

$i = 0
$n = $h.Count
$h.GetEnumerator() | Sort-Object -Property:Value | % {
    $i ++
    $s = "[$i/$n] : " + $_.key + ' : ' + $_.value
    show $s
}


#
#   s:  output.format
#

#   Auch hier wird die Ausgabe eines
#   hashes betrachtet.
#   Es 2 verschiedene Methoden.

echo "`n"
f_lib_menuS1("format")(__LINE__)

#   empty hash
$hPet = @{}

#   add1
$hPet.Add('Cats', 'Frisky')
$hPet.Add('Dog', 'Spot')
$hPet.Add('Fish', 'Nimo')
$hPet.Add('Hamster', 'Whiskers')

#   add2
$hPet.Rabbit    = 'Harvey'
$hPet.Bird      = 'Putzi'


#
#   u:  format.table    == string-output
#

f_lib_menuS2("format table")(__LINE__)
$hPet | Format-Table

#
#   u:  format.list
#

f_lib_menuS2("format list")(__LINE__)
$hPet | Format-List

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

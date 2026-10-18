#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::dataType               ### :[2024-11-12]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   !CRQ-241130:PS5.noBinary   : !PS7.bin:PS7 only is supporting binary

<#
    content:

    •   b:  include

    •   b:  header

        •   m:  bool
        •   m:  string
        •   m:  char        : 8
        •   m:  byte        : 8
        •   m:  int         : 16
        •   m:  long(int64) : 64
        •   m:  float(single) && double
        •   m:  decimal     : 128
        •   m:  array
        •   m:  hashtable
        •   m:  DateTime
        •   m:  Object

    •   b:  footer

#>


#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name


#
#   b:  header
#

f_lib_header(__LINE__)

#   write a multi-line string
Write-Host @"
=== :   PSH DataTypes
        m:  bool
        m:  string
        m:  char
        m:  byte
        m:  int
        m:  long(int64)
        m:  float(single) && double
        m:  decimal
        m:  array
        m:  hashtable
        m:  DateTime
        m:  Object
"@


$s = $script:g_hScpMem.m_cDrv;  info "scp.Drv:{$s}"
$s = $script:g_hScpMem.m_sNam;  info "scp.Nam:{$s}"

#   ---------------------------------------------------------------------------
#   m:  bool
#   ---------------------------------------------------------------------------

f_lib_menu('bool')(__LINE__)

#   define
$b  = $true
f_lib_text("b =: <$b>")
$b2  = $false
f_lib_text("b2 =: <$b2>")

#   check
$tRc = $b.GetType();    f_lib_text("type('$b') =: '$tRc'")
$bRc = $b -is [bool];   f_lib_text("?isBool('$b') =: <$bRc>")

#   ---------------------------------------------------------------------------
#   m:  string
#   ---------------------------------------------------------------------------

f_lib_menu('string')(__LINE__)


#   define a string
$s = 'peter'

#   show
Write-Output "`tMy Text is : '$s'"

#   define
$s = "Harvey"

#   other text
f_lib_text "s = '$s'"

#   getType
$tRc = $s.GetType();    text("type('$s') =: '$tRc'")      # 'string'

#   check
$bRc = $s -is [string]; text("?isString('$s') =: <$bRc>") # true

#   length
$iLen = $s.Length;      text "Len('$s') =: $iLen"

#   singleQuoted_vs_doubleQuoted:'s'_vs_"s"
$i = 45
$s1 = 'Peter ist älter als: <$i> Jahre.'        # single-quotion
$s2 = "Peter ist jünger als: <$i> Jahre."        # double-quotion
show "s1:<$s1>"     # s1: 'Peter... <$i> Jahre.'     => untouched
show "s2:<$s2>"     # s2: "Peter... <$j> Jahre."     => evaluation

#   ---------------------------------------------------------------------------
#   m:  char
#   ---------------------------------------------------------------------------

f_lib_menu('char')(__LINE__)

#   define
$c  = [char]'1';        text("c =: '$c'") # '1'
$c  = [char]0x21;       text("c =: '$c'") (__LINE__) # '!'
$c  = [char]0x24;       text("c =: '$c'") # '$'
$c  = [char]0x41;       text("c =: '$c'") # 'A'

#   check
$tRc = $c.GetType();    text("type('$c') =: '$tRc'")
$bRc = $c -is [char];   text("?isChar('$c') =: <$bRc>")

#   concat
$c1 = 'a'
$c2 = 'b'
$s = $c1 + ' & ' + $c2
text "concat('$c1','$c2') =: $s" (__LINE__)

#   ---------------------------------------------------------------------------
#   m:  byte        size:8
#   ---------------------------------------------------------------------------

f_lib_menu('byte')(__LINE__)

#   define using hex value
$y = [byte]0x21;        text("y =: '$y'") # 33 = '!''

#   check
$tRc = $y.GetType();    text("type('$y') =: '$tRc'")
$bRc = $y -is [byte];   text("?isByte('$c') =: <$bRc>")

#   range
$y = [byte]::MaxValue;   text("yMax =: <$y>")   # 255
$y = [byte]::MinValue;   text("yMin =: <$y>")   # 0

#   ---------------------------------------------------------------------------
#   m:  int         size:32
#   ---------------------------------------------------------------------------

f_lib_menu('integer')(__LINE__)

#   define
$i = 123
text("i =: <$i>")

#   check
$tRc = $i.GetType();    text("type('$i') =: '$tRc'")    # 'int'
$bRc = $i -is [int];    text("?isInt('$i') =: <$bRc>")  # true

#   range
$i = [int]::MaxValue;   text("iMax =: <$i>")    #   <2147483647>
$i = [int]::MinValue;   text("iMin =: <$i>")    #   <-2147483648>

#    hexValue
$i = 0x40;  text("hex2dec(0x40) =: <$i>")

#    binValue
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $s = '10101111' # 0xaf=175d
    $i = [Convert]::ToInt32($s, 2)      #   af = 175
    text("bin2dec('$s') =: <$i>")
}

#    hexValue 0x41b2c3d4 as bin
if ( $v_hTutor.m_bShellIdPsh__7 ) {     #   !PS7.bin
    $i = 0b01000001101100101100001111010100
    $s = [System.String]::Format("{0:X}",$i)
    text("bin2hexStr($i) =: <$s>$")
}

#   ---------------------------------------------------------------------------
#   m:  long(int64)     size:64
#   ---------------------------------------------------------------------------

f_lib_menu('long')(__LINE__)

#   define
[long]  $l      =   -1234567890L;  text("l   =: <$l>")
[int64] $i      =   987654321;     text("i64 =: <$i>")

#   getType
$tRc = $l.GetType();        text("type.l('$l') =: '$tRc'")
$tRc = $i.GetType();        text("type.i('$i') =: '$tRc'")  # ==: long

#   check
$bRc = $l -is [long];       text("?isLong('$l') =: <$bRc>")     # true
$bRc = $i -is [int64];      text("?isInt64('$i') =: <$bRc>")    # true

#   range
#   <9223372036854775807>...<-9223372036854775808>
$l = [long]::MaxValue;      text("lMax =: <$l>")
$l = [long]::MinValue;      text("lMin =: <$l>")

#   ---------------------------------------------------------------------------
#   m:  float(single) && double
#   ---------------------------------------------------------------------------

f_lib_menu('float(single) && double')(__LINE__)

#   REM: dataType.single == dataType.float

#   define
[single] $g = 9.321;        text("g =: <$g>")
[float]  $f = 6.2812;       text("f =: <$f>")
[double] $d = 3.1415;       text("d =: <$d>")

#   getType
$tRc = $g.GetType();        text("g.type('$g') =: '$tRc'")      # float
$tRc = $f.GetType();        text("f.type('$f') =: '$tRc'")      # float
$tRc = $d.GetType();        text("d.type('$d') =: '$tRc'")      # double

#   checkType
$bRc = $g -is [single];     text("?isSingle('g')    =: <$bRc>") # true
$bRc = $f -is [float];      text("?isFloat('$f')    =: <$bRc>") # true
$bRc = $d -is [double];     text("?isDouble('d')    =: <$bRc>") # true

#   range
$f = [float]::MaxValue;     text("f.max =: <$f>")   #   <3.402823E+38>
$f = [float]::MinValue;     text("f.min =: <$f>")   #   <-3.402823E+38
$d = [double]::MaxValue;    text("d.max =: <$d>")   #   <1.79769313486232E+308>
$d = [double]::MinValue;    text("d.min =: <$d>")   #   <-1.79769313486232E+308>


#   ---------------------------------------------------------------------------
#   m:  decimal     size:128 high-precision
#   ---------------------------------------------------------------------------

f_lib_menu('decimal')(__LINE__)

#   define
[decimal] $d = 123;     text("d =: <$d>")

#   check
$tRc = $d.GetType();    text("type('$d') =: '$tRc'")
$bRc = $d -is [decimal];    text("?isDecimal('$d') =: <$bRc>")

#   range
#  <79228162514264337593543950335>... <-79228162514264337593543950335>
$d = [decimal]::MaxValue;   text("dMax =: <$d>")
$d = [decimal]::MinValue;   text("dMin =: <$d>")


#   define as float
#  <-123456789.987654>
[decimal] $d = -123456789.987654321;     text("d =: <$d>")

#   ---------------------------------------------------------------------------
#   m:  array
#   ---------------------------------------------------------------------------

f_lib_menu('array')

#   define simple
$a = 'US','DE','EN','FR','SP','RU'
text "array.simple := '$a'" (__LINE__)

#   check
$tRc = $a.GetType();    text("a.type('$a')  =: '$tRc'")     # 'System.Object[]'
$bRc = $a -is [array];  text("?isArray('a') =: <$bRc>")     #   true

#   define explicitely
[array] $a = @('LAS','BAR','MUC')
text "array.explic := '$a'" (__LINE__)

#   access to 1 element
$i = 0; $x = $a[$i] ; show "a[$i] =:  '$x'"
$i = 2; $x = $a[$i] ; show "a[$i] =:  '$x'"

#   count
$n = $a.Count; text "`iLen(<$a>) => <$n>"

#   define empty
[array] $a = @()

#   add 1
$a += 'Harvey'
text "array.added := '$a'" (__LINE__)


#   ---------------------------------------------------------------------------
#   m:  hashtable
#   ---------------------------------------------------------------------------

f_lib_menu('hash')

#   define
[hashtable] $h = @{
        "Washington"    = "Olympia";
        "Oregon"        = "Salem";
        "California"    = "Sacramento"}

#   check
$tRc = $h.GetType();        text("h.type('$h')  =: '$tRc'") #   'hashtable'
$bRc = $h -is [hashtable];  text("?isHash('h') =: <$bRc>")  #   true

#   access
$s = 'Washington'
$x = $h[$s]
text "hCity['$s'] => '$x'"

#   define empty
[hashtable] $h = @{}

#   add 1
$h['surName'] = 'peter'

#   fetch
$x = $h['surName']
text "h['surName'] => '$x'"


#   ---------------------------------------------------------------------------
#   m:  DateTime
#   ---------------------------------------------------------------------------

f_lib_menu('DateTime')

#   define current date
[DateTime]  $tDtm = Get-Date
show "DTM := '$tDtm'"       #   DTM := '11/12/2024 21:12:32'

#   check
$tRc = $tDtm.GetType();         text("dtm.type      =: '$tRc'")  #   'datetime'
$bRc = $tDtm -is [DateTime];    text("?isDtm('dtm') =: <$bRc>")  #   true

#   take my birthdy
text "takeMyBirthday" (-1) 'DarkYellow'
[DateTime]  $tDtm = '07/09/1964 09:45:15'       # MM-dd-YYYY HH:mm:ss
[string]    $sDtm = $tDtm.ToString('yyyy-MM-dd HH:mm:ss')
show "DTM := '$tDtm' => '$sDtm'"

#   ---------------------------------------------------------------------------
#   m:  Object
#   ---------------------------------------------------------------------------

f_lib_menu('object')

#   define class
class CTmp {
    [string]    $m_sName;
}

#   create object
$p = [CTmp]::new()

#   write into object
$p.m_sName = 'peter'

#   check
$tRc = $p.GetType();        text("p.type      =: '$tRc'")  #   'CTmp'
$bRc = $p -is [Object];     text("?isObj(p)   =: <$bRc>")  #   true

#   b:  footer

f_lib_footer(__LINE__)
exit(-(__LINE__))

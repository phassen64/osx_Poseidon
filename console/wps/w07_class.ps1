#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::class                  ###:[2024-11-16]
#   ***************************************************************************
#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   url: https://www.tutorialspoint.com/powershell

<#
    content:
    •   b:  include
        •   m:  define : class and object
        •   m:  constructor
        •   m:  hidden
        •   m:  static
        •   m:  derivation
        •   m:  libTest
    •   b:  header
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
=== :   PSH class
        m:  define : class and object
        m:  hidden
        m:  static
        m:  derivation
"@

#   using
<#
    $n          = 100
    $i = Get-Random -Maximum $n   # 0..n-1
    $j = Get-Random -Maximum $n   # 0..n-1
    puts "`n&&& using n=<$n>; i=<$i>; j=$j>"  -p_sColor $C_sColor_silent
#>



#   ===========================================================================
#   m:  define : class and object
#   ===========================================================================

f_lib_menu("define")(__LINE__)

class CSpot {
    [string]     $m_sName;
    [int]        $m_iNumber;
}

$X = [CSpot]::new();      # !PHA: with ';'

#   write into class
$X.m_sName      = 'Peter'
$X.m_iNumber    = 123

#   access
$s = $X.m_sName;    text "name:{$s}" (__LINE__)
$i = $X.m_iNumber;  text "number:{$i}" (__LINE__)

#   identiity
$s = $X.GetType();    text "type(X) =: '$s'" (__LINE__)
$i = $X.Length;    text "len(X) =: '$i'" (__LINE__)     # 1

#
#   s:  Get-Member
#

f_lib_menuS1("AllMemberOfObject")(__LINE__)

#   pipe
$i = 0
$X | Get-Member | Foreach-Object {
    text "elem [$i] : '$_'"
    $i += 1
}

f_lib_menuS1("Object.property")(__LINE__)

#   pipe
$i = 0
$X | Get-Member -MemberType 'Property' | Foreach-Object {
    text "property [$i] : '$_'"
    $i += 1
}


f_lib_menuS1("MethodsOfObject")(__LINE__)

#   pipe
$i = 0
$X | Get-Member -MemberType 'Method' | Foreach-Object {
    text "method [$i] : '$_'"
    $i += 1
}
f_lib_assert(__LINE__)

#==============================================================================
#   m:  constructor
#==============================================================================

f_lib_menu("constructor")(__LINE__)

class CPerson {
    [uint16]     $m_iCtr = 0;
    [string]     $m_sName;
    [DateTime]   $m_tDtm;
    CPerson([string] $p_sName, [DateTime] $p_tBirthday) {
        $this.m_sName    = $p_sName
        $this.m_tDtm     = $p_tBirthday
        $this.m_iCtr ++;
    }
    [void] f_info() {
        $i = $this.m_iCtr;  text("p.ctr   :   <$i>")
        $s = $this.m_sName; text("p.name  :   <$s>")
        $t = $this.m_tDtm;  text("p.dtm   :   <$t>")
    }
}   # class:CPerson

#   create
$X = [CPerson]::new('Peter','July 9 1964 09:45:30')

#   info
$X.f_info()


#==============================================================================
#   m:  hidden
#==============================================================================

f_lib_menu("hidden")(__LINE__)

#   define a class with a hidden attribute

class CProduct {
    [string]    $m_sName;
    hidden [uint64]    $m__uSerialNumber = 12345;
    [uint64]  f_getSnr() {
        return $this.m__uSerialNumber;
    }
}

trace(__LINE__)(__FUNCTION__)('new')
$X = [CProduct]::new();  # !PHA: with ';'

trace(__LINE__)(__FUNCTION__)('setName')
$X.m_sName = 'Audi'

#   read simple attribute
$s = $X.m_sName; text ("Name:'$s'")

#   get snr
[uint64] $uSnr = 0

#   get.snr.direct
$uSnr = $X. $m__uSerialNumber               # access to hidden not valid
text ("snr.direct:<$uSnr>")(__LINE__)       # 0

#   get.snr.method
$uSnr = $X.f_getSnr();
text ("snr.viaMethod:<$uSnr>")(__LINE__)    # 12345

#   write.snr.direct --- acess possible
$X. m__uSerialNumber = 4711
$uSnr = $X.f_getSnr();
text ("snr.viaMethod2:<$uSnr>")(__LINE__)   # 4711


#==============================================================================
#   m:  static
#==============================================================================

f_lib_menu("static")(__LINE__)

class CTime {
    [uint16]     $m_uCtr;
    #   static attribute
    static [DateTime]  $g_tDtm = $(Get-Date)
    #   static method
    static [int] f_uTimeSpan (  [DateTime]$p_tDTM_start,
                         [DateTime]$p_tDTM_stopp ) {
        return f_lib_iTimeSpan ($p_tDTM_start)($p_tDTM_stopp)
    }
}   # class:CTime

#   fetch library dateTime
$dtmLib = f_lib_version_dateTime
text ("dtm.lib:<$dtmLib>")(__LINE__)

#   access static.attribute - dateTime
$dtmCls = [CTime]::g_tDtm
text ("static.attr:<$dtmCls>")(__LINE__)

#   access static.method - timeSpan
$i = [CTime]::f_uTimeSpan($dtmLib,$dtmCls)
text ("static.meth:<$i>")(__LINE__)


#==============================================================================
#   m:  derivation
#==============================================================================

f_lib_menu("derivation")(__LINE__)

class CLifeform {
    [bool]  $m_bAlive;
}
class CAnimal : CLifeform {
    [single]  $m_fSpeed;
}

#   create
$X = [CAnimal]::new()

#   write member data
$X.m_bAlive = $true     #   using CLifeform
$X.m_fSpeed = 5.6       #   using CAnimal

#   show
$bVal = $X.m_bAlive; text("alive:[$bVal]")(__LINE__)
$fVal = $X.m_fSpeed; text("speed:[$fVal]")(__LINE__)


#==============================================================================
#   m:  libtest
#==============================================================================

f_lib_menu("libTest")(__LINE__)

#   create
$scp = __FILE__
$x = [CTutor]::new($scp,'July 9 1964 09:45:30')

#   info
$x.f_hello()
$x.f_info()




#==============================================================================
#   b:  footer
#==============================================================================

f_lib_footer(__LINE__); exit(-(__LINE__))

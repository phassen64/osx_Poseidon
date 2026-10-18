#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::file                   ###:[2024-11-28]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

#   !CRQ-241130:PS5.Encoding    :: !PS7
#   url:    https://powershellbyexample.dev/post/time-and-date/

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  define.Buffer
        •   m:  TextFile
            •   s:  TXT.create
            •   s:  TXT.write
            •   s:  TXT.read
        •   m:  BinaryFile
            •   s:  BIN.create
            •   s:  BIN.write
            •   s:  BIN.read
        •   m:  FileHandling
            •   s:  Copy-File
            •   s:  Remove-File
            •   s:  Rename-File
            •   s:  Move-File
    •   b:  footer
#>

#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  function
#

function F_getTextBuffer([string] $p_sSample, [int] $p_iLine) {
    #   formatIndexStr
    $F = '{0:d2}'
    #   convert sample into string
    [array] $aSample = $p_sSample.ToCharArray()
    #   return Array
    [array] $aRc = $null
    #   append return String
    for ($i = 0; $i -lt $p_iLine; $i ++) {
        #   indexStr
        $sIdx = [String]::Format($F, $i + 1)
        #   dataStr
        $sVal = -join ( (1.. $aSample.Length) | `
                        ForEach-Object {  $aSample  | Get-Random })
        $sVal = $sVal.Remove(7)
        #   prepare LineString
        $s = $null
        $s += '!:'
        $s += $sIdx
        $s += ':'
        $s += $sVal
        $s += ':$'
        #   add
        $aRc += $s
        info "added:[$i]:<$s>"
    }   # for
    return $aRc
} # F~getTextBuffer

function F_getBinaryBuffer([int] $p_iBytes) {
    [array] $aRc = @()
    $iMax = [int]::MaxValue -band 0xFF
    #   !CRQ-241128:Don't use [byte] !
    info("iMax:'$iMax'")
    for ($i = 0; $i -lt $p_iBytes; $i ++) {
        $iRnd = Get-Random -Maximum $iMax
        $aRc += $iRnd
        if (  $i -lt 8) {
            info "buffer[$i] = $iRnd"
        }
    }   # for
    return $aRc
} # F~getBinaryBuffer

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH file
        m:  define Buffer
        m:  TextFile     : Create|Write|Read
        m:  BinaryFile   : Create|Write|Read
        m:  FileHandling : Copy|Remove|Rename|Move
'@


#   createDir IOM
#   $pDtm   =   $(Get-Date)

$X      =   [CTutor]::new((__FILE__),(Get-Date))
$sDirTop   =   $X. f_mkTestDir($null)
show "dirTestCreated:<$sDirTop>:<True>"

#   show
$script:g_sDirIom = $sDirTop

#   menu
$g_sColor_text  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'

#   better show
$g_sColor_show  =       $C_sColor_std
$g_hMenuTabulator['out'] = $g_hMenuTabulator['spc']


#   ===========================================================================
#   m:  define.Buffer
#   ===========================================================================

f_lib_menu("define buffer")(__LINE__)

#   get SampleTextBuffer
$s = '���������������'
$s = 'abcdefghijklmnopqrstuvwxyz' # better
[array] $aBuffer
$aBuffer = F_getTextBuffer($s)(8)
$i = $aBuffer.Length
show "bufferTXT.created:<$i>"

#   get SampleBinaryBuffer
[array] $yBuffer = @()
$yBuffer = F_getBinaryBuffer(8)
$i = $yBuffer.Length
show "bufferBIN.created:<$i>"

#   ===========================================================================
#   m:  TextFile
#   ===========================================================================

f_lib_menu("TextFile")(__LINE__)

#
#   s:  TXT.create
#

f_lib_menuS1("create.TXT")(__LINE__)

$sFnm   =   'alpha' + '.txt'
$pTxt   =   f_lib_joinPath($sDirTop)($sFnm)
$bRc    =   f_lib_itemCreate($pTxt)($false)($true)
show "fileCreated:<$pTxt>:<$bRc>"

#
#   s:  TXT.write
#

f_lib_menuS1("write.TXT")(__LINE__)

#   choose encoding
#   random

$aEnc = @('ascii','utf8')
if ( $v_hTutor.m_bShellIdPsh__7 ) {         #   !PS7.encoding
    $aEnc += 'ansi'
    $aEnc += 'Windows-1252'
}
$iEnc = Get-Random -Maximum $aEnc.Length    #   0..max-1
$cEnc = $aEnc[$iEnc]
show "using encoding: <'$cEnc'>"

#   write into text File
$i = 0
$iLen = 0

foreach ($x in $aBuffer) {
    $iLen += $x.Length
    if ($i -eq 0) {
        $x | Out-File $pTxt -Encoding $cEnc
    } else {
        $x | Out-File $pTxt -Encoding $cEnc -Append
    }
    $i += 1
}
show "written rec=<$i> len=<$iLen> into: <$pTxt>"

#
#   s:  TXT.read
#

f_lib_menuS1("read.TXT")(__LINE__)

$s = Get-Content $pTxt
$i = $s.Length

show "read rec=<$i> of file:<$pTxt>"

#   fileSize
$iFileSize = f_lib_getFileSize($pTxt)
show "fileSize = <$iFileSize>"
$iKB = f_lib_getFileSize -p_sFilePath $pTxt -o_KB
show "fileSizeKB = <$iKB>"


#   ===========================================================================
#   m:  BinaryFile
#   ===========================================================================

f_lib_menu("BinaryFile")(__LINE__)


#
#   s:  BIN.create
#

f_lib_menuS1("create.BIN")(__LINE__)

#   create.file.alpha
$sFnm   =   'beta' + '.txt'
$pBin   =   f_lib_joinPath($sDirTop)($sFnm)
$bRc    =   f_lib_itemCreate($pBin)($false)($true)
show "fileCreated:<$pBin>:<$bRc>"


#
#   s:  BIN.write
#


f_lib_menuS1("write.BIN")(__LINE__)

#   check buffer length
$iLen = $yBuffer.Length
show "binBuffer.len=<$iLen>"

#   write binary
[io.file]::WriteAllBytes($pBin,$yBuffer)

#   fileSize
$iFileSize = f_lib_getFileSize($pBin)
show "written file.BIN size:<$iFileSize> name:<$pBin>"

#
#   s:  BIN.read
#

f_lib_menu("read.BIN")(__LINE__)

#   read binary
$aTmp = [io.file]::ReadAllBytes($pBin)

#   calc received length
$iLen = $aTmp.Length
show "read.BIN.len=<$iLen> of:<$pBin>"

#   show bin-file content
$i = 0
[int] $iByte = 0
$F = '{0:X2}'
for ($i = 0; $i -lt $iLen; $i ++) {
    $iByte = $aTmp[$i]
    $sByte = [String]::Format($F, $ibyte)
    show "read:[$i]: < $sByte > (H)"
}

#   ===========================================================================
#   m:  FileHandling
#   ===========================================================================

f_lib_menu("FileHandling")(__LINE__)

#
#   s:  Copy-File
#

f_lib_menuS1("copyFile")(__LINE__)

#   new name
$sFnm   =   'gamma' + '.txt'
$pCpy   =   f_lib_joinPath($sDirTop)($sFnm)

#   perform copy
show "copy <$pTxt> => <$pCpy>"
delay(1)
Copy-Item $pTxt $pCpy

#   check FileSize
$iFileSize = f_lib_getFileSize($pCpy)
show "fileSize($pCpy) = <$iFileSize>"

#
#   s:  Remove-File
#

#   new name
$sFnm   =   'delta' + '.txt'
$pRnm   =   f_lib_joinPath($sDirTop)($sFnm)

#   remove rename before if exists
if (Test-Path $pRnm -PathType Leaf) {
    f_lib_menuS1("removeFile")(__LINE__)
    show "remove <$pRnm>"
    delay(1)
    Remove-Item $pRnm
}

#
#   s:  Rename-File
#

f_lib_menuS1("renameFile")(__LINE__)

#   perform rename
show "rename <$pBin> => <$pRnm>"
delay(1)
Rename-Item $pBin $pRnm

#   check FileSize
$iFileSize = f_lib_getFileSize($pRnm)
show "fileSize($pRnm) = <$iFileSize>"


#
#   s:  Move-File
#

f_lib_menuS1("moveFile")(__LINE__)

#   new name for copy and move
$sFnm   =   'epsilon' + '.txt'
$pMov   =   f_lib_joinPath($sDirTop)($sFnm)

#   perform copy_for_move
show "copy_for_move <$pTxt> => <$pMov>"
delay(1)
Copy-Item $pTxt $pMov

#   perform move
$sDir = $script:g_sDirIom
show "move <$pMov> => <$sDir>"
delay(1)
Move-Item $pMov $sDir


#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

#   ***************************************************************************
#   TUTORIAL PowerShell:    chapter::csv                   ###:[2024-11-28]
#   ***************************************************************************

#   encoding.UTF8:
#   @€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üýþÿ

<#
    content:
    •   b:  include
    •   b:  header
        •   m:  csv.write
        •   m:  csv.read
    •   b:  footer
#>

#   b:  include
.   ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name

#
#   b:  function
#

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
} # F~putHash

function F_getObject (
            [string]    $p_sName,
            [bool]      $p_bSex,
            [single]    $p_fSize,
            [int]       $p_iZip )

{
    #   calc any age
    $iAge   = Get-Random -Maximum 100 -Minimum 1     # 1..99

    #   create ordered
    $hPerson = [ordered] @{
        'm_sName'   =   $p_sName
        'm_bSex'   =    $p_bSex
        'm_fSize'   =   $p_fSize
        'm_iAge'    =   $iAge
        'm_iZip'    =   $p_iZip
    }

    #   show Hash
    F_putHash($hPerson)('hPerson')(__LINE__)

    #   make Object
    $pObj = New-Object PSObject -Property $hPerson

    #   return objekt
    return $pObj

} # F~getObject

#
#   b:  header
#

f_lib_header(__LINE__)

#   show content
Write-Host @'
=== :   PSH csv
        m:  csv.write
        m:  csv.read
'@

#   menu
$g_sColor_text  =       $C_sColor_std
$C_sColor_tmp   =       'DarkYellow'
$g_sColor_show  =       'DarkGray'
#   $g_hMenuTabulator['out'] = $g_hMenuTabulator['spc']

#   random
$iRnd = Get-Random -Maximum 16      # 0..n-1
$bRnd = $iRnd % 2 -eq 0             # even

#   fileInfo
$hScp   =   f_lib_hFileMember(__FILE__)
$sBdy   =   $hScp.m_sBdy
$sScpId =   $sBdy.Remove($sBdy.LastIndexOf('_'))

#   create.file.csv
$sFnm   =   $sScpId + '_theta' + '.csv'
$pCsv   =   f_lib_joinPath($g_sDirScratch)($sFnm)
#   $bRc    =   f_lib_itemCreate($pCsv)($false)($true)
#   show "fileCreated:<$pCsv>:<$bRc>"

#   CSV delimiter
$C_CSV_delimiter_ID  = ';'

#   ===========================================================================
#   m:  csv.write
#   ===========================================================================

f_lib_menu("csv.write")(__LINE__)

#   delimiter
$cSep = $C_CSV_delimiter_ID

#   get object an dpush
$pObj = F_getObject('peter')($true)(1.67)(90489)
$pObj | Export-Csv $pCsv -Delimiter $cSep -NoTypeInformation

#   get object an dpush
$pObj = F_getObject('harvey')($true)(0.35)(21262)
$pObj | Export-Csv $pCsv -Delimiter $cSep -NoTypeInformation -Append

#   get object an dpush
$pObj = F_getObject('britney')($false)(1.65)(10100)
$pObj | Export-Csv $pCsv -Delimiter $cSep -NoTypeInformation -Append

#   get object an dpush
$pObj = F_getObject('mary')($false)(1.91)(44123)
$pObj | Export-Csv $pCsv -Delimiter $cSep -NoTypeInformation -Append

#   get object an dpush
$pObj = F_getObject('mike')($false)(1.80)(937484)
$pObj | Export-Csv $pCsv -Delimiter $cSep -NoTypeInformation -Append

#   check fileSize
$iFileSize = f_lib_getFileSize($pCsv)
show "fileSize($pCsv) =: <$iFileSize>"
assert($iFileSize -gt 1)

#   ===========================================================================
#   m:  csv.read
#   ===========================================================================

f_lib_menu("csv.read")(__LINE__)

$iRow = 0
Import-Csv $pCsv -Delimiter $cSep | % `
{
    $iRow   += 1

    $pRow   = $_
    info "row:[$iRow]`t : <$pRow>"

    <#
        Die Header-Zeile wird automatisch als Objekt Typ verwendet !
        Es bedeutet, dass der Aufbau der CSV-Datei bekannt sein muss -
            ein allgemeines Auslesen ist somit nicht m�glich.
    #>

    $sNam   = $_.m_sName
    $bSex   = $_.m_bSex
    $fSiz   = $_.m_fSize
    $iAge   = $_.m_iAge
    $iZip   = $_.m_iZip

    text "row:[$iRow]`t : <$sNam> : <$bSex> : <$fSiz> : <$iAge> : <$iZip> `n"

} # Import-Csv{}

#
#   b:  footer
#

f_lib_footer(__LINE__); exit(-(__LINE__))

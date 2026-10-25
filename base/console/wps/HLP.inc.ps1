#   ###########################################################################
#   helper include for Library Tutorial                         DTM:  241111
#   ###########################################################################

<#  issue:
    converting the 4 environment variables
        $env:v_FWK_mode_bClear      # ? colorMode
        $env:v_FWK_mode_bVerbose      # ? verbose
        $env:v_FWK_mode_bBatch      # ? batchMode
        $env:v_FWK_mode_iLogging      # ? logMode:{1,2}        # logMode
    into proper TUT.inc.ps1 variables
#>

<#
    content:
        m:  parameter
        m:  handle.environment
        m:  run.include.tutorial.Lib
#>

#   ---------------------------------------------------------------------------
#   m:  parameter
#   ---------------------------------------------------------------------------

param(
    [string]    $p__sScp
)

#   ---------------------------------------------------------------------------
#   m:  handle.environment {4}
#   ---------------------------------------------------------------------------

if ( $null -eq $env:v_FWK_mode_bBatch ) {
    $i = 1
    Write-Output "clearScreen in <$i>"; Start-Sleep $i; Clear-Host
}
$bClr  = $false
if ( $env:v_FWK_mode_bClear -eq 'true' )  { $bClr = $true }
$bVbs  = $false
if ( $env:v_FWK_mode_bVerbose -eq 'true' )  { $bVbs = $true }
$iLog = -1
if ( $env:v_FWK_mode_iLogging -eq '1' )  { $iLog = 1 }
if ( $env:v_FWK_mode_iLogging -eq '2' )  { $iLog = 2 }

#   ---------------------------------------------------------------------------
#   m:  run.include.tutorial.Lib
#   ---------------------------------------------------------------------------

.  ".\TUT.inc.ps1"  `
        -p__sScp $p__sScp `
            -p__iLogMode:$iLog `
            -o__bColor:$bClr `
            -o__bVerbose:$bVbs


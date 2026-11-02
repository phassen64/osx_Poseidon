
. ".\HLP.inc.ps1"  -p__sScp $MyInvocation.MyCommand.Name
Write-Host "Hello World" -ForegroundColor 'DarkGreen'


$aColor = ('DarkGreen','DarkYellow','DarkCyan','DarkMagenta','DarkRed','DarkBlue')
$aColor += ('Green','Yellow','Cyan','Magenta','Red','Blue')

$i=0 
foreach ($x in $aColor) {
    $i+=1
    Write-Host "color[$i] = " -NoNewline
    Write-Host "I am {'$x'}." -ForegroundColor $x
}



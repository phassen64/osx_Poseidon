$sPwd   =   Get-Location
$sPth   =   'cfg'
$sFnm   =   'requirements.txt'

pushd $sPth
dir
#   pip list 
pip install -r $sFnm
popd

 

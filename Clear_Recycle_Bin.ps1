#Requires -RunAsAdministrator
$recycleBin = Get-Item -Path "$($env:SystemDrive)\`$Recycle.Bin" 

if ($recycleBin) {
    Remove-Item -Path "$($env:SystemDrive)\`$Recycle.Bin" -Recurse -Force
    Write-Host "Deleted contents of Recycle Bin."
}
else {
    Write-Host "Unable to find Recycle Bin in its usual path. It may have already been deleted in a previous pass. Exiting."
}
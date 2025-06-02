$tempFolders = Get-Item | Where-Object { $_.Special -eq $false -and $_.LocalPath -like "*TEMP*"}


foreach ($folder in $tempFolders) {
    try {
        Remove-Item -Path "$($env:SystemDrive)\$Users\" -Recurse -Force
    }
    catch {
        Write-Host "Failed to delete folder."
    }
}

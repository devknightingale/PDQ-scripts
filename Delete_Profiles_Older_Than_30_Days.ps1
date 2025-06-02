#Requires -RunAsAdministrator
#testing below for continuing the script after it runs into errors
$ErrorActionPreference = 'SilentlyContinue'


# Define the number of days of inactivity
# Ran into issue where "old" profiles still had a last use time of 5/1, technically under the 30 day limit. 
$daysInactive = 14

$deleteCount = 0

# Retrieve all user profiles from the registry
$userProfiles = Get-CimInstance Win32_UserProfile | Where-Object { $_.Special -eq $false -and $_.LocalPath -notlike "*System32*" -and $_.LocalPath -notlike "*TFHC*" -and $_.LocalPath -notlike "*Administrator*" -and $_.LocalPath -notlike "*Public*"}

foreach ($profile in $userProfiles) {
    $file = Get-Item ($profile.LocalPath)
   if ($file.LastWriteTime -gt $daysInactive) {
        Write-Host "Deleting profile: $($profile.LocalPath)" -ForegroundColor Yellow
        try {
            # Delete the profile
            $profile | Remove-CimInstance
            $deleteCount += 1
            Write-Host "Profile deleted successfully: $($profile.LocalPath)" -ForegroundColor Green
            
        } catch {
            Write-Host "Failed to delete profile: $($profile.LocalPath). Error: $_" -ForegroundColor Red
            continue
        }
   }
}
Write-Host "Finished. Deleted $($deleteCount) profiles."
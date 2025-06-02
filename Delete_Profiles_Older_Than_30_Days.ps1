

# Define the number of days of inactivity
# Ran into issue where "old" profiles still had a last use time of 5/1, technically under the 30 day limit. 
$daysInactive = 14

$deleteCount = 0

# Retrieve all user profiles from the registry
# remember to add back the Local Admin account name (removed from this file for privacy purposes)
$userProfiles = Get-CimInstance Win32_UserProfile | Where-Object { $_.Special -eq $false -and $_.LocalPath -notlike "*System32*" -and $_.LocalPath -notlike "*Administrator*" -and $_.LocalPath -notlike "*Public*"}

foreach ($profile in $userProfiles) {
    $file = Get-Item ($profile.LocalPath)
   if ($file.LastWriteTime -gt $daysInactive) {
        Write-Host "Deleting profile: $($profile.LocalPath)" -ForegroundColor Yellow
        try {
            # Delete the profile
            $profile | Remove-CimInstance
            Write-Host "Profile deleted successfully: $($profile.LocalPath)" -ForegroundColor Green
            $deleteCount += 1
        } catch {
            Write-Host "Failed to delete profile: $($profile.LocalPath). Error: $_" -ForegroundColor Red
        }
   }
}
Write-Host "Finished. Deleted $($deleteCount) profiles."
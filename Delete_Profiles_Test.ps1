foreach ($profile in $userProfiles) {

    if ($profile.LocalPath) {
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
    else {
        Write-Host "Something went wrong. Unable to find $($profile)'s local path."
        continue
    }

   }
}
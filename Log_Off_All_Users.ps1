# Get all active user sessions
$query = query user

# Parse the output to extract session IDs
$sessions = $query | ForEach-Object {
    if ($_ -match '\s+(\d+)\s+Active') {
        $matches[1]
    }
}
$loggedOffCount = 0
# Log off each session
foreach ($session in $sessions) {
    try {
        logoff $session
        $loggedOffCount += 1
    }
    catch {
        Write-Host "Failed to log off user."
    }
}
Write-Host "Finished. Logged off $($loggedOffCount) users."
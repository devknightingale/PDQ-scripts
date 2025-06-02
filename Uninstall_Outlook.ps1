
#Requires -RunAsAdministrator 


[bool] $success = 0

# Check to see if Outlook is installed. 
Write-Host "Checking to see if Outlook is installed on the system..."
$outlookIsInstalled = (Get-WmiObject Win32_Product -Filter "Name = 'Outlook'")

# If outlook is installed 
if ($outlookIsInstalled) { 
    # check if Outlook is open 
    Write-Host "Outlook is installed. Checking if currently open... "
    $outlookOpen = Get-Process | Where-Object {$_.Name -like "*Outlook*"}
    
    # if Outlook is currently open, force it to close 
    if ($outlookOpen) {
        Write-Host "Outlook is currently in use. Attempting to force the application to close..."
        Stop-Process -Name "$($outlookOpen)"
    }

    # Finally, uninstall Outlook. 
    Write-Host "Uninstalling Outlook..."
    Try { 
        $outlookIsInstalled.Uninstall()
        Write-Host "Successfully uninstalled Outlook."
        $success = 1   
        # TODO: Find a way to mark "Reboot Required" on the system once this step is completed. 
    }
    catch {
        Write-Host "Failed to uninstall Outlook."
    }
        # TODO: Clean up any remaining .ost files in Local\Microsoft - have to loop through all profiles
}


if ($success -eq 1) {
    Write-Host "Script completed successfully. Outlook has been uninstalled from the system."
}
else {
    if ($outlookIsInstalled) {
        Write-Host "Script was not able to uninstall Outlook. Review the log for more details."
    }
    Write-Host "Outlook was not found on the system. No further action required."
    
}





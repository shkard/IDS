$continueRunning = $true
$diskActivityThreshold = 50 # Procentowy próg aktywności dysku

while ($continueRunning) {
    
	$disks = Get-CimInstance -Class Win32_PerfFormattedData_PerfDisk_LogicalDisk

	foreach ($disk in $disks) {
		if ($disk.Name -ne "_Total") {
			$diskActivity = $disk.PercentDiskTime

			# Ogranicz wartość do 100%
			if ($diskActivity -gt 100) {
				$diskActivity = 100
			}

			if ($diskActivity -gt $diskActivityThreshold) {
				Write-Host "Aktywność dysku $($disk.Name) przekroczyła próg: $diskActivity%"
			}
		}
	}

	Start-Sleep -Seconds 1

    # Sprawdź, czy użytkownik chce zakończyć pętlę
    Write-Host "Naciśnij Q, aby zakończyć pętlę"
    $input = & choice /C YNQ /T 3 /D Y /N
    if ($input -eq 'Q') {
        $continueRunning = $false
    }
}
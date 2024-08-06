# Monitorowanie użycia pamięci
$continueRunning = $true
$memoryUsageThreshold = 50 # Procentowy próg użycia pamięci

while ($continueRunning) {
	$os = Get-CimInstance -Class Win32_PerfFormattedData_PerfOS_Memory

	$memoryUsage = $os.PercentCommittedBytesInUse

	if ($memoryUsage -gt $memoryUsageThreshold) {
		Write-Host "Użycie pamięci przekroczyło próg: $memoryUsage%"

        # Pobierz proces, który zużywa najwięcej pamięci
        $topProcess = Get-Process | Sort-Object WS -Descending | Select-Object -First 1

        Write-Host "Proces zużywający najwięcej pamięci: $($topProcess.Name)"
        Write-Host "PID procesu: $($topProcess.Id)"
	}

	Start-Sleep -Seconds 5
    # Sprawdź, czy użytkownik chce zakończyć pętlę
    Write-Host "Naciśnij Q, aby zakończyć pętlę"
    $input = & choice /C YNQ /T 3 /D Y /N
    if ($input -eq 'Q') {
        $continueRunning = $false
    }
}

#komentarz
$continueRunning = $true
$cpuUsageThreshold = 5 # Procentowy próg użycia CPU

while ($continueRunning) {
    $cpuUsage = (Get-CimInstance -Class Win32_Processor).LoadPercentage

    if ($cpuUsage -gt $cpuUsageThreshold) {
        Write-Host "Użycie CPU przekroczyło próg: $cpuUsage%"

        # Pobierz proces, który zużywa najwięcej CPU
        $topCpuProcess = Get-Process | Sort-Object CPU -Descending | Select-Object -First 1

        # Aktualizuj informacje o procesie, który zużywa najwięcej CPU
        $topCpuProcess = Get-Process -Id $topCpuProcess.Id

        Write-Host "Proces zużywający najwięcej CPU: $($topCpuProcess.Name)"
        Write-Host "PID procesu: $($topCpuProcess.Id)"
    }

    Start-Sleep -Seconds 1

    # Sprawdź, czy użytkownik chce zakończyć pętlę
    Write-Host "Naciśnij Q, aby zakończyć pętlę"
    $input = & choice /C YNQ /T 3 /D Y /N
    if ($input -eq 'Q') {
        $continueRunning = $false
    }
}
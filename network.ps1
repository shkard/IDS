# Monitorowanie połączeń sieciowych
$continueRunning = $true


while ($continueRunning) {
	$connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }

	foreach ($connection in $connections) {
		Write-Host "Ustanowiono połączenie sieciowe: $($connection.LocalAddress):$($connection.LocalPort) -> $($connection.RemoteAddress):$($connection.RemotePort)"
	}
	Start-Sleep -Seconds 5
    # Sprawdź, czy użytkownik chce zakończyć pętlę
    Write-Host "Naciśnij Q, aby zakończyć pętlę"
    $input = & choice /C YNQ /T 3 /D Y /N
    if ($input -eq 'Q') {
        $continueRunning = $false
    }
}
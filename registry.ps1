$registryPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' # Ścieżka do monitorowanego klucza rejestru
$continueRunning = $true


while ($continueRunning) {
	$query = "SELECT * FROM RegistryKeyChangeEvent WHERE Hive = 'HKEY_LOCAL_MACHINE' AND KeyPath = 'SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run'"

	$onChanged = Register-CimIndicationEvent -Query $query -Namespace 'root\default' -QueryDialect WQL -Action {
	Write-Host "Wykryto zmianę w rejestrze: $registryPath"
	}
	
	Start-Sleep -Seconds 1
    # Sprawdź, czy użytkownik chce zakończyć pętlę
    Write-Host "Naciśnij Q, aby zakończyć pętlę"
    $input = & choice /C YNQ /T 3 /D Y /N
    if ($input -eq 'Q') {
        $continueRunning = $false
    }
}

###komentarz
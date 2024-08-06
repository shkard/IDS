$continueRunning = $true
try {
    # 1. Monitorowanie zmian w plikach
    $folder = 'D:\Telepliki 17-18\Telepliki 17-18\6 semestr 2024\Kolo naukowe\project' # Ścieżka do monitorowanego folderu
    $filter = '*.*' # Typy plików do monitorowania

    $fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
        IncludeSubdirectories = $true
        NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
    }

    $onChanged = Register-ObjectEvent $fsw Changed -SourceIdentifier FileChanged -Action {
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
        Write-Host "Plik '$name' został $changeType o $timeStamp"
    }

    # 2. Monitorowanie aktywności procesów
    $query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process'"
    $namespace = 'root\CIMv2'
    $action = {
        $name = $Event.SourceEventArgs.NewEvent.TargetInstance.Name
        $pid = $Event.SourceEventArgs.NewEvent.TargetInstance.ProcessId
        Write-Host "Nowy proces został uruchomiony: $name (PID: $pid)"
    }
	
	Register-CimIndicationEvent -Query $query -Namespace $namespace -SourceIdentifier ProcessMonitor -Action $action

    # Poczekaj na zakończenie działania
    while ($continueRunning) {
		Start-Sleep -Seconds 1

        # Sprawdź, czy użytkownik chce zakończyć pętlę
        Write-Host "Naciśnij Q, aby zakończyć pętlę"
        $input = & choice /C YNQ /T 3 /D Y /N
        if ($input -eq 'Q') {
            $continueRunning = $false
        }
	}
}
finally {
    # Usunięcie identyfikatorów zdarzeń
    Unregister-Event -SourceIdentifier FileChanged -Force
	Unregister-Event -SourceIdentifier ProcessMonitor -Force
}

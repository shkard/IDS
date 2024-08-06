while ($true) {
    Clear-Host
    Write-Host "1: Uruchom cpu.ps1"
    Write-Host "2: Uruchom disk.ps1"
    Write-Host "3: Uruchom file_proccess.ps1"
    Write-Host "4: Uruchom network.ps1"
    Write-Host "5: Uruchom ram.ps1"
    Write-Host "6: Uruchom registry.ps1"
    Write-Host "7: Wyjdź"

    $input = Read-Host "Wybierz numer skryptu do uruchomienia"
    switch ($input) {
        '1' { .\cpu.ps1; pause }
        '2' { .\disk.ps1; pause }
        '3' { .\file_proccess.ps1; pause }
        '4' { .\network.ps1; pause }
        '5' { .\ram.ps1; pause }
        '6' { .\registry.ps1; pause }
        '7' { exit }
        default { Write-Host "Nieznany wybór"; pause }
    }
}

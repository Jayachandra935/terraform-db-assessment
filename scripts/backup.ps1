$BackupDir = ".\backups"

New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

$backupFile = "$BackupDir\hotelbooking_$timestamp.sql"

docker exec hotel-postgres pg_dump `
    -U postgres `
    hotelbooking > $backupFile

Write-Host "Backup created successfully:"
Write-Host $backupFile
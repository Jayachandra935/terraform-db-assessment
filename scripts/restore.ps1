$latestBackup = Get-ChildItem .\backups\*.sql |
Sort-Object LastWriteTime -Descending |
Select-Object -First 1

docker exec hotel-postgres psql -U postgres -d hotelbooking -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

Get-Content $latestBackup.FullName |
docker exec -i hotel-postgres psql -U postgres -d hotelbooking

Write-Host "Restore completed successfully from:"
Write-Host $latestBackup.Name
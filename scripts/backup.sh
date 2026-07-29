#!/bin/bash

BACKUP_DIR=./backups

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/hotelbooking_$TIMESTAMP.sql"

docker exec hotel-postgres \
pg_dump -U postgres hotelbooking \
> "$BACKUP_FILE"

echo "Backup created successfully:"
echo "$BACKUP_FILE"
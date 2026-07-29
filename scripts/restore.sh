#!/bin/bash

LATEST=$(ls -t ./backups/*.sql | head -1)

docker exec -i hotel-postgres \
psql -U postgres hotelbooking \
< "$LATEST"

echo "Restore completed:"
echo "$LATEST"
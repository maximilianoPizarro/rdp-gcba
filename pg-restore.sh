#!/usr/bin/env bash
cd /db
export DATABASE_URL="$DATABASE_URL"
echo "pg restore"
pg_restore DATABASE_URL -f base_infraesctructura.backup
echo "importado"

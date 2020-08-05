#!/usr/bin/env bash
cd /basedatos
chmod +x basedatos

export DATABASE_URL="$DATABASE_URL"
echo "pg restore"
pg_restore DATABASE_URL -f base_infraesctructura.backup
echo "importado"

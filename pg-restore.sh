#!/usr/bin/env bash
cd /db
echo "pg restore"
pg_restore -d $DATABASE_URL base_infraesctructura.backup
echo "importado"

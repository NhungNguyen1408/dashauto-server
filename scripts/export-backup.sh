#!/bin/bash
# Export backup: Postgres dump + n8n data volume
# Chay tu thu muc dashauto-server/:
#   bash scripts/export-backup.sh

set -e

# Ve root cua dashauto-server/
cd "$(dirname "$0")/.."

BACKUP_DIR="backup"
mkdir -p "$BACKUP_DIR"

if ! docker ps --format '{{.Names}}' | grep -q "^dashauto-postgres$"; then
  echo "ERROR: Container dashauto-postgres chua chay. Chay 'docker compose up -d' truoc."
  exit 1
fi

echo "[1/2] Backup Postgres..."
docker exec dashauto-postgres pg_dump -U dashauto -d dashauto_db > "$BACKUP_DIR/postgres.sql"
echo "  -> $BACKUP_DIR/postgres.sql ($(du -h $BACKUP_DIR/postgres.sql | cut -f1))"

echo ""
echo "[2/2] Backup n8n data volume..."
MSYS_NO_PATHCONV=1 docker run --rm \
  -v dashauto-server_dashauto_n8n:/data \
  alpine \
  tar czf - -C /data . > "$BACKUP_DIR/n8n-data.tar.gz"
echo "  -> $BACKUP_DIR/n8n-data.tar.gz ($(du -h $BACKUP_DIR/n8n-data.tar.gz | cut -f1))"

echo ""
echo "Done. Files:"
ls -lh "$BACKUP_DIR/"

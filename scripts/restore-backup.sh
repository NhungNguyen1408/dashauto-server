#!/bin/bash
# Restore backup: Postgres dump + n8n data volume
# Chay tu thu muc dashauto-server/:
#   bash scripts/restore-backup.sh

set -e

# Ve root cua dashauto-server/
cd "$(dirname "$0")/.."

BACKUP_DIR="backup"

if [ ! -f "$BACKUP_DIR/postgres.sql" ] || [ ! -f "$BACKUP_DIR/n8n-data.tar.gz" ]; then
  echo "ERROR: Thieu file backup trong $BACKUP_DIR/"
  echo "Can co: postgres.sql va n8n-data.tar.gz"
  exit 1
fi

echo "[1/3] Dung containers hien tai + xoa volume cu..."
docker compose down -v

echo ""
echo "[2/3] Restore n8n volume..."
docker volume create dashauto-server_dashauto_n8n > /dev/null
MSYS_NO_PATHCONV=1 docker run --rm -i \
  -v dashauto-server_dashauto_n8n:/data \
  alpine \
  tar xzf - -C /data < "$BACKUP_DIR/n8n-data.tar.gz"
echo "  -> n8n volume restored"

echo ""
echo "[3/3] Khoi dong containers + restore Postgres..."
docker compose up -d
echo "  Doi Postgres san sang..."
sleep 12

docker exec -i dashauto-postgres psql -U dashauto -d dashauto_db < "$BACKUP_DIR/postgres.sql" > /dev/null 2>&1
echo "  -> Postgres restored tu $BACKUP_DIR/postgres.sql"

echo ""
echo "Done. Kiem tra:"
echo "  - http://localhost:5678  (n8n - login bang tai khoan owner cu)"
echo "  - http://localhost:5173  (frontend - login bang user cu)"

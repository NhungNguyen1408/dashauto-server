#!/bin/bash
# Quick start: setup dashauto-server tren may moi
# Chay tu thu muc dashauto-server/:
#   bash scripts/quick-start.sh

set -e

# Ve root cua dashauto-server/
cd "$(dirname "$0")/.."

echo "================================="
echo "DashAuto Server - Quick Start"
echo "================================="
echo ""

if ! command -v docker &> /dev/null; then
  echo "ERROR: Docker chua cai. Download tu https://www.docker.com/products/docker-desktop"
  exit 1
fi

if ! docker info > /dev/null 2>&1; then
  echo "ERROR: Docker Desktop chua chay. Mo Docker Desktop truoc roi chay lai."
  exit 1
fi

if ! command -v node &> /dev/null; then
  echo "ERROR: Node.js chua cai. Download tu https://nodejs.org (v20+)"
  exit 1
fi

echo "Docker: $(docker --version)"
echo "Node:   $(node --version)"
echo ""

if [ ! -f ".env" ]; then
  echo "[1] Tao .env tu .env.example..."
  cp .env.example .env
else
  echo "[1] .env da ton tai, bo qua"
fi

echo ""
echo "[2] Khoi dong Docker containers (Postgres + n8n)..."
docker compose up -d
echo "  Doi containers san sang..."
sleep 10

if [ -f "backup/postgres.sql" ] && [ -f "backup/n8n-data.tar.gz" ]; then
  echo ""
  echo "[3] Phat hien file backup (postgres.sql + n8n-data.tar.gz)"
  echo "    Ban muon restore state tu backup khong?"
  echo "    (y = restore, n = migrate + seed data mau)"
  read -p "    Lua chon [y/n]: " answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo ""
    echo "    Dang restore..."
    bash scripts/restore-backup.sh
    echo ""
    echo "[3b] Cai dependencies backend..."
    npm install
  else
    echo ""
    echo "[3b] Cai dependencies + migrate + seed..."
    npm install
    npm run migrate
    npm run seed
  fi
else
  echo ""
  echo "[3] Khong co backup - cai dependencies + migrate + seed data mau..."
  npm install
  npm run migrate
  npm run seed
fi

if [ -d "../dashauto-client" ]; then
  echo ""
  echo "[4] Phat hien ../dashauto-client/ - cai dependencies Frontend..."
  cd ../dashauto-client
  if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
  fi
  npm install
  cd - > /dev/null
else
  echo ""
  echo "[4] Khong thay ../dashauto-client/ - bo qua Frontend"
  echo "    Clone dashauto-client vao cung thu muc cha neu can"
fi

echo ""
echo "================================="
echo "Setup xong!"
echo "================================="
echo ""
echo "Chay Backend (terminal hien tai):"
echo "  npm run dev"
echo ""
if [ -d "../dashauto-client" ]; then
  echo "Chay Frontend (terminal khac):"
  echo "  cd ../dashauto-client && npm run dev"
  echo ""
fi
echo "URLs:"
echo "  http://localhost:5173  - Frontend"
echo "  http://localhost:5678  - n8n"
echo "  http://localhost:5000  - Backend health"

# DashAuto — Tài liệu dự án

Đây là bộ tài liệu đầy đủ cho dự án **DashAuto** — dashboard quản lý doanh nghiệp tích hợp tự động hoá n8n.

## Đọc theo thứ tự

| # | File | Nội dung | Dành cho |
|---|---|---|---|
| 00 | [Overview](00-overview.md) | Tổng quan dự án, 4 thành phần | Người mới, xem trước |
| 01 | [Architecture](01-architecture.md) | Sơ đồ, luồng dữ liệu, networking | Hiểu kiến trúc |
| 02 | [Setup](02-setup.md) | Cài từ zero, chạy dự án | Người mới clone về |
| 03 | [Docker Compose](03-docker-compose.md) | Docker, network, volume | Hiểu DevOps |
| 04 | [Database](04-database.md) | Schema, migration, seed | Backend dev |
| 05 | [Backend](05-backend.md) | Express, JWT, API pattern | Backend dev |
| 06 | [Frontend](06-frontend.md) | React, routing, charts | Frontend dev |
| 07 | [n8n Integration](07-n8n-integration.md) | n8n là gì, tại sao dùng | Hiểu automation |
| 08 | [n8n Workflows](08-n8n-workflows.md) | Hướng dẫn tạo workflow | Nhung + demo |
| 09 | [Troubleshooting](09-troubleshooting.md) | Lỗi thường gặp + fix | Khi bí |

## Quick Start

Nếu chỉ cần chạy dự án ngay:

```bash
# 1. Start containers
cd dashauto-server
docker compose up -d

# 2. Backend
npm install
npm run migrate
npm run seed
npm run dev

# 3. Frontend (terminal khác)
cd dashauto-client
npm install
npm run dev

# 4. Mở browser
# http://localhost:5173  - Frontend
# http://localhost:5678  - n8n (tạo owner account lần đầu)
```

## Tech stack tóm tắt

- **Frontend**: React 19, Vite, React Router v7, Axios, Recharts
- **Backend**: Node.js 20+, Express 5, JWT, bcryptjs, pg
- **Database**: PostgreSQL 16
- **Automation**: n8n (Docker)
- **Infra**: Docker Compose



```
c:/Tuan/Nhung/
├── dashauto-client/     # Frontend
├── dashauto-server/     # Backend + Docker
└── docs/                # Tài liệu này
```

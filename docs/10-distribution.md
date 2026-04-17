# 10 — Đóng gói & Phân phối

Hướng dẫn đóng gói dự án để đưa cho người khác chạy trên máy khác.

## 1. Cách tiếp cận

**Không** đóng gói dưới dạng Docker image export (quá lớn, phức tạp). Thay vào đó:

1. Đóng gói **source code** + **file backup DB** + **file backup n8n**
2. Người nhận cần cài: Docker Desktop + Node.js (chỉ 2 thứ)
3. Chạy script `quick-start.sh` → tự động setup

Tổng dung lượng: ~1-2 MB (không node_modules) hoặc ~300 MB (có node_modules).

## 2. Cấu trúc thư mục đóng gói

```
dashauto/
├── dashauto-client/      # Frontend source
├── dashauto-server/      # Backend source + docker-compose.yml
├── backup/               # ★ File backup (được tạo bởi export-backup.sh)
│   ├── postgres.sql      # DB dump (~60KB)
│   └── n8n-data.tar.gz   # n8n state (~900KB)
├── docs/                 # Tài liệu
├── scripts/              # Script tự động
│   ├── export-backup.sh
│   ├── restore-backup.sh
│   └── quick-start.sh
└── README.md
```

## 3. Bên gửi — trước khi đóng gói

### 3.1 Tạo backup từ máy đang chạy

Đảm bảo Docker Desktop đang chạy + 2 container `dashauto-postgres`, `dashauto-n8n` đang `Up`.

```bash
cd c:/Tuan/Nhung
bash scripts/export-backup.sh
```

Sẽ tạo:
- `backup/postgres.sql` — dump toàn bộ DB (users, orders, alerts, workflow_logs + cả bảng của n8n)
- `backup/n8n-data.tar.gz` — volume n8n (credentials, config, encryption keys)

### 3.2 Xoá thư mục không cần

```bash
# Xoá node_modules (sẽ cài lại bên nhận)
rm -rf dashauto-client/node_modules
rm -rf dashauto-server/node_modules

# Xoá dist build nếu có
rm -rf dashauto-client/dist

# Xoá .git nếu không muốn share history
# rm -rf dashauto-server/.git  (nếu có)
```

### 3.3 Zip cả thư mục

Windows Explorer: chuột phải `c:/Tuan/Nhung/` → "Send to" → "Compressed (zipped) folder"  
Hoặc:

```bash
cd c:/Tuan/
# Dùng 7zip hoặc tar
tar czf dashauto.tar.gz Nhung/
# Hoac zip
powershell "Compress-Archive -Path Nhung -DestinationPath dashauto.zip"
```

Kết quả: file `dashauto.zip` khoảng 1-2 MB.

### 3.4 Gửi

Send file qua Google Drive, OneDrive, email, USB...

## 4. Bên nhận — setup trên máy khác

### 4.1 Yêu cầu cài trước

1. **Docker Desktop** — https://www.docker.com/products/docker-desktop  
   (Cài xong nhớ khởi động lại máy nếu được yêu cầu)

2. **Node.js 20+** — https://nodejs.org  
   Chọn LTS

3. **Git Bash** (để chạy script .sh trên Windows) — có sẵn khi cài Git

4. Kiểm tra:
   ```bash
   docker --version
   node --version
   ```

### 4.2 Giải nén

Giải nén `dashauto.zip` vào thư mục bất kỳ, ví dụ `C:/Projects/dashauto/`.

### 4.3 Khởi động Docker Desktop

Mở Docker Desktop, đợi icon whale không còn nhấp nháy.

### 4.4 Chạy quick-start

Mở Git Bash trong thư mục vừa giải nén:

```bash
cd /c/Projects/dashauto   # hoặc path tùy bạn
bash scripts/quick-start.sh
```

Script sẽ:
1. Kiểm tra Docker, Node đã cài
2. Tạo `.env` từ `.env.example`
3. Chạy `docker compose up -d` (tải image + start containers)
4. Phát hiện có backup → hỏi có restore không (**chọn `y`**)
5. Restore DB + n8n state
6. Cài `npm install` Backend
7. Cài `npm install` Frontend

Mất 5-10 phút tuỳ tốc độ mạng (tải image Docker ~1GB).

### 4.5 Chạy Backend + Frontend

Mở 2 Git Bash terminal:

```bash
# Terminal 1 — Backend
cd dashauto-server
npm run dev
```

```bash
# Terminal 2 — Frontend
cd dashauto-client
npm run dev
```

### 4.6 Truy cập

- http://localhost:5173 — Frontend (login với user bạn đã tạo trước khi backup)
- http://localhost:5678 — n8n (login với tài khoản owner bạn đã tạo trước khi backup)

⚠️ Login **dùng tài khoản của bên gửi** vì DB được restore y nguyên. Nếu cần tạo user mới, vào `/register` trên frontend hoặc `/` trên n8n (nếu chưa có owner).

## 5. Scripts giải thích

### 5.1 `scripts/export-backup.sh`

```bash
docker exec dashauto-postgres pg_dump -U dashauto -d dashauto_db > backup/postgres.sql

MSYS_NO_PATHCONV=1 docker run --rm \
  -v dashauto-server_dashauto_n8n:/data \
  alpine \
  tar czf - -C /data . > backup/n8n-data.tar.gz
```

- `pg_dump` xuất toàn bộ schema + data ra SQL
- Tar n8n volume bằng container alpine tạm, output qua stdout để tránh path conversion issue của Git Bash

### 5.2 `scripts/restore-backup.sh`

```bash
# 1. Xoá volume cũ
cd dashauto-server
docker compose down -v

# 2. Tạo volume mới + extract tar vào
docker volume create dashauto-server_dashauto_n8n
MSYS_NO_PATHCONV=1 docker run --rm -i \
  -v dashauto-server_dashauto_n8n:/data \
  alpine \
  tar xzf - -C /data < backup/n8n-data.tar.gz

# 3. Start containers + restore SQL
docker compose up -d
sleep 10
docker exec -i dashauto-postgres psql -U dashauto -d dashauto_db < backup/postgres.sql
```

### 5.3 `scripts/quick-start.sh`

Logic chính:
- Check Docker + Node
- Tạo `.env` nếu chưa có
- Start containers
- Nếu có backup → hỏi restore (y/n)
- Nếu không có backup hoặc user từ chối → migrate + seed
- `npm install` cho cả 2 project

## 6. Vấn đề hay gặp khi phân phối

### 6.1 Người nhận không có Docker Desktop

→ Link tải + hướng dẫn. Docker Desktop yêu cầu Windows 10+ Pro hoặc Home có WSL2.

### 6.2 Người nhận ở khác múi giờ

Timestamp trong DB là UTC, Frontend tự convert. Không ảnh hưởng.

### 6.3 Port xung đột

Máy nhận đã có service chạy trên port 5432 (Postgres local), 5000, 5173, 5678 → sửa `docker-compose.yml` + `.env`:

Ví dụ đổi DB_PORT 5432 → 5433:
```yaml
# docker-compose.yml
ports:
  - "5433:5432"
```
```env
# .env
DB_PORT=5433
```

### 6.4 Windows Defender block script

Nếu Windows chặn `.sh`:
- Chạy Git Bash "as Administrator"
- Hoặc unzip ở thư mục thân thiện (Documents, Downloads, không phải `Program Files`)

### 6.5 `MSYS_NO_PATHCONV` là gì

Git Bash trên Windows mặc định convert path Unix `/data` → Windows `C:/.../data` khi truyền vào `.exe` (kể cả `docker.exe`). Variable này tắt auto convert, giữ nguyên `/data`.

### 6.6 Không restore được

Lỗi thường gặp + fix xem [09-troubleshooting.md](09-troubleshooting.md) mục 1-3.

## 7. Đóng gói KHÔNG kèm backup (clean state)

Nếu bạn muốn người nhận **tự tạo data từ đầu**:

### 7.1 Bên gửi
Xoá hoặc không tạo thư mục `backup/`.

### 7.2 Bên nhận
`quick-start.sh` không thấy backup → tự động chạy `npm run migrate && npm run seed` (data mẫu).

n8n bên nhận sẽ yêu cầu tạo owner account mới (không có workflow cũ).

## 8. So sánh 2 cách

| Cách | Ưu | Nhược |
|---|---|---|
| **Có backup** | Bên nhận thấy đúng data/workflow như bên gửi, demo ngay được | File lớn hơn (thêm 1MB), phụ thuộc phiên bản PG/n8n |
| **Không backup** | Sạch sẽ, data seed mặc định | Bên nhận phải tự tạo workflow n8n lại |

Đồ án demo → nên có backup.

## 9. Export workflow n8n riêng (tuỳ chọn)

Ngoài backup volume, có thể export từng workflow n8n thành JSON để commit vào git:

1. Mở workflow trong n8n UI
2. Menu `...` góc phải → **Download**
3. Lưu vào `backup/workflows/cron_heartbeat.json`, etc.

Bên nhận import: menu `...` → **Import from File** → chọn JSON.

Lợi ích:
- Xem workflow JSON diff trong git
- Không cần nguyên volume (backup nhẹ hơn)

Nhược:
- Credential không nằm trong JSON → phải tạo lại

## 10. Checklist đóng gói

- [ ] Chạy `bash scripts/export-backup.sh` trước khi zip
- [ ] Kiểm tra thấy `backup/postgres.sql` + `backup/n8n-data.tar.gz`
- [ ] Xoá `node_modules` của cả 2 project
- [ ] Test zip: thử giải nén ở thư mục khác, chạy `quick-start.sh` xem có lỗi không
- [ ] Gửi kèm hướng dẫn: chỉ cần cài Docker + Node rồi chạy `bash scripts/quick-start.sh`
- [ ] File docs/ đã đầy đủ trong zip

## 11. One-liner setup cho người nhận

Trong email/chat gửi kèm zip, có thể viết ngắn gọn:

> Giải nén ra → cài Docker Desktop + Node.js → mở Git Bash ở thư mục giải nén → chạy:
> ```bash
> bash scripts/quick-start.sh
> ```
> Sau đó mở 2 terminal, chạy `npm run dev` trong `dashauto-server` và `dashauto-client`. Truy cập http://localhost:5173.

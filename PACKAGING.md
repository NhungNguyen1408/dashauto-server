# Hướng dẫn đóng gói & sử dụng trên máy khác

Tài liệu này cho 2 bên:
- **Bên gửi**: người đóng gói dự án để share (thường là bạn)
- **Bên nhận**: người dùng dự án trên máy mới (classmate, giảng viên, bạn khi chuyển máy)

---

## PHẦN A — BÊN GỬI (đóng gói)

### A.1 Khi nào đóng gói?

- Muốn share với bạn cùng nhóm
- Muốn demo cho giảng viên
- Chuyển sang máy khác (laptop → desktop)
- Backup định kỳ phòng mất dữ liệu

### A.2 Trước khi đóng gói

Đảm bảo:
- Docker Desktop đang chạy
- 2 container `dashauto-postgres` + `dashauto-n8n` đang `Up` (kiểm tra: `docker ps`)
- Các workflow n8n bạn muốn share đã được **Published** và đã test chạy OK
- Frontend + Backend chạy được bình thường

### A.3 Chạy script backup

Mở **Git Bash** trong thư mục `dashauto-server/`:

```bash
bash scripts/export-backup.sh
```

Script sẽ tạo 2 file:

```
dashauto-server/
└── backup/
    ├── postgres.sql       (~60KB)  Toàn bộ DB
    └── n8n-data.tar.gz    (~900KB) State n8n
```

> ⚠️ **Mỗi lần có thay đổi data/workflow** → chạy lại `export-backup.sh` để backup mới nhất.

### A.4 Push lên GitHub

Vì `backup/` không nằm trong `.gitignore`, nó sẽ được commit cùng code:

```bash
cd dashauto-server
git add backup/ docs/ scripts/ PACKAGING.md
git add src/ index.js package.json package-lock.json docker-compose.yml .env.example .gitignore
git commit -m "chore: package backup + docs + scripts for distribution"
git push origin main
```

> Không commit `.env` (chứa secret). File `.env.example` có sẵn cho người nhận.

### A.5 Dashboard Frontend (dashauto-client) — repo riêng

Frontend là repo GitHub riêng. Người nhận cần clone cả 2 repo:

```
some-folder/
├── dashauto-server/   (clone từ repo này)
└── dashauto-client/   (clone từ repo Frontend)
```

Gửi cả 2 link GitHub cho người nhận.

---

## PHẦN B — BÊN NHẬN (setup trên máy mới)

### B.1 Cài phần mềm cần thiết (1 lần)

| Phần mềm | Link | Chú ý |
|---|---|---|
| **Docker Desktop** | https://www.docker.com/products/docker-desktop | Windows cần WSL2 hoặc Hyper-V. Cài xong restart máy nếu được yêu cầu |
| **Node.js 20+** | https://nodejs.org | Chọn bản LTS |
| **Git** | https://git-scm.com | Có Git Bash đi kèm trên Windows |
| **pgAdmin 4** *(tuỳ chọn)* | https://www.pgadmin.org | Để xem DB trực quan |

Kiểm tra sau khi cài:

```bash
docker --version
node --version
git --version
```

### B.2 Clone 2 repo

```bash
cd /c/Projects   # hoặc thư mục bạn muốn
git clone <URL-repo-dashauto-server>
git clone <URL-repo-dashauto-client>
```

Cấu trúc sau khi clone:

```
C:/Projects/
├── dashauto-server/
└── dashauto-client/
```

### B.3 Khởi động Docker Desktop

Mở Docker Desktop. Đợi icon cá voi **ngừng nhấp nháy** (2-3 phút tuỳ máy).

### B.4 Chạy quick-start

Mở **Git Bash** trong `dashauto-server/`:

```bash
cd /c/Projects/dashauto-server
bash scripts/quick-start.sh
```

Script sẽ hỏi nhiều bước:

1. ✅ Check Docker + Node đã cài
2. Tạo `.env` từ `.env.example`
3. Tải image Docker + start container (mất 5-10 phút lần đầu)
4. **Phát hiện backup** → hỏi `[y/n]`:
   - Chọn **`y`** → restore DB + n8n state của bên gửi (khuyên chọn cái này)
   - Chọn **`n`** → chạy migrate + seed data mẫu (state sạch, không có workflow nào)
5. Cài `npm install` Backend
6. Phát hiện `../dashauto-client/` → cài `npm install` Frontend

Tổng thời gian lần đầu: ~10 phút (chủ yếu chờ tải Docker image).

### B.5 Chạy Backend + Frontend

Mở 2 cửa sổ terminal (Git Bash / PowerShell / CMD đều được):

**Terminal 1 — Backend**:
```bash
cd /c/Projects/dashauto-server
npm run dev
```

Thấy:
```
DB connected at ...
Server running on port 5000 [development]
```

**Terminal 2 — Frontend**:
```bash
cd /c/Projects/dashauto-client
npm run dev
```

Thấy:
```
VITE v8.x  ready in 300ms
➜  Local: http://localhost:5173/
```

### B.6 Truy cập + login

| URL | Mô tả |
|---|---|
| http://localhost:5173 | Frontend dashboard |
| http://localhost:5678 | n8n |
| http://localhost:5000 | Backend health |

#### Nếu chọn restore backup (B.4 bước 4 = y)

- **Frontend**: login bằng username/password mà bên gửi đã tạo (hỏi bên gửi)
- **n8n**: login bằng email/password owner account của bên gửi (hỏi bên gửi)
- Tất cả workflow, alert, log, v.v. y nguyên như máy bên gửi

#### Nếu chọn không restore (B.4 bước 4 = n)

- **Frontend**: chưa có user → vào `/register` tạo tài khoản
- **n8n**: chưa có owner → form setup sẽ hiện khi mở `localhost:5678`, tự tạo
- Không có workflow nào → tự tạo theo hướng dẫn `docs/08-n8n-workflows.md`

### B.7 Tắt hệ thống

Khi xong việc:

```bash
# Terminal Backend + Frontend: Ctrl+C
# Dừng Docker containers:
cd dashauto-server
docker compose down
```

Data vẫn được giữ trong Docker volume (không mất).

Lần sau chạy lại chỉ cần:

```bash
cd dashauto-server && docker compose up -d && npm run dev
# Terminal khác:
cd dashauto-client && npm run dev
```

---

## PHẦN C — CÂU HỎI THƯỜNG GẶP

### C.1 Máy nhận đã cài Postgres local, port 5432 bị trùng?

Sửa trong `dashauto-server/.env`:
```env
DB_PORT=5433
```

Và `dashauto-server/docker-compose.yml`:
```yaml
ports:
  - "5433:5432"
```

Sau đó `docker compose up -d`.

### C.2 Làm lại từ đầu (xoá data)

```bash
cd dashauto-server
docker compose down -v    # -v xoá volume = xoá data
bash scripts/quick-start.sh
```

### C.3 Backup ở bên gửi nhưng bên nhận muốn update data mới

Bên gửi `bash scripts/export-backup.sh` → commit push → bên nhận `git pull` → `bash scripts/restore-backup.sh`.

### C.4 File backup bị lớn có nên gzip thêm?

`n8n-data.tar.gz` đã được gzip. `postgres.sql` là text — có thể gzip thêm nếu rất lớn, nhưng với 60KB không cần.

### C.5 Bên nhận không có Git Bash (Mac/Linux)?

Script `.sh` chạy được trực tiếp trên Mac/Linux. Chỉ cần:
```bash
chmod +x scripts/*.sh
./scripts/quick-start.sh
```

Riêng `MSYS_NO_PATHCONV=1` chỉ có tác dụng trên Git Bash Windows, trên Mac/Linux không ảnh hưởng.

### C.6 Nếu chỉ muốn share workflow n8n (không share data)

Bỏ qua `backup/postgres.sql`, chỉ giữ `n8n-data.tar.gz`. Hoặc export từng workflow ra JSON qua UI n8n:
- Mở workflow → menu `...` → Download → lưu vào `backup/workflows/<tên>.json`

Bên nhận: menu `...` → Import → chọn file.

Lợi ích: file nhẹ hơn, xem được diff trong git.
Nhược: credential phải tạo lại (không nằm trong JSON).

### C.7 Docker tốn bao nhiêu RAM?

- Postgres: ~100-200MB
- n8n: ~200-400MB
- Tổng ~500MB khi chạy. Máy tối thiểu 8GB RAM để dùng ổn.

### C.8 Bao lâu nên backup 1 lần?

Không có quy tắc cứng. Gợi ý:
- Trước mỗi lần commit quan trọng
- Trước khi tạo/sửa workflow n8n lớn
- Trước khi demo/present

### C.9 Quy trình làm việc nhóm

Nếu 2 người cùng làm (Tuấn + Nhung):
- Tuấn sở hữu Backend + Frontend code
- Nhung sở hữu n8n workflow
- Khi Nhung tạo workflow mới → Nhung chạy `export-backup.sh` → push lên git
- Tuấn `git pull` + `bash scripts/restore-backup.sh` để có workflow của Nhung

Cách khác nhẹ hơn: Nhung chỉ export workflow JSON, push file JSON lên git. Tuấn import.

---

## TÓM TẮT NGẮN GỌN

### Bên gửi:
```bash
cd dashauto-server
bash scripts/export-backup.sh
git add . && git commit -m "update backup" && git push
```

### Bên nhận lần đầu:
```bash
# Cài Docker Desktop + Node.js trước
git clone <server-repo>
git clone <client-repo>
cd dashauto-server
bash scripts/quick-start.sh      # → chọn 'y' khi hỏi restore backup
npm run dev                       # Terminal 1
# Terminal 2: cd ../dashauto-client && npm run dev
```

### Bên nhận lần sau (đã setup):
```bash
cd dashauto-server
docker compose up -d
npm run dev
# Terminal 2: cd ../dashauto-client && npm run dev
```

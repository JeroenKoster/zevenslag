# Hetzner Deployment Plan

## Architecture

One **Hetzner CX23 VPS** (€3.49/mo, 2 vCPU, 4 GB RAM) running two Docker containers via Compose:

```
Internet
  │
  ▼
Caddy (80/443)  ← auto-provisions Let's Encrypt SSL
  ├── /ws*  →  proxy → backend:8080 (Dart Frog + WebSockets)
  └── /*    →  serve static files (Flutter web build)
```

- **No sleep, no cold starts** — always-on containers
- **HTTPS + WSS** — Caddy handles certs automatically given a domain
- **Single instance** — correct for in-memory GameManager singleton
- **No egress fees** — 20 TB/mo included in Hetzner price

---

## Files to Create / Modify

### 1. `app/lib/features/game/data/game_service.dart` (modify)

Replace the hardcoded `ws://192.168.1.60:8080` URI with `String.fromEnvironment` so
the server host is injected at Flutter build time:

```dart
const serverHost = String.fromEnvironment('SERVER_HOST', defaultValue: 'localhost:8080');
const serverScheme = String.fromEnvironment('SERVER_SCHEME', defaultValue: 'ws');
final uri = Uri.parse('$serverScheme://$serverHost/ws?roomId=$roomId&playerId=$playerId');
```

---

### 2. `Dockerfile` (create at repo root)

Multi-stage build that handles the monorepo structure:

- **Stage 1 (build):** Copy full monorepo → `dart pub get` at workspace root →
  `dart_frog build` in `server/` → `dart pub get` in `server/build/` →
  `dart compile exe bin/server.dart -o bin/server`
- **Stage 2 (runtime):** `FROM scratch` — copy only the compiled binary + Dart runtime libs

Why repo root (not `server/`): `server/` has a path dependency on `../shared`, so both
packages need to be in the Docker build context.

---

### 3. `docker-compose.yml` (create at repo root)

Two services:
- **`backend`** — built from repo-root `Dockerfile`, exposes 8080 internally
- **`caddy`** — official Caddy image, ports 80 + 443, mounts `Caddyfile` +
  `app/build/web` (Flutter static output) + Caddy data volume for certs

---

### 4. `Caddyfile` (create at repo root)

```
{$DOMAIN} {
    reverse_proxy /ws* backend:8080
    root * /srv/www
    file_server
}
```

Domain is passed in via the `DOMAIN` environment variable so the same file works for any
hostname.

---

### 5. `scripts/deploy.sh` (create)

Executable script that:
1. Accepts `<domain>` and `<user@host>` as arguments
2. Builds Flutter web: `flutter build web --release --dart-define=SERVER_HOST=<domain> --dart-define=SERVER_SCHEME=wss`
3. SSHes to server, `git pull`s latest code
4. `docker compose up -d --build` (rebuilds backend image)
5. `rsync`s `app/build/web/` to the server's `app/build/web/` directory (so Caddy can serve it)

---

### 6. `HOSTING.md` (update)

Replace the current Fly.io + Vercel content with Hetzner instructions covering:
- One-time server provisioning steps
- Ongoing deploy workflow via `./scripts/deploy.sh`
- Cost summary

---

## One-Time Server Setup (manual, documented in HOSTING.md)

```
1. Create Hetzner CX23 VPS → Ubuntu 24.04 LTS, add your SSH public key
2. SSH in: ssh root@<ip>
3. Install Docker:
     curl -fsSL https://get.docker.com | sh
     apt install docker-compose-plugin -y
4. Firewall:
     ufw allow 22 && ufw allow 80 && ufw allow 443 && ufw enable
5. Clone repo:
     git clone <repo-url> /opt/zevenslag
6. Point your domain's A record → VPS IP (Caddy needs this for Let's Encrypt)
```

---

## Ongoing Deploy Workflow

```bash
./scripts/deploy.sh yourdomain.com user@<hetzner-ip>
```

Caddy picks up new static files immediately (bind mount). Backend restarts only when
`docker compose up --build` detects changes to the image.

---

## Summary of Changes

| File | Action |
|------|--------|
| `app/lib/features/game/data/game_service.dart` | Modify — use `String.fromEnvironment` |
| `Dockerfile` | Create — monorepo-aware multi-stage Dart build |
| `docker-compose.yml` | Create — Caddy + backend |
| `Caddyfile` | Create — reverse proxy config |
| `scripts/deploy.sh` | Create — build + deploy script |
| `HOSTING.md` | Update — replace Fly.io/Vercel with Hetzner |

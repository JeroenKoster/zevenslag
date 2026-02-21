# Hosting Plan for Zevenslag

## Architecture Overview

The app has two deployable components:

| Component | Tech | Output |
|-----------|------|--------|
| **Backend** | Dart Frog + WebSockets | Long-lived server process |
| **Frontend** | Flutter Web | Static files (HTML/JS/CSS) |

There is no database. All game state is held in memory on the server (`GameManager` singleton). No persistence layer is needed.

---

## Why Not Supabase

Supabase is a hosted PostgreSQL + auth + storage platform. This app uses none of those features — real-time communication is handled via custom WebSockets. Supabase would add complexity and cost with no benefit.

---

## Chosen Hosting Stack

### Backend: Fly.io

Fly.io runs Docker containers as persistent VMs (not serverless functions). This is the right fit because:

- WebSocket connections stay alive — serverless platforms (Lambda, Cloud Run, Vercel functions) kill long-lived connections
- No spin-down on inactivity — unlike Render's free tier, which pauses after 15 min and drops all in-memory game rooms
- Free tier includes 3 shared-CPU VMs and 256 MB RAM, sufficient for a small game server
- Dart Frog generates a production Dockerfile out of the box

**Important:** Run only **1 server instance**. The `GameManager` is an in-memory singleton — horizontal scaling would split game rooms across machines. Set `min_machines_running = 1` in `fly.toml`.

### Frontend: Vercel

Flutter Web compiles to a static bundle. Vercel is free, deploys on every push to `main`, and is the simplest option for static hosting.

---

## Step-by-Step Deployment

### Step 1: Fix the Hardcoded WebSocket URL

`app/lib/features/game/data/game_service.dart` currently has:

```dart
final uri = Uri.parse('ws://192.168.1.60:8080/ws?roomId=$roomId&playerId=$playerId');
```

This needs to point to the production server. Use Flutter's `--dart-define` flag to inject the URL at build time:

**In `game_service.dart`**, replace the hardcoded URI with:

```dart
const serverHost = String.fromEnvironment('SERVER_HOST', defaultValue: 'localhost:8080');
const serverScheme = String.fromEnvironment('SERVER_SCHEME', defaultValue: 'ws');
final uri = Uri.parse('$serverScheme://$serverHost/ws?roomId=$roomId&playerId=$playerId');
```

Build for production with:

```bash
flutter build web --dart-define=SERVER_HOST=your-app.fly.dev --dart-define=SERVER_SCHEME=wss
```

(Note: `wss://` is required when your Fly.io app has TLS enabled, which it does by default.)

---

### Step 2: Dockerize the Backend

Dart Frog's CLI generates a production Dockerfile:

```bash
# Install Dart Frog CLI if not already installed
dart pub global activate dart_frog_cli

# From the repo root, build the server
cd server
dart_frog build
```

This produces `server/build/` with a compiled binary and a `Dockerfile`. Alternatively, create one manually:

**`server/Dockerfile`:**

```dockerfile
FROM dart:stable AS build
WORKDIR /app
COPY . .
RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/server

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/server
EXPOSE 8080
CMD ["/app/bin/server"]
```

> Note: `dart_frog build` handles this automatically and is the recommended approach.

---

### Step 3: Deploy Backend to Fly.io

```bash
# Install flyctl
curl -L https://fly.io/install.sh | sh

# Log in
fly auth login

# Launch from the server directory (first time only)
cd server
fly launch
```

`fly launch` will detect the Dockerfile and create a `fly.toml`. Edit it to ensure:

**`server/fly.toml`** (key settings):

```toml
app = "zevenslag-server"
primary_region = "ams"  # Amsterdam — close to Dutch players

[http_service]
  internal_port = 8080
  force_https = true
  auto_stop_machines = "off"   # Keep alive for WebSocket sessions
  min_machines_running = 1     # Always have 1 instance ready

[vm]
  memory = "256mb"
  cpu_kind = "shared"
  cpus = 1
```

Deploy:

```bash
fly deploy
```

Your server will be live at `https://zevenslag-server.fly.dev` and WebSocket connections at `wss://zevenslag-server.fly.dev/ws`.

---

### Step 4: Deploy Frontend to Vercel

#### Option A: GitHub Integration (recommended)

1. Push the repo to GitHub
2. Go to [vercel.com](https://vercel.com) and import the repository
3. Set the following in Vercel project settings:
   - **Framework Preset**: Other
   - **Build Command**: `cd app && flutter build web --release --dart-define=SERVER_HOST=zevenslag-server.fly.dev --dart-define=SERVER_SCHEME=wss`
   - **Output Directory**: `app/build/web`
4. Vercel will redeploy automatically on every push to `main`

#### Option B: Manual CLI deploy

```bash
cd app
flutter build web --release \
  --dart-define=SERVER_HOST=zevenslag-server.fly.dev \
  --dart-define=SERVER_SCHEME=wss

npx vercel app/build/web --prod
```

---

## Cost Summary

| Service | Plan | Monthly Cost |
|---------|------|-------------|
| Fly.io (backend) | Free tier (3 VMs, 160 GB transfer) | $0 |
| Vercel (frontend) | Hobby (unlimited static bandwidth) | $0 |
| **Total** | | **$0** |

Both services have paid tiers if the game grows and needs more capacity.

---

## CI/CD (Optional)

Add a GitHub Actions workflow to automate deploys on push to `main`:

**`.github/workflows/deploy.yml`:**

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-server:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --remote-only
        working-directory: server
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter pub get
        working-directory: app
      - run: flutter build web --release --dart-define=SERVER_HOST=zevenslag-server.fly.dev --dart-define=SERVER_SCHEME=wss
        working-directory: app
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: app/build/web
          vercel-args: --prod
```

---

## Next Steps (in order)

1. **Fix the WebSocket URL** — replace the hardcoded IP in `game_service.dart` with `String.fromEnvironment` (see Step 1)
2. **Run `dart_frog build`** in the `server/` directory to generate the production build and Dockerfile
3. **Create a Fly.io account** and run `fly launch` from `server/`
4. **Deploy to Fly.io** with `fly deploy`
5. **Push repo to GitHub** and connect to Vercel for the frontend
6. **Test end-to-end** — open the Vercel URL and confirm WebSocket connects to Fly.io

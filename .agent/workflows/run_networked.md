---
description: Run the environment accessible from the local network
---

1. Start Server (Binding to all interfaces).
   - Command: `dart_frog dev --hostname 0.0.0.0`
   - Directory: `/Users/jkoster/Projects/side_projects/zevenslag/server`

2. Launch Web App (Serving on port 8000).
   - Command: `flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8000`
   - Directory: `/Users/jkoster/Projects/side_projects/zevenslag/app`

3. Access Information:
   - Your local IP is `192.168.1.60`
   - Players can join by visiting: `http://192.168.1.60:8000`

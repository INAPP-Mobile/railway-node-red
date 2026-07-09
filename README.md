# Deploy and Host node-red on Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/new/template/spyQkl)

> **Canonical code:** `spyQkl` — deploy URL: https://railway.com/new/template/spyQkl

![OG Image](https://raw.githubusercontent.com/INAPP-Mobile/railway-node-red/main/og-image.svg)

Node-RED is a low-code, flow-based programming tool for wiring together hardware devices, APIs, and online services. Deploy it on Railway in minutes to start building automations visually.

## About Hosting node-red

Node-RED runs as a single container with a persistent Railway volume mounted at `/data` for flows, settings, and credentials. Railway provides the compute, TLS at the edge, and a public URL. The service restarts automatically on failures. No external database is required for basic usage — everything runs in one container. The base image's settings.js honors `PORT` (Railway injects this), so the flow editor is reachable on Railway's standard edge port without further configuration.

## Common Use Cases

- **IoT automation** — Connect sensors, actuators, and devices with MQTT, Modbus, OPC-UA, and GPIO.
- **API orchestration** — Chain HTTP requests, transform data, and integrate multiple services in a single flow.
- **Smart home** — Automate lights, thermostats, and devices with Home Assistant, Philips Hue, and Zigbee.
- **Data pipelines** — Ingest, transform, and route data between databases, message queues, and cloud services.
- **Chatbots & alerts** — Build Telegram/Slack bots, send email alerts, and trigger notifications from any event.

## Dependencies for node-red Hosting

- **Persistent volume** — A Railway volume mounted at `/data` is required to retain flows, credentials, and settings across redeploys.
- **No external database** — Node-RED runs standalone; Postgres/MySQL/Redis are not required for basic flows.

### Deployment Dependencies

- [Node-RED documentation](https://nodered.org/docs/) — upstream reference for flows, settings, and node management.
- [Node-RED Docker image](https://hub.docker.com/r/nodered/node-red) — base image used by this template (v5.0.0, Debian-based).
- [Node-RED GitHub](https://github.com/node-red/node-red) — source code, issue tracker, and community nodes.

### Implementation Details

- **Healthcheck** — `node /healthcheck.js` is shipped by the base image and probes the local UI port; configured in the Dockerfile's `HEALTHCHECK` directive.
- **Persistent storage** — The `/data` volume is mounted via `railway.json` / `railway.toml` under `deploy.volumeMounts`.
- **Port** — Railway auto-injects `PORT`; the base image's `settings.js` reads it and binds the UI accordingly. Default fallback is `1880`.

## Why Deploy node-red on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying node-red on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.

---

## Features

- **Flow-based editor** — Drag, drop, and wire nodes in the browser
- **5,000+ community nodes** — MQTT, HTTP, database connectors, AI, dashboards, and more
- **One-click deploy** — Pre-configured with Railway volume for persistent flows
- **Built-in healthcheck** — Monitored by Railway for automatic restarts
- **Pinned version** — Node-RED v5.0.0, reproducible builds

## Quick Start

Click Deploy above, then open your Railway URL to access the flow editor. All flows are saved to the persistent volume at `/data`.

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PORT` | No | `1880` | Container port (Railway auto-sets) |
| `FLOWS` | No | `flows.json` | Flow file to load from `/data` |
| `CREDENTIAL_SECRET` | No | — | Encryption key for stored credentials |
| `NODE_RED_ENABLE_PROJECTS` | No | `false` | Enable Git-backed projects |
| `NODE_RED_ENABLE_SAFE_MODE` | No | `false` | Start without running flows |

## Local Development

```bash
git clone https://github.com/INAPP-Mobile/railway-node-red && cd railway-node-red
cp .env.example .env && $EDITOR .env
docker build -t railway-node-red .
docker run -d -p 1880:1880 -v node-red-data:/data --env-file .env railway-node-red
```

Open http://localhost:1880 in your browser.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Flows lost after redeploy | Confirm `/data` volume is mounted in Railway |
| Port conflict | Override `PORT` env var — Railway auto-routes |
| Credentials broken | `CREDENTIAL_SECRET` was changed; re-enter credentials |

## License

Node-RED is Apache-2.0 licensed. Template by [INAPP-Mobile](https://github.com/INAPP-Mobile).

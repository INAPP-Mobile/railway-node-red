# =============================================================================
# Railway Template: Node-RED
# Official Docker image: https://hub.docker.com/r/nodered/node-red
# GitHub: https://github.com/node-red/node-red-docker
# License: Apache-2.0
# =============================================================================

# Use the official Node-RED image (v5.0.0, Debian-based)
# The base image runs as user 'node-red' (UID 1000).
# The base image's settings.js honors process.env.PORT for the UI port,
# so Railway's auto-injected PORT is respected without an explicit ENV here.
FROM docker.io/nodered/node-red:5.0.0

ENV FLOWS=flows.json \
    NODE_RED_ENABLE_PROJECTS=false \
    NODE_RED_ENABLE_SAFE_MODE=false

# Base image ships /healthcheck.js — performs a local HTTP probe against
# the UI port. start-period covers Node-RED's initial package install
# (npm install on first boot can take 60-90s for a fresh volume).
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
  CMD node /healthcheck.js

# The base image entrypoint handles settings and flows from /data.
# Mount a Railway volume at /data for persistence.

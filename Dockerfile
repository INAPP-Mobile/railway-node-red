# =============================================================================
# Railway Template: Node-RED
# Official Docker image: https://hub.docker.com/r/nodered/node-red
# GitHub: https://github.com/node-red/node-red-docker
# License: Apache-2.0
# =============================================================================

# Use the official Node-RED image (v5.0.0, Debian-based)
# The base image runs as user 'node-red' (UID 1000)
FROM docker.io/nodered/node-red:latest

# =============================================================================
# Port Configuration
# Node-RED listens on port 1880 by default
# =============================================================================
EXPOSE 1880

# =============================================================================
# Environment defaults
# =============================================================================
ENV FLOWS=flows.json \
    NODE_RED_ENABLE_PROJECTS=false \
    NODE_RED_ENABLE_SAFE_MODE=false

# =============================================================================
# Railway Health Check
# Node-RED exposes its admin API at the root path
# Uses the built-in healthcheck.js bundled with the image
# =============================================================================
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD node /healthcheck.js

# =============================================================================
# The base image entrypoint handles:
# - Settings file: /data/settings.js
# - Flows file: /data/flows.json (configurable via $FLOWS)
# - User directory: /data
# - Context store: Memory (default)
#
# To persist flows across redeploys, mount a volume at /data
# =============================================================================

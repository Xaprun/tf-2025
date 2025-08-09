#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# Update packages
apt-get update -y

# Install tools
apt-get install -y net-tools nmap

# Where to save results (world-readable for convenience)
LOG_DIR="/var/log"
LOG_FILE="${LOG_DIR}/nmap-10.0.6-first5.log"

# Run a quick host discovery + basic port check on common ports
# -sn : host discovery (no port scan)
# Then a fast top-100 ports scan on any hosts that respond.
# If you only want discovery, remove the second nmap command.
nmap -sn 10.0.6.1-5 -oN "${LOG_FILE}"

LIVE_HOSTS=$(awk '/Nmap scan report for/{print $5}' "${LOG_FILE}" || true)
if [ -n "${LIVE_HOSTS}" ]; then
  # Append a short ports scan for live hosts
  echo -e "\n===== Top 100 TCP ports on live hosts =====" >> "${LOG_FILE}"
  nmap --top-ports 100 -T4 ${LIVE_HOSTS} -oN - >> "${LOG_FILE}"
fi

# Make sure it's easy to read later
chmod 644 "${LOG_FILE}"
echo "Nmap results saved to ${LOG_FILE}"

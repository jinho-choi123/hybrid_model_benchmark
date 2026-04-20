#!/bin/bash

set -euo pipefail

# Install Nsight Systems CLI on Rocky Linux from NVIDIA's direct RPM download

RPM_URL="https://developer.nvidia.com/downloads/assets/tools/secure/nsight-systems/2026_2/NsightSystems-linux-cli-public-2026.2.1.210-3763964.rpm"
RPM_FILE="$(basename "${RPM_URL}")"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "${WORK_DIR}"' EXIT

cd "${WORK_DIR}"

# Download
curl -fL --retry 3 -o "${RPM_FILE}" "${RPM_URL}"

# Install (dnf resolves dependencies; --nogpgcheck because this is a direct-download RPM,
# not from a signed repo)
dnf install -y --nogpgcheck "./${RPM_FILE}"

# Verify
nsys --version
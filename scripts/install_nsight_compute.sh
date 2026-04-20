#!/bin/bash

set -euo pipefail

# Install Nsight Compute on Rocky Linux from NVIDIA's direct .run download

RUN_URL="https://developer.nvidia.com/downloads/assets/tools/secure/nsight-compute/2024_1_0/nsight-compute-linux-2024.1.0.13-33681293.run"
RUN_FILE="$(basename "${RUN_URL}")"
VERSION="2024.1.0"
INSTALL_DIR="/opt/nvidia/nsight-compute/${VERSION}"

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "${WORK_DIR}"' EXIT

cd "${WORK_DIR}"

# Download
curl -fL --retry 3 -o "${RUN_FILE}" "${RUN_URL}"
chmod +x "${RUN_FILE}"

# Silent/unattended install
mkdir -p "${INSTALL_DIR}"
./"${RUN_FILE}" --accept-eula --quiet --installdir="${INSTALL_DIR}"

# Symlink ncu / ncu-ui onto PATH
ln -sf "${INSTALL_DIR}/ncu"    /usr/local/bin/ncu
ln -sf "${INSTALL_DIR}/ncu-ui" /usr/local/bin/ncu-ui

# Verify
ncu --version
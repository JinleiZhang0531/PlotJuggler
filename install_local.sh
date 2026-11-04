#!/usr/bin/env bash
# Install / refresh local PlotJuggler into ~/workspace/tools/PlotJuggler/install
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILD="${ROOT}/build"
INSTALL="${ROOT}/install"
DESKTOP="${HOME}/.local/share/applications/plotjuggler-local.desktop"

cmake --build "${BUILD}" --target plotjuggler -j"$(nproc)"
cmake --install "${BUILD}"
cp -f "${BUILD}/bin/plotjuggler" "${INSTALL}/bin/plotjuggler"

mkdir -p "${HOME}/.local/bin"
ln -sf "${INSTALL}/bin/plotjuggler" "${HOME}/.local/bin/plotjuggler"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
fi

echo "Installed: ${INSTALL}/bin/plotjuggler"
echo "Desktop:   ${DESKTOP}"
echo "CLI:       ${HOME}/.local/bin/plotjuggler (ensure ~/.local/bin is on PATH)"

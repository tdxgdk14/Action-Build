#!/usr/bin/env bash
set -euo pipefail

WORKSPACE="${GITHUB_WORKSPACE:-$(pwd)}"
COMMON_DIR="${WORKSPACE}/kernel_workspace/kernel_platform/common"
PATCH_DIR="${WORKSPACE}/kernel_workspace/lxcpatch/Action-Build/lxc-patch"

cd "$COMMON_DIR"

for patch in cgroupv1 sysvipc overlay lxc net module esp esp1 ptrace skbbuff skbbuff1; do
  echo "Applying ${patch}.patch"
  patch -p1 < "${PATCH_DIR}/${patch}.patch" || true
done

if [[ -n "${REJ_CHECKER:-}" && -f "$REJ_CHECKER" ]]; then
  source "$REJ_CHECKER"
  check_rejects .
else
  echo "⚠️ REJ_CHECKER 未定义，跳过 .rej 检查"
fi
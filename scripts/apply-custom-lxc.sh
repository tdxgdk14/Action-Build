cd "${GITHUB_WORKSPACE}/kernel_workspace/kernel_platform/common"
PATCH_DIR="${GITHUB_WORKSPACE}/lxc-patch"
for patch in cgroupv1 sysvipc overlay lxc net module esp esp1 ptrace skbbuff skbbuff1; do
  echo "Applying ${patch}.patch"
  patch -p1 < "${PATCH_DIR}/${patch}.patch" || true
done
source "$REJ_CHECKER"
check_rejects .
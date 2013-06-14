
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# Fedora-specific, not generally applicable:
if [ "${SB_UACL}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-udev.patch
fi
# Upstreamed at: https://alioth.debian.org/tracker/index.php?func=detail&aid=313040
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-epson-expression800.patch
# Upstreamed at: https://alioth.debian.org/tracker/index.php?func=detail&aid=313043
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-SCX4500W.patch
# Fedora-specific (for now): make installed sane-config multi-lib aware again
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-sane-config-multilib.patch
# Submitted upstream: don't barf on umax init errors
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-umax-init-error.patch
# Submitted upstream: coolscan2/3: support multi-scan option of some devices
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-coolscan-multiscan.patch

set +e +o pipefail

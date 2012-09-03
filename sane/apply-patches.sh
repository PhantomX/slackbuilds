
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora-specific, not generally applicable:
if [ "${SB_UACL}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-udev.patch
fi
# Upstreamed at: https://alioth.debian.org/tracker/index.php?func=detail&aid=313040
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-epson-expression800.patch
# Upstreamed at: https://alioth.debian.org/tracker/index.php?func=detail&aid=313043
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-SCX4500W.patch

set +e +o pipefail

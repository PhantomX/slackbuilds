
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From stock
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-1.4.x-allow_root_globally.diff
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/avoid-undefined-7c00ed22d9b5c33f5b33221e906946b11a9bde3b.patch

set +e +o pipefail

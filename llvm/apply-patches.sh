
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-data-install-preserve-timestamps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-linker-flags-speedup-memory.patch

set +e +o pipefail

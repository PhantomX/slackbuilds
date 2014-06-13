
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# sync with release_34@209031
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Merging-r207990.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Merging-r208721.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Merging-r208501.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Merging-r208908.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-data-install-preserve-timestamps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-linker-flags-speedup-memory.patch

# sledgehammer to default to hard-float on arm
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clang-3.4-arm-hard-float.patch

# http://llvm.org/bugs/attachment.cgi?id=12586
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pr12586.patch

patch -p2 -E --backup --verbose -d tools/clang -i ${SB_PATCHDIR}/rL201729.patch

set +e +o pipefail

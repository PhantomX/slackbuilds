
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-data-install-preserve-timestamps.patch

# http://llvm.org/bugs/attachment.cgi?id=12586
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pr12586.patch

patch -p1 -E --backup --verbose -d tools/clang -i ${SB_PATCHDIR}/clang-fake-gcc43.patch

set +e +o pipefail

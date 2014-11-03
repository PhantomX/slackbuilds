
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libclc-llvm-3.5-compat.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libclc-dso.patch

set +e +o pipefail

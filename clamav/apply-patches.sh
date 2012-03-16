
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i  ${SB_PATCHDIR}/${NAME}-0.92-private.patch
patch -p1 -E --backup --verbose -i  ${SB_PATCHDIR}/${NAME}-0.92-open.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95-cliopts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.3-umask.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/llvm-glibc.patch

set +e +o pipefail

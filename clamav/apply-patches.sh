
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i  ${SB_PATCHDIR}/${NAME}-0.92-private.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.98.5-cliopts.patch
patch -p1 -E --backup -z .umask --verbose -i ${SB_PATCHDIR}/${NAME}-0.98-umask.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.98.6-jitoff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/llvm-glibc.patch

set +e +o pipefail

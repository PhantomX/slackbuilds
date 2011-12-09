
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lapack-3.4.0-make.inc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lapack-3.4.0-lapacke-shared.patch

set +e +o pipefail

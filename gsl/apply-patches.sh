
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsl-1.10-lib64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsl-1.14-link.patch

set +e +o pipefail

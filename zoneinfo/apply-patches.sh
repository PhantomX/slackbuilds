
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .makefile --verbose -i ${SB_PATCHDIR}/timezone-data-2013h-makefile.patch

set +e +o pipefail

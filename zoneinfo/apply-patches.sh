
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .makefile --verbose -i ${SB_PATCHDIR}/timezone-data-2013d-makefile.patch
zcat ${SB_PATCHDIR}/${NAME}-fix-man-install.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail

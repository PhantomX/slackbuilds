
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/popt-1.16-pkgconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/popt-1.16-execfail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/popt-1.16-man-page.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/popt-1.16-help.patch

set +e +o pipefail

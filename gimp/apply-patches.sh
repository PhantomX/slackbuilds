
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.0-fits.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.0-CVE-2012-3403.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.0-CVE-2012-3481.patch

set +e +o pipefail

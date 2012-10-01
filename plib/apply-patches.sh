
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/plib-1.8.4-fullscreen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/plib-1.8.4-autorepeat.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/plib-1.8.5-CVE-2011-4620.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.4-destdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.4-black-vertices-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.4-rh555877.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.4-rh667236.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.4-guile20.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.4-remove-old-sdl-workarounds.patch

set +e +o pipefail

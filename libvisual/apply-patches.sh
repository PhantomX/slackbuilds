
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libvisual-0.4.0-better-altivec-detection.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libvisual-0.4.0-inlinedefineconflict.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libvisual-184209.patch

set +e +o pipefail

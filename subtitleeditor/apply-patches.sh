
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.41.0-textoverlay.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.41.0-keyframe-generation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.41.0-fix-custom-class-interfaces.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.41.0-fix-custom-class-interfaces-timecell.patch

set +e +o pipefail

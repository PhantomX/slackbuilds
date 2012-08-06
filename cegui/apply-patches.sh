
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cegui-0.7.6-python-detection.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cegui-0.7.6-irrlicht-typo.patch

set +e +o pipefail

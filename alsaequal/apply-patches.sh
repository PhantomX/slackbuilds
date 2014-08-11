
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/alsaequal-0.6-asneeded.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/alsaequal-0.6-eq-name.patch

set +e +o pipefail

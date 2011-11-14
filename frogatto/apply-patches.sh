
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Reverted some parts from joystick.cpp from 1.0, so my joystick axes works again.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.2-js.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-libpng15.patch

set +e +o pipefail

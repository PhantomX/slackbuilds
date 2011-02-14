
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-show-button.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.14-libnotify-0.7.0.patch

set +e +o pipefail

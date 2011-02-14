
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.10-fix-version-string.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.10-aplay.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.10-libnotify-0.7.0.patch

set +e +o pipefail

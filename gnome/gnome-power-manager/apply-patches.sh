
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dont-eat-the-logs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.0-libnotify07.patch

set +e +o pipefail

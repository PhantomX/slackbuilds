
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.1-fix-GTK-symbols.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libnotify07.patch

set +e +o pipefail

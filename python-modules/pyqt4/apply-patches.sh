
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/PyQt-dso.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.8.2-build_flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt.phonon.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-stackedwidget-bug.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Provide-proper-include-paths-in-.moc-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-qt4-pinentry-window-created-in-the-background.patch

set +e +o pipefail

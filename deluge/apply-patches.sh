
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.5-pt_BR-fix.patch
# Ubuntu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}//new_release_check.patch

# Assorted fixes from upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Only-convert-the-move-path-to-unicode-if-on-windows.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-previous-commit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Don-t-use-deprecated-twisted-imports-fixes-2164.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-deluge-gtk-not-working-with-twisted-12-fixes-214.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2160-Disable-use-of-python-bindings-for-libtorre.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2163-Cannot-add-torrent-file-with-empty-0-encodi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2169-Add-Torrent-Dialog-Download-Location-not-se.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2185-register-call-should-be-deregister-in-dereg.patch

set +e +o pipefail

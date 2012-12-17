
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2201-auth-fails-if-auth-file-has-extra-newlines.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2109-Proxy-settings-not-being-cleared-by-setting.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-the-version-check-in-_libtorrent-to-work-as-inte.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-libtorrent-version-check-in-torrent.py.-fix-2223.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2228-Apply-To-All-in-AddTorrent-Dialog-is-copyin.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-2129-Empty-filename-can-be-set-in-AddTorrent-dia.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fix-2130-Same-name-can-be-given-to-different-files-i.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-fix-snafu-in-last-commit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Increase-libtorrent-alert-queue-size.-fix-2204.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-On-some-race-conditions-the-torrent-is-removed-befor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Use-try-except-instead-of-if-statement-to-gain-a-lit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-2227-Torrent-file-contains-sha1-and-ed2k-digest-.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pt_BR-fix.patch
# Ubuntu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/new_release_check.patch

# Assorted fixes from upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-issue-with-Plugins-that-add-Tab-to-torrentdetail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-scalable-icon-install-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2324-Encryption-level-set-by-deluge-does-not-mat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-2221-Addtorrentdialog-KeyError-accessing-downloa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fix-2303-Torrent-state-not-updated-until-after-emitt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Fix-2302-deluge-gtk-crashed-with-IndexError-in-get_p.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Fix-2338-Spelling-mistake-with-occurred.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-twisted-13.1-compat-the-_parse-function-was-repl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-2335-IPC-lockfile-issue-preventing-start-of-delu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-2365-Hiding-Progress-column-generates-TypeError.patch

set +e +o pipefail

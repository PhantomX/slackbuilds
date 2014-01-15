
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Most patches are from Fedora
zcat ${SB_PATCHDIR}/kdebase-runtime-4.1.x-searchproviders-shortcuts.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdebase-runtime-4.3.1-manpath.patch.gz | patch -p1 -E --backup --verbose
# add OnlyShowIn=KDE  to Desktop/Home.desktop (like trash.desktop)
zcat ${SB_PATCHDIR}/kdebase-runtime-4.3.3-home_onlyshowin_kde.patch.gz | patch -p1 -E --backup --verbose

# Launch compiz via compiz-manager so we get window decorations and
# other such decadent luxuries (AdamW 2011/01)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.5.95-compiz.patch

# avoid X3 mouse events
# https://bugs.kde.org/show_bug.cgi?id=316546
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mouseeventlistener.patch

# Volume gets restored to 100% after each knotify event
# https://bugs.kde.org/show_bug.cgi?id=324975
# knotify/libcanberra support from mageia
# http://svnweb.mageia.org/packages/cauldron/kdebase4-runtime/current/SOURCES/kdebase-runtime-4.6.0-canberra.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.6.0-canberra.patch

# tirpc support
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.6.4-tirpc.patch

## upstreamable patches

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_raa8e114497e28bcd189f55dfe4e6f46816e4d534.diff

# backport support for libssh 0.6 and ECDSA keys (kde#327024) from master/4.13
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.12.0-libssh-0.6-0001-kio_sftp-Fix-error-values.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.12.0-libssh-0.6-0002-kio_sftp-Fix-printing-dest-in-the-log.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.12.0-libssh-0.6-0003-kio_sftp-Support-ECDSA-keys.patch

set +e +o pipefail

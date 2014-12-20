
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Most patches are from Fedora
zcat ${SB_PATCHDIR}/kdebase-runtime-4.1.x-searchproviders-shortcuts.patch.gz | patch -p1 -E --backup --verbose
# support kdesud -Wl,-z,relro,-z,now linker flags
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kdesud_relro.patch
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_ra977b2378ff4d88b561d599a1116821c694493f1.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r6ec92cf19376bcae8b13c0a741c81f222db0b2f5.diff

set +e +o pipefail

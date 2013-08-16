
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

# tirpc support
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.6.4-tirpc.patch

## upstreamable patches

# avoid X3 mouse events
# https://bugs.kde.org/show_bug.cgi?id=316546
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mouseeventlistener.patch

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r7b69cd2f6c28a088c886a51549005b8edcbb91f1.diff

set +e +o pipefail

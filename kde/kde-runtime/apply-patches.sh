
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Most patches are from Fedora
zcat ${SB_PATCHDIR}/kdebase-runtime-4.1.x-searchproviders-shortcuts.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.6.90-iconthemes-inherit.patch
zcat ${SB_PATCHDIR}/kdebase-runtime-4.3.1-manpath.patch.gz | patch -p1 -E --backup --verbose
# add OnlyShowIn=KDE  to Desktop/Home.desktop (like trash.desktop)
zcat ${SB_PATCHDIR}/kdebase-runtime-4.3.3-home_onlyshowin_kde.patch.gz | patch -p1 -E --backup --verbose

# Launch compiz via compiz-manager so we get window decorations and
# other such decadent luxuries (AdamW 2011/01)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.5.95-compiz.patch
# To build/include activitymanager or not
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kde-runtime-4.7.2-no_activitymanager.patch
# tirpc support
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-runtime-4.6.4-tirpc.patch

# Mandriva
zcat ${SB_PATCHDIR}/kdebase-runtime-4.3.2-knotify-fix-cpu-charge.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libqzeitgeist08.patch

## upstream patches
# based on patch from ftp://ftp.kde.org/pub/kde/stable/active/1.0/src/
# includes only the piece wrt additional nepomuk ontologies
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/active-development-4.7-diff-1.patch
# 4.8 backport
# https://projects.kde.org/projects/kde/kde-runtime/repository/revisions/e6e6fb53419ec212ccae083162999d66e7d5663b
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kdebug288389.patch

set +e +o pipefail

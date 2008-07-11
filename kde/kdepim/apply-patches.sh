
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/akregator-3.5.7-customcolors.diff.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.4.0-kandy-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1
# LANG=en_US.UTF-8 svn diff svn://anonsvn.kde.org/home/kde/tags/KDE/3.5.9/kdepim/kitchensync@774532 \
# svn://anonsvn.kde.org/home/kde/branches/work/kitchensync-OpenSync0.30API@774532 >kdepim-3.5.9-opensync03.patch
( cd kitchensync || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-3.5.9-opensync03.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
# http://websvn.kde.org/?view=rev&revision=775015
# http://bugs.kde.org/show_bug.cgi?id=127696
# Upstream fix for "Unable to complete LIST operation" errors with some servers,
# just missed the 3.5.9 tagging.
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-kde\#127696.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugs.kde.org/151150
# http://websvn.kde.org/?view=rev&revision=779994
zcat ${SB_PATCHDIR}/${NAME}-kde\#151150.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstream patches
zcat ${SB_PATCHDIR}/${NAME}-3.5.x-kmail-imap-crash.patch.gz | patch -p0 -E --backup --verbose || exit 1

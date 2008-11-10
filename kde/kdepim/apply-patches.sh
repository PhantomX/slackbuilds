
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/akregator-3.5.7-customcolors.diff.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.4.0-kandy-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-xdg_open.patch.gz | patch -p1 -E --backup --verbose || exit 1
# patch by Dirk Müller from openSUSE to fix gnokii detection
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-gnokii-no-libintl.patch.gz | patch -p0 -E --backup --verbose || exit 1

# LANG=en_US.UTF-8 svn diff svn://anonsvn.kde.org/home/kde/tags/KDE/3.5.9/kdepim/kitchensync@774532 \
# svn://anonsvn.kde.org/home/kde/branches/work/kitchensync-OpenSync0.30API@774532 >kdepim-3.5.9-opensync03.patch
( cd kitchensync || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-3.5.9-opensync03.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1

# add converter for old kabc distribution lists
# http://websvn.kde.org/?view=rev&revision=856958
# build fix for the above: http://websvn.kde.org/?view=rev&revision=858693
# http://bugs.kde.org/show_bug.cgi?id=170259
# https://bugzilla.redhat.com/show_bug.cgi?id=464622
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-kabcdistlistupdater.patch.gz | patch -p0 -E --backup --verbose || exit 1

## upstream patches


# KDEmod patches
zcat ${SB_PATCHDIR}/03_kmail-allow-tls-login-auth.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/04_kmail-fancy-currenttime.patch.gz | patch -p1 -E --backup --verbose || exit 1

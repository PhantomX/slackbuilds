
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/akregator-3.5.7-customcolors.diff.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.4.0-kandy-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1
# LANG=en_US.UTF-8 svn diff svn://anonsvn.kde.org/home/kde/tags/KDE/3.5.9/kdepim/kitchensync@774532 \
# svn://anonsvn.kde.org/home/kde/branches/work/kitchensync-OpenSync0.30API@774532 >kdepim-3.5.9-opensync03.patch
( cd kitchensync || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-3.5.9-opensync03.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1

## upstream patches


# KDEmod patches
zcat ${SB_PATCHDIR}/03_kmail-allow-tls-login-auth.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/04_kmail-fancy-currenttime.patch.gz | patch -p1 -E --backup --verbose || exit 1

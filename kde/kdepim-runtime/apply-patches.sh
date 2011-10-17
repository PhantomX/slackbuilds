
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .show --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-show-akonadi-kcm.patch

# disable nepomuk/strigi notification spam 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-nepomuk_notification.patch

# Enable SQLite support in akonadi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.1-sqlite-support.patch

# upstream patches
# http://bugs.kde.org/283467
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-kde283467.patch
# http://bugs.kde.org/283364
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-kde283364.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix build with KDE 4.3.80's version of webkitkde (upstream patch)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-babelfish-kwebkitpart.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.0-qt47.patch
# http://bugs.kde.org/234624
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.0-kde234624.patch
# http://websvn.kde.org/?revision=1185208&view=revision
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.0-adblock-window-close-fix.patch

set +e +o pipefail

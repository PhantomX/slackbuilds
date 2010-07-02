
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.6.2-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-disable_java.patch.gz | patch -p0 -E --backup --verbose

## upstream patches
# http://bugs.kde.org/234398
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-kdebug234398.patch

set +e +o pipefail

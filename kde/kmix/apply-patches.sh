
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstream patches
# pull a few from master/ branch, not officially backported
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-MPRIS2-backend-now-does-a-asynchonous-DBUS-instrospe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Use-a-fixed-volume-step-of-n-instead-of-honoring-mou.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Global-Keyboard-Shortcuts-XF86Audio-now-only-affect-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-memoryLeak.patch
# https://bugs.kde.org/show_bug.cgi?id=309464
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r6edddf7c8e92bb499cb60fdee53622cab326f334.diff

set +e +o pipefail

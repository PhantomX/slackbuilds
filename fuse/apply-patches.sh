
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-0001-Fix-udev-rules-Fedora-specific.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-0002-More-parentheses.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-0003-Fix-mounting-FUSE-fs-into-current-working-directory.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-2.8.5-header.patch

set +e +o pipefail

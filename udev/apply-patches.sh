
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rule_generator.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/udev.git-560de575148b7efda3b34a7f7073abd483c5f08e.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/udev-fix-broken-permissions.patch

set +e +o pipefail

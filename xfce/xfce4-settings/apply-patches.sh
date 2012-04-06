
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Add patch to handle position settings on multi monitor setups
# https://bugzilla.xfce.org/show_bug.cgi?id=7465
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.3-monitor-position.patch
# Bogus XFCE in desktop categories. 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.4-fix-desktop.patch

set +e +o pipefail

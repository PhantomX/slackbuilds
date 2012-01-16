
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://code.google.com/p/firetray/source/detail?r=142
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.1-sdk9.patch
# Patch1:  Check for install.rdf before removing it during the build
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.1-check-for-install-rdf-before-removing-it.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.1-use-arch-dep-mozconfig.patch
# Patch3 : use the window icon
#          http://code.google.com/p/firetray/issues/detail?id=190
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.1-use-first-window-icon.patch

set +e +o pipefail

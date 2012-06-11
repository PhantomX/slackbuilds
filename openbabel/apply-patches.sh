
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-rpm.patch
# fix plugin directory location (#680292, patch by lg)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.0-plugindir.patch
# Patch 5-7: all ruby related
# fix build with gcc47 + ruby on Linux
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.1-gcc47-darwin.patch
# fix SWIG_init even when not using swig (#772149)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.1-noswig-rubymethod.patch
# On F-17, directory for C ruby files changed to use vendorarch directory
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.1-ruby19-vendorarch.patch

set +e +o pipefail

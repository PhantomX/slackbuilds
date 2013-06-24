
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### From Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-remove-rpath.patch
# Disable video previews of map levels
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-disable-smpeg.patch
# Avoid problem with lib checks using c++ instead of c.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libcheck.patch
# Don't override options
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-excessopts.patch
# gcc is now more picky about casting
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc.patch
# bted doesn't explicitly link to clunl
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dso.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc47.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.8083-lua-5.2.patch

set +e +o pipefail

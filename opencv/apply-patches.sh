
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Fedora cmake macros define -DLIB_SUFFIX=64 on 64 bits platforms
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cmake-libdir.patch
# Fixes memory corruption in the gaussian random number generator.
# Fixed in the revision 2282 of the upstream svn repository.
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.0-gaussianrng.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng-1.4.patch

set +e +o pipefail

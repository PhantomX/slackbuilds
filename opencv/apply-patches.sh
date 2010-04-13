
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Fedora cmake macros define -DLIB_SUFFIX=64 on 64 bits platforms
patch -p1 -E --backup -z .libdir --verbose -i ${SB_PATCHDIR}/${NAME}-cmake-libdir.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng-1.4.patch

set +e +o pipefail

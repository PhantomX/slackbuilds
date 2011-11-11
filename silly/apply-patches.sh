
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638811
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/silly-libpng15.patch

set +e +o pipefail

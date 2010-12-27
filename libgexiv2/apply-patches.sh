
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://trac.yorba.org/ticket/2899
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gexiv2-0.2.1-exiv2-0.21.patch

set +e +o pipefail

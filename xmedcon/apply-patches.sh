
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://www.openbsd.org/cgi-bin/cvsweb/~checkout~/ports/graphics/xmedcon/patches/patch-source_m-png_c?rev=1.1;content-type=text%2Fplain
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.10.7-libpng15.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# ftp://ftp.ibiblio.org/pub/Linux/ALPHA/freetds/stable/cspublic.BLK_VERSION_150.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cspublic.BLK_VERSION_150.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.82-shared-libtds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.82-libtool.patch

set +e +o pipefail

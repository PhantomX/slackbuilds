
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/11mark_trashed_as_read.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0cvs15.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-gnutls.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpgme-1.7.0-confix_extras.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpgme-1.3.2-largefile.patch

set +e +o pipefail

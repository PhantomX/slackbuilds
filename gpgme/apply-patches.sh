
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gpgme-1.1.8-config_extras.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpgme-1.2.0-ImplicitDSOLinking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpgme-1.2.0-largefile.patch

set +e +o pipefail

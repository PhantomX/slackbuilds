
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-2.8.6-link-libgcrypt.patch
# Backport from upstream git
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-2.10.1-handshake-errors.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.5.1-default-policy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.4.2-no-now-guile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.5.7-load-pkcs8-keys.patch

set +e +o pipefail

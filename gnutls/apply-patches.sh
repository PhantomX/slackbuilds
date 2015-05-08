
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.4.1-default-policy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.4.1-supplemental-api.patch

set +e +o pipefail

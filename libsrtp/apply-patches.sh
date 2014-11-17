
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libsrtp-1.5.0-shared.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libsrtp-sha1-name-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libsrtp-srtp_aes_encrypt.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .path --verbose -i ${SB_PATCHDIR}/wget-1.13-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.13.4-sslreadtimeout.patch

set +e +o pipefail

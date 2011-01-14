
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-errno.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-strmov.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-install-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-expired-certs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-stack-guard.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-chain-certs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-versioning.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-dubious-exports.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-disable-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-embedded-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-home.patch

set +e +o pipefail

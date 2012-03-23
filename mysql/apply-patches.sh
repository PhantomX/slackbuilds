
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-home.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-plugin-bool.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-openssl-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysqld-nowatch.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-va-list.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-netdevname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-logrotate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-plugin-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-cipherspec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-file-contents.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mysql-string-overflow.patch

set +e +o pipefail

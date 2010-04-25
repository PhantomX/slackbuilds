
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mysql-libdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-ssl-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-errno.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-testing.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-install-test.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-stack-guard.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-setschedparam.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-strmov.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-cve-2008-7247.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/mysql-expired-certs.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail

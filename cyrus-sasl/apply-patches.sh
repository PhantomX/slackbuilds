
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.18-no_rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.20-saslauthd.conf-path.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.21-sizes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-typo.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-digest-commas.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-automake-1.10.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.21-keytab.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-warnings.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-current-db.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-ldap-timeout.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-bad-elif.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-ac-quote.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-race.patch

set +e +o pipefail

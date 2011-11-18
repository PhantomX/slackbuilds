
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-no_rpath.patch
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.20-saslauthd.conf-path.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.21-sizes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-ldap-timeout.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-race.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-rimap2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-relro.patch
### Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-db-5.0.patch

set +e +o pipefail


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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-sasldb_al.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-saslauthd_libtool.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-avoid_pic_overwrite.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-autotools_fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-as_needed.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-missing_header.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-gssapi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-lib_before_plugin.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-fix_heimdal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-auxprop.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-gss_c_nt_hostbased_service.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-db-5.0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-get_fqhostname.patch

set +e +o pipefail

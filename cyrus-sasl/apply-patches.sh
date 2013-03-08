
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-no_rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.20-saslauthd.conf-path.patch
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.21-sizes.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.22-kerberos4.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-warnings.patch
zcat ${SB_PATCHDIR}/cyrus-sasl-2.1.22-ldap-timeout.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-relro.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=816250
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-null-crypt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-release-server_creds.patch
# AM_CONFIG_HEADER is obsolete, use AC_CONFIG_HEADERS instead
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-obsolete-macro.patch
# missing size_t declaration in sasl.h
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.26-size_t.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-sasldb_al.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-saslauthd_libtool.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-avoid_pic_overwrite.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-autotools_fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-as_needed.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-missing_header.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-fix_heimdal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-auxprop.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.23-gss_c_nt_hostbased_service.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cyrus-sasl-2.1.25-service_keytabs.patch

set +e +o pipefail

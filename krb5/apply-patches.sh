
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-selinux-label.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ksu-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ktany.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-buildconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.1-dns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kprop-mktemp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.4-send-pr-tempfile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-api.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-doublelog.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kpasswd_tcp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-dirsrv-accountlock.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.9-debuginfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-kvno-230379.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-kpasswdtest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-no-malloc0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-ignore-empty-unnecessary-final-token.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-gss_oid_leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-keytab_close.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-copy_context.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-spnego_error_messages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-enable-NX.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-pic-aes-ni.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-ksu-access.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-ksu-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.7-ktany.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-buildconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.1-dns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kprop-mktemp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.4-send-pr-tempfile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.8-api.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-doublelog.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kpasswd_tcp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-selinux-label.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-dirsrv-accountlock.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-pkinit-debug.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.9-debuginfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-kvno-230379.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-alpha1-init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-gss-client-keytab.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-cccol-primary.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11.2-empty_passwords.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11.2-arcfour_short.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11.2-skew1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11.2-skew2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-test_gss_no_udp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-test_no_pmap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-init_referral.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11.3-skew3.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

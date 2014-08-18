
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-In-ksu-merge-krb5_ccache_copy-and-_restricted.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-In-ksu-don-t-stat-not-on-disk-ccache-residuals.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Use-an-intermediate-memory-cache-in-ksu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Make-ksu-respect-the-default_ccache_name-setting.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Copy-config-entries-to-the-ksu-target-ccache.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-Use-more-randomness-for-ksu-secondary-cache-names.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Make-krb5_cc_new_unique-create-DIR-directories.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-pwdch-fast.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12.1-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-selinux-label.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ksu-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ktany.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-buildconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.1-dns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kprop-mktemp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.4-send-pr-tempfile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-api.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.10-kpasswd_tcp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-dirsrv-accountlock.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.9-debuginfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-kvno-230379.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-run_user_0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-kpasswdtest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-rcache-internal-const.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-rcache-acquirecred-cleanup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-rcache-acquirecred-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-rcache-acquirecred-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-move-otp-sockets.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-master-mechd.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

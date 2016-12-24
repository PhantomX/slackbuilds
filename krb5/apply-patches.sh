
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12.1-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.15-beta1-selinux-label.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ksu-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-ktany.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.15-beta1-buildconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.3.1-dns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.12-api.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.13-dirsrv-accountlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.9-debuginfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-run_user_0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krb5-1.11-kpasswdtest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Build-with-Werror-implicit-int-where-supported.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

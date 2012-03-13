
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# patches for 2.4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-slapd-conf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-security-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-sql-linking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-reentrant-gethostby.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-smbk5pwd-overlay.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-ldaprc-currentdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-userconfig-setgid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-dns-priority.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-syncrepl-unset-tls-options.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-constraint-count.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-man-sasl-nocanon.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/openldap-2.0.11-ldaprc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openldap-2.2.13-setugid.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openldap-2.4.6-pie.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openldap-2.4.6-nosql.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openldap-2.3.19-gethostbyXXXX_r.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/openldap-2.4.6-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openldap-2.4.16-doc-cacertdir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openldap-2.4.21-dn2id-segfault.patch

set +e +o pipefail

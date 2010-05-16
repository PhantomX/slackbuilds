
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

## upstream me!  -- Rex :)
zcat ${SB_PATCHDIR}/${NAME}-4.2.98-kdrc-icon.patch.gz | patch -p1 -E --backup --verbose
# rhbz#540433 - KPPP is unable to add DNS entries to /etc/resolv.conf
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-resolv-conf-path.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.2-kopete-searchbar_new_line.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-openssl.patch

## security patches
# rhbz#591966 -  CVE-2010-1000 CVE-2010-1511 kdenetwork: improper sanitization 
# of metalink attribute for downloading files
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-cve-2010-1000_1511.patch

set +e +o pipefail

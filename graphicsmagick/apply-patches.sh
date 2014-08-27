
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.3.14-perl_linkage.patch
# https://bugzilla.redhat.com/1064098
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.3.20-CVE-2014-1947.patch

set +e +o pipefail

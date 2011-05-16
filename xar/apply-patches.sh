
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xar-1.5-norpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xar-1.5.2-CVE-2010-0055.patch

set +e +o pipefail

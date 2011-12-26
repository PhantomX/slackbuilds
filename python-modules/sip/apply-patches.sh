
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sip-4.12.1-no_strip.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sip-4.13.1-no_rpath.patch

set +e +o pipefail

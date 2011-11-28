
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.6.2-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.6.8-syntax.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.6.9-logo.patch

set +e +o pipefail

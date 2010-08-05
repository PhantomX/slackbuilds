
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix CVE-2010-2536 (from Fedora)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_fix_CVE-2010-2536.patch

set +e +o pipefail

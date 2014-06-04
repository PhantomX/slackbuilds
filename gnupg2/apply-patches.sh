
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.16-tests-s2kcount.patch
patch -p1 -E --backup -z .secmem --verbose -i ${SB_PATCHDIR}/gnupg-2.0.20-secmem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.18-protect-tool-env.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.16-ocsp-keyusage.patch

## upstream patches

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

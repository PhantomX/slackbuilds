
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup -z .secmem --verbose -i ${SB_PATCHDIR}/gnupg-2.0.20-secmem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.1.1-ocsp-keyusage.patch

## upstream patches

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/11mark_trashed_as_read.patch.gz | patch -p1 -E --backup --verbose
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.11.1-segfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-internal-libical.patch
# This needs gnutls with system crypto-policies enabled
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-crypto-policies.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fixgtkcmctree.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

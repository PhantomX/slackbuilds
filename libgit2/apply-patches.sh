
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Add htonl() and friends declarations on non-x86 arches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgit2-0.19.0-non-x86.patch

set +e +o pipefail

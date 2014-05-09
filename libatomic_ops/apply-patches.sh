
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p1 -E --backup -z .shared --verbose -i ${SB_PATCHDIR}/libatomic_ops-shared.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p5 -E --backup --verbose -i ${SB_PATCHDIR}/libmng-stdio.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

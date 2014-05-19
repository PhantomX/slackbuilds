
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
# Arch FS#40044 - merged for branch 1.5
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-for-fontsproto213.patch
sed -i -e 's|fontsproto < 2.1.3|fontsproto >= 2.1.3|g' configure.ac

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

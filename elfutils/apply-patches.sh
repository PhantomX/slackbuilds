
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
#sed -i.scanf-m -e 's/%m/%a/' src/addr2line.c tests/line2addr.c || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elfutils-0.167-strip-alloc-symbol.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail

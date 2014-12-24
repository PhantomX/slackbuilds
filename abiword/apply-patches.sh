
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.0-librevenge.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.0-link-grammar-5.patch

# abiword documentation
( cd ${SRCDIR4}
  zcat ${SB_PATCHDIR}/${NAME}-2.6.0-windowshelppaths.patch.gz | patch -p1 -E --backup --verbose
)

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail

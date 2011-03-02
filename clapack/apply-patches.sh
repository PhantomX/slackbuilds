
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.1-noblasf2c.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.1-soname.patch

set +e +o pipefail

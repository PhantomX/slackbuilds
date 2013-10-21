
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-norootinst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.9-lsb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-linkfix.patch

set +e +o pipefail

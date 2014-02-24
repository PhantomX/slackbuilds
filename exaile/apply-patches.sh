
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.3.1-makefile.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.3.2-udisks.patch

set +e +o pipefail

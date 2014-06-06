
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-qt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-command-line-argument-parsing.patch

set +e +o pipefail

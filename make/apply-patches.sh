
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-getcwd.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-newlines.patch

set +e +o pipefail

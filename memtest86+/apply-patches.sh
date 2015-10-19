
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.01-hardcoded_cc.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.01-no-scp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.01-no-optimization.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.01-compile-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.01-crash-fix.patch
### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-5.patch

set +e +o pipefail

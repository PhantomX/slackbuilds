
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.34-Fix-range-check-in-JIT-path.patch

set +e +o pipefail

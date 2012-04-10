
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.30-Fix-look-behind-assertion-in-UTF-8-JIT-mode.patch

set +e +o pipefail

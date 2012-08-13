
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gptfdisk-0.8.1-gcc47.patch
[ "${SB_UTF}" = "YES" ] || patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gptfdisk.remove.icu4c.dep.diff

set +e +o pipefail

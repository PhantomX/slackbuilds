
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/c-ares-1.7.5-optflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/c-ares-multilib.patch

set +e +o pipefail

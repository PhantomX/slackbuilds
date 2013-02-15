
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Applied upstream (BZ#690214)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsel-1.2.0-MAX_NUM_TARGETS.patch
# Upstream: https://github.com/kfish/xsel/commit/ba8656dc7c7e771c802fc957ce3dd128d4b6e3ae
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsel-1.2.0-fix-large-pastes.patch

set +e +o pipefail


set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# upstream patches
# fix Kompare "malformed diff" false positives (kde#249976)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdesdk-4.5.3-kompare-kde\#249976.patch

set +e +o pipefail

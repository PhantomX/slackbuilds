
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-fix-rpath-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Ensure-the-PulseAudio-envrionment-is-set-up-when-run.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-really-fix-rpath-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rootDir.patch

set +e +o pipefail

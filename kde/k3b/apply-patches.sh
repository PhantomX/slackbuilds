
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream bug: https://bugs.kde.org/show_bug.cgi?id=238819
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0_settings-crash.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.1-sndfile-inc.patch

set +e +o pipefail

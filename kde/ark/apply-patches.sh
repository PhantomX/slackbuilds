
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# libkerfuffle namelink_skip
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ark-4.7.80-namelink_skip.patch
# https://git.reviewboard.kde.org/r/107634/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ark-4.9.97-improve_subfolder_autodetection.patch
# https://git.reviewboard.kde.org/r/106294/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ark-unar-06.patch

# Applications/14.12 branch
# https://bugs.kde.org/show_bug.cgi?id=341187
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Stop-crashing-on-exit-when-being-used-solely-as-a-KP.patch

set +e +o pipefail
